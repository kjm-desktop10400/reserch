set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "Vds [V]" font "Arial,30" offset 0,-3
set ylabel "Id [A]" font "Arial,30" offset -20,0
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

set datafile separator ","

range_l = 0.4
range_r = 0.7

set dummy vds, lambda
array K[9]
array Vth[9]

i = 20

K = 1e-7
Vth = 0.42
L = i * 180e-9
lambda = 0.3
vgs = 0.75

I(vds) = K / L * (vgs - Vth)**2 * (1 + vds * lambda)

fit [0.3 : ] I(vds) "current_source_est_Lambda.vcsv" skip 6 using 2 * i - 1: 2 * i via K, lambda
save fit "fited_valiables.dat"

#plot "current_source_est_Lambda.vcsv" skip 6 using 2 * i - 1: 2 * i with lines title sprintf("%.2f um", i * 0.18)
#replot for[i = 2 : 10] "current_source_est_Lambda.vcsv" skip 6 using 2 * i - 1: 2 * i with lines title sprintf("%.2f um", i * 0.18)