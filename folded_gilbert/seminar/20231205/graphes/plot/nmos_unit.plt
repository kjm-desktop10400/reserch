set datafile separator ","
#set multiplot

#set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{in} [V]" font "Arial,30" offset 0,-1.5
set ylabel "I_{d} [mA]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 20,-5
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set xtics offset 0 , -0.8
set ytics offset 0 , 0
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

input = "..\\data\\nmos_unit.vcsv"

set xrange[0 : 1.8]
set yrange[ : ]

set label 1 center at graph 0.5 , 0.04 "approx 0.6 V" font "Arial,25"

plot   input skip 6 using 1  : ($2) * 1e3  black with lines title "I_{d}"

A = 1;
B = 1;

f(x) = A *x + B

fit [0.8 : 1] f(x) input skip 6 using 1 : 2 via A, B 

set yrange[0 : ]
replot f(x) * 1e3 with lines dt "-" black title "approximate"

replot "..\\data\\dot.data" using 1 : 2  pt 7 black notitle 


pause -1