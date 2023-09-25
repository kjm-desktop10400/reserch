#set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "g_{m} [uS]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top center spacing 2.5 offset 10,-2
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
#       M = 1
#       L = 0.72u
#       W = 20u
#       vds = 1
#       Vgs = 0 - 1
#       Vbs = 0
#
#       vin = vgs
#
###################################################################

#x_scale = 1e3
y_scale = 1e6

input = "data\\pmos_gm-vgs.dat"

plot   input using 1  : (($2 ) * y_scale) with lines title ""

f(x) = A * x + B
#g(x) = C * x + D
A = C = 100e-6
B = D = -1e-3
#
fit [0.6 : 0.8] f(x) input using 1  : (($2 )) via A, B 
#fit [0.6 : 0.8] g(x) input skip 6 using 3  : (sqrt($4 )) via C, D 

set yrange[0 :  ]
set xrange[0 : 1]
replot f(x) * y_scale title sprintf("slope : %f [mS/V]\n\n\n Vth : %f [V]", A*1e3, -1 * B / A)

pause -1