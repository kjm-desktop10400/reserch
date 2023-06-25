set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vin [V]" font "Arial,30" offset 0,-3
set ylabel "vout [V]" font "Arial,30" offset -10,0
set y2label "Id [mA]" font "Arial,30" offset 15,0
set key font"Arial,20"
set key bottom spacing 2 offset 0, 2
set lmargin 25
set rmargin 30
set bmargin 8
set tmargin 3
set tics font "Arial,25"
set xtics 0.05 offset -3, -1
set ytics 0.05
set y2tics 2e-4 * 10**3 offset 0, 0
set mxtics 5
set mytics 5
set my2tics 5
set grid xtics mxtics ytics y2tics linewidth 2, linewidth 1, linewidth 1, linewidth 1

set datafile separator ","

plot "buff_after.vcsv" skip 6 using 1 : 2 axis x1y1 with lines title "vout"
replot "buff_after.vcsv" skip 6 using 3 : ($4 * 10**3) axis x1y2 with lines title "Id"