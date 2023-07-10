#set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "g_{m} [uS]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 25,-2
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
#set yrange [0 : 50e-3]
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
y_scale = 1e6

input = "n_p_gm_Vgs.dat"

plot   input skip 6 using 1  : ((($2 )) * y_scale) with lines title "nmos"
replot input skip 6 using 1  : ((($3 )) * y_scale) with lines title "pmos"

f(x) = A * x + B
g(x) = C * x + D
A = C = 100e-6
B = D = -1e-3

fit [0.69 : 0.71] f(x) input skip 6 using 1  : (($2 )) via A, B 
fit [0.69 : 0.71] g(x) input skip 6 using 1  : (($3 )) via C, D 

set yrange[0 : ]

replot f(x) * y_scale with lines dt (5, 10) title sprintf("slope : %f", -1 * B / A)
replot g(x) * y_scale with lines dt (5, 10) title sprintf("slope : %f", -1 * D / C)

pause -1