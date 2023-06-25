#set datafile separator ","

set terminal wxt enhanced

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "L [{/symbol m}m]" font "Arial,30" offset 0,-1
set ylabel "g{d} [uS]" font "Arial,30" offset -12,0
set key font"Arial,25"
set key top right spacing 4 offset -5,-3
set terminal windows size 1000,700
set lmargin 28
set rmargin 5
set bmargin 6
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange[0 : 4]
set yrange[0 : 0.5]

plot "gd-L.dat" skip 2 using ($1)*1e6 : ($2) * 1e6 title "g{d}"

f(x) = C / (x**2)
C = 1

fit f(x) "gd-L.dat" skip 2 using 1 : 2 via C

replot (f(x * 1e-6) * 1e6) title sprintf("C / (x^2)")
