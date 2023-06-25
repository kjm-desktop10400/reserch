set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vin [V]" font "Arial,30" offset 0,-1
set ylabel "I_{1} [mA]" font "Arial,30" offset -8,0
set key font"Arial,25"
set key top left spacing 3 offset 35,-1
set terminal windows size 1000,700
set lmargin 22
set rmargin 25
set bmargin 6
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

#set yrange [0.07 : 0.15]

plot   "sim_dc_W_71.vcsv" skip 6 using 3 : ($4)*1e3 with lines title ""

f(x) = A * x + B
A = 1
B = 1
fit f(x) "" skip 6 using 3 : 4 via A, B
replot [-0.15 : 0.15] f(x) * 1e3 title sprintf("%f * vgs + %f", A, B)

pause -1
