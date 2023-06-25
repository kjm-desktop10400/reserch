set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "time [ns]" font "Arial,30" offset 0,-1
set ylabel "V [V]" font "Arial,30" offset -12,0
set key font"Arial,15"
set key top left spacing 1.5 offset 15,0
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

#set yrange [0.07 : 0.15]

plot "sim_tran.vcsv" skip 6 using ($1) * 1e9 : 2 with lines title "v_{out}"