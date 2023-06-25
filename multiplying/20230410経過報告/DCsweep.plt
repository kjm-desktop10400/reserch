set logscale x
set format x "1x10^{%L}"
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"set xlabel "Vin [V]" font "Arial,30" offset 0,-3
set ylabel "vout [V]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key bottom spacing 2 offset 0, 2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,30"
set xtics 0.1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
plot for [i = 1 : 5] "DCsweep.txt" using 2 * i - 1 : 2 * i with lines title sprintf("VCTRL : %d mV", 20 * i)