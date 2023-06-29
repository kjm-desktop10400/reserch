set datafile separator ","
#set yrange [0:4e-4]
#set xrange [0.4 : 1] 

set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3

set key font"Arial,20"
set key bottom spacing 2 offset 0, 2

set tics font "Arial,30"
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set ylabel "Id [A]" font "Arial,30" offset -20,0
set xlabel "Vgs [V]" font "Arial,30" offset -10,-3

plot "specter_output.vcsv" skip 6 using 1 : 2 with lines title "Id"
replot "specter_output.vcsv" skip 6 using 1 : 3 with lines title "gm"


#Id(x) = K * (W / L) * ((x - Vth)**2) * (1 + lambda * Vds)
#W = 1e-6
#L = 1e-6
#Vds = 0.9
#
#K = 7e-5
#Vth = 0.42
#lambda = 0.4
#
#fit [0.4 : 0.8] Id(x) "specter_output.vcsv" skip 6 using 1 : 2 via K, Vth, lambda
#replot [0.4 : 1] Id(x)  title "approximate"

Id(x) = K * (W / L) * ((0.65 - Vth)**2) * (1 + lambda * x)
W = 1e-6
L = 1e-6
Vds = 0.9

K = 7e-5
Vth = 0.42
lambda = 0.4

fit [0.2  : 0.8] Id(x) "specter_output.vcsv" skip 6 using 1 : 2 via K, Vth, lambda
replot [0 : 1] Id(x)  title "approximate"


#f(x) = a * x + b
#fit [-1e-2 : 1e-2] f(x) "specter_output.vcsv" skip 6 using 1 : 2 via a , b
#replot f(x) with lines 

#pause -1