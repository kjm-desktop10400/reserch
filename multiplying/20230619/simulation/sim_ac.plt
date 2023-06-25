set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "f [Hz]" font "Arial,30" offset 0,-1
set ylabel "V [dB]" font "Arial,30" offset -12,0
set key font"Arial,15"
set key top left spacing 1.5 offset 5,0
set terminal windows size 1000,700
set lmargin 28
set rmargin 25
set bmargin 5
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set y2label "phase [deg]" font "Arial,30"

set logscale x

#set yrange [0.07 : 0.15]

plot   "sim_ac.vcsv" axis x1y1 skip 7 using 3 : 4 with lines title "v_{out}"
replot "" axis x1y2 skip 7 using 1 : 2 with lines title "phase"
