#set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "g_{m} [mS]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top right spacing 2 offset -10,-2
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

input = "gm-Vgs_L_054_W_20.dat"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot input using 1 : (($2) * y_scale) with lines title ""
#replot input skip 6 using ($3 ) : ($4 ) * y_scale with lines title "L : 1.0 um"
#replot input skip 6 using ($5 ) : ($6 ) * y_scale with lines title "L : 1.5 um"
#replot input skip 6 using ($7 ) : ($8 ) * y_scale with lines title "L : 2.0 um"
#replot input skip 6 using ($9 ) : ($10) * y_scale with lines title "L : 2.5 um"
#replot input skip 6 using ($11) : ($12) * y_scale with lines title "L : 3.0 um"
#replot input skip 6 using ($13) : ($14) * y_scale with lines title "L : 3.5 um"
#replot input skip 6 using ($15) : ($16) * y_scale with lines title "L : 4.0 um"
#replot input skip 6 using ($17) : ($18) * y_scale with lines title "L : 4.5 um"
#replot input skip 6 using ($19) : ($20) * y_scale with lines title "L : 5.0 um"

f(x) = A * x + B
A = 100e-6
B = -1e-3

fit [0.69 : 0.71] f(x) input via A, B
replot (f(x) * y_scale) with lines notitle

pause -1