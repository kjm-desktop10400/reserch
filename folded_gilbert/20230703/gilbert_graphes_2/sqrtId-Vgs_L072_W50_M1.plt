set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "sqrt I_{D} [mA^{1/2}]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 20,-2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
#set ytics
#set y2tics
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange [0 : 1]
set yrange [0 : ]
#set y2range [ : ]

###################################################################
#       M = 
#       L = 
#       W = 
#       vds
#       Vgs
#       Vbs
#
#       vin 
#
###################################################################

#x_scale = 1e3
y_scale = 1e3

input = "Id-Vgs_L072_W50_M1.vcsv"

plot   input skip 6 using 1  : (sqrt($2 ) * y_scale) with lines title "sqrt I_{D}"

f1(x) = A * x + B
#f2(x) = C * x + D
#f3(x) = E * x + F
#
fit [0.79 : 0.81] f1(x) input skip 6 using 1 : (sqrt($2 ) * y_scale) via A, B
#fit [0.69 : 0.71] f2(x) input skip 6 using 3 : (sqrt($4 ) * y_scale) via C, D
#fit [0.69 : 0.71] f3(x) input skip 6 using 5 : (sqrt($6 ) * y_scale) via E, F
#
replot f1(x) title sprintf("Vth : %f", -1 * B / A)
#replot f3(x) title sprintf("Vth : %f", -1 * F / E)
#replot f2(x) title sprintf("Vth : %f", -1 * D / C)

pause -1