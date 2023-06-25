set xlabel "Vgs" font "Arial,30" offset 0,-3
set ylabel "Id" font "Arial,30" offset -30,0
set tics font "Arial,30"
set key font"Arial,20"
set lmargin 50
set rmargin 5
set bmargin 8
set tmargin 3 
set key bottom spacing 1.9 offset 0, 2
set xtics 0.2 offset -3, -1
#set ytics 2e-6
set mxtics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set xrange [0.2 : 1]
set yrange [0 : 2e-5]
#set format y "%1.0t * 10^{%L}"
K = 1.4e-4
v = 0.3
l = 0.6
Id(x) = K * (x - v)**2 * (1 + l * 0.65)
fit [0.5 : 0.7] Id(x) "TSMC182n.txt" using 1 : 2 via K, v, l
plot "TSMC182n.txt" skip 1 using 1 : 2 title "Id" with lines
replot [0.4 : ] Id(x) title "estimated"
#replot 6.90046e-05 * (1 + 0.577403) * (x - v)**2 title "theorotical"
pause -1