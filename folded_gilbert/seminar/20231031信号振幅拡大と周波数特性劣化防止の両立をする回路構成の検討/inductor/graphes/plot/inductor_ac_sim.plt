set datafile separator ","
#set multiplot

set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-1.5
set ylabel "magnitude [dB]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 20,5
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

input = "..\\data\\inductor_ac.vcsv"

set xrange[1e8 : 3e10]
set yrange[-20 : 20]

plot   input skip 6 using 1  : 2  black with lines notitle 
replot input skip 6 using 3  : 4  black with lines notitle 
replot input skip 6 using 5  : 6  black with lines notitle 
replot input skip 6 using 7  : 8  black with lines notitle 
replot input skip 6 using 9  : 10 black with lines notitle 

pause -1