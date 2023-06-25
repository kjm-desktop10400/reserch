set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vgs [V]" font "Arial,30" offset 0,-3
set ylabel "Id [A]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top left spacing 2 offset 15, 0
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,30"
set xtics 0.1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange [0.3 : 1]

range_l = 0.4
range_r = 0.7

set dummy vgs, arg
array K[9]
array Vth[9]

fK = 1e-7
fVth = 0.42

I(vgs) = fK * (vgs - fVth)**2

i = 1

fit [range_l : range_r] I(vgs) "current_source_estVth.vcsv" skip 6 using 2 * i - 1: 2 * i via fK, fVth
save fit "fited_valiables.dat"

plot "current_source_estVth.vcsv" skip 6 using 2 * i - 1: 2 * i with lines title sprintf("Vds=%.1fV", i * 0.1)
replot for[i = 2 : 9] "current_source_estVth.vcsv" skip 6 using 2 * i - 1: 2 * i with lines title sprintf("Vds=%.1fV", i * 0.1)

pause -1