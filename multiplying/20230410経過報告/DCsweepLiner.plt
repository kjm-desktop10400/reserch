set xlabel "Vin [V]" font "Arial,30" offset 0,-3
set ylabel "vout [V]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key bottom spacing 2 offset 0, 2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3 
set xrange [-0.2 : 0.2]
set yrange [-0.2 : 0.2]
set tics font "Arial,30"
set xtics 0.1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
plot for [i = 1 : 5] "DCsweep.txt" using 2 * i - 1 : 2 * i with lines notitle
line1(x) = 0.2366 * x - 1.155e-07
line2(x) = 0.4873 * x - 2.389e-07
line3(x) = 0.7593 * x - 3.71e-07
line4(x) = 1.04 * x - 5.051e-07
line5(x) = 1.288 * x - 6.235e-07
replot line1(x) lc rgb "dark-magenta" dt 3 title sprintf("slope : 0.2366")
replot line2(x) lc rgb "web-green" dt 3 title sprintf("slope : 0.4873")
replot line3(x) lc rgb "dark-cyan" dt 3 title sprintf("slope : 0.7593")
replot line4(x) lc rgb "orange" dt 3 title sprintf("slope : 1.04")
replot line5(x) lc rgb "goldenrod" dt 3 title sprintf("slope : 1.288")