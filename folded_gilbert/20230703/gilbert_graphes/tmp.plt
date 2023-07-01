set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "sqrt I_{D} [mA^{1/2}]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 10,-2
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

#set xrange [0 : 1]
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
y_scale = 1e3

input = "Id-Vgs_L054_W20_M1-20.vcsv"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot   input skip 6 using 1  : (sqrt($2 ) * y_scale) with lines title "M : 1 "
replot input skip 6 using 3  : (sqrt($4 ) * y_scale) with lines title "M : 2 "
replot input skip 6 using 5  : (sqrt($6 ) * y_scale) with lines title "M : 3 "
replot input skip 6 using 7  : (sqrt($8 ) * y_scale) with lines title "M : 4 "
replot input skip 6 using 9  : (sqrt($10) * y_scale) with lines title "M : 5 "
replot input skip 6 using 11 : (sqrt($12) * y_scale) with lines title "M : 6 "
replot input skip 6 using 13 : (sqrt($14) * y_scale) with lines title "M : 7 "
replot input skip 6 using 15 : (sqrt($16) * y_scale) with lines title "M : 8 "
replot input skip 6 using 17 : (sqrt($18) * y_scale) with lines title "M : 9 "
replot input skip 6 using 19 : (sqrt($20) * y_scale) with lines title "M : 10"
replot input skip 6 using 21 : (sqrt($22) * y_scale) with lines title "M : 11"
replot input skip 6 using 23 : (sqrt($24) * y_scale) with lines title "M : 12"
replot input skip 6 using 25 : (sqrt($26) * y_scale) with lines title "M : 13"
replot input skip 6 using 27 : (sqrt($28) * y_scale) with lines title "M : 14"
replot input skip 6 using 29 : (sqrt($30) * y_scale) with lines title "M : 15"
replot input skip 6 using 31 : (sqrt($32) * y_scale) with lines title "M : 16"
replot input skip 6 using 33 : (sqrt($34) * y_scale) with lines title "M : 17"
replot input skip 6 using 35 : (sqrt($36) * y_scale) with lines title "M : 18"
replot input skip 6 using 37 : (sqrt($38) * y_scale) with lines title "M : 19"
replot input skip 6 using 39 : (sqrt($40) * y_scale) with lines title "M : 20"

f(x) = A * x + B
A = 100e-6
B = -1e-3

#fit [0.69 : 0.71] f(x) input via A, B
#set yrange[0 : ]
#replot (f(x) * y_scale) with lines notitle

pause -1