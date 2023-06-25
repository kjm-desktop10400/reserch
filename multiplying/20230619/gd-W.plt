#set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "W [um]" font "Arial,30" offset 0,-1
set ylabel "g{d} [uS]" font "Arial,30" offset -12,0
set key font"Arial,25"
set key top left spacing 3 offset 35,-2
set terminal windows size 1000,700
set lmargin 28
set rmargin 5
set bmargin 5
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

#set xrange[0.6 : 4]
#set yrange[0 : 5e-7]

plot "gd-W.dat" skip 1 using ($1)*1e6 : ($2)*1e6 title "g{d}"

f(x) = A * x + B
A = 1
B = 1

fit [1e-6 : 9.8e-6] f(x) "gd-W.dat" skip 1 using 1 : 2 via  A, B

replot [1 : 10] f(x) title sprintf("%f * W - %f", A, -1 * B)