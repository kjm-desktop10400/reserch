set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "L [um]" font "Arial,30" offset 0,-3
set ylabel "drain-transconductance [mS]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top right spacing 2 offset 0, 0
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,25"
set xtics 0.36 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set dummy L
S(L) = (L * 10**-3)**(delta + 1e-7 ) + b
delta = 1e-3
b = 0.05

fit S(L) "tmp.txt" via delta, b
plot "tmp.txt" with lines title "lambda"
#replot [0.18 : 3.6] S(L) with lines title "estimated" 