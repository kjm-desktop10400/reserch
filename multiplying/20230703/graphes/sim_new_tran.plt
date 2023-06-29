set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "time [ns]" font "Arial,30" offset 0,-1
set ylabel "V_{out} [mV]" font "Arial,30" offset -8,0
set y2label "V_{in} [V]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 3 offset 20,-2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set ytics 50
set y2tics 0.05
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set yrange [0 : 300]


x_scale = 1e9
y1_scale = 1e3
y2_scale = 1e0

plot "sim_new_tran.vcsv" skip 6 using ($1) * x_scale : ($2) * y1_scale axis x1y1 with lines title "v_{out}"
replot ""                skip 6 using ($3) * x_scale : ($4) * y2_scale axis x1y2 with lines title "v_{in}"

#pause -1