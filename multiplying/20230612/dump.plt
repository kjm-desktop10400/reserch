set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vout [V]" font "Arial,30" offset 0,-3
set ylabel "i1 [A]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top left spacing 2 offset 10, -2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1


vth(x) = 0.167781 * x + 0.424192
I(x) = 50 * ( 0.9 - x - vth(x) )**2 - x / 50

set xrange [0.0 : 0.9]
plot I(x) title ""

#set table "i_1-v_out.txt"
#plot I(x)