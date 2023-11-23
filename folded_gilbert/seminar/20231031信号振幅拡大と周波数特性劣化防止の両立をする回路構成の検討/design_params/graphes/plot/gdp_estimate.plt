#set datafile separator ","
#set multiplot

set logscale x
set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "Length [um]" font "Arial,30" offset 0,-1.6
set ylabel "g_{dp} [uS]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 15,0
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
set xtics offset -3, -1
set ytics
#set y2tics 5
set mxtics 10
set mytics 10
set grid xtics mxtics ytics mytics linewidth 2, linewidth 1, linewidth 2, linewidth 1

set xrange[1e-1 : 1.1e1]
#set yrange[-2 : 5]

input = "..\\data\\gdp_L_fited.data"

plot input skip 1 using 1 : ($2) * 1e6 black with lines title ""

pause -1