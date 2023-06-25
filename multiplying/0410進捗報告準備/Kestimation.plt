set xrange [0 : 1]
set xlabel "Vgs"
set ylabel "Id"
K = 7e-5
v = 0.5
l = 0.5
Id(x) = K * (x - v)**2 * (1 + l*0.4)
fit [0.4:] Id(x) "TSMC182n.txt" using 1 : 2 via K, v, l
plot Id(x) title "estimated"
replot "TSMC182n.txt" skip 1 using 1 : 2 title "Id" with lines
#replot 6.90046e-05 * (1 + 0.577403) * (x - v)**2 title "theorotical"
pause -1