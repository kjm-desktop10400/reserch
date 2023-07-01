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
y_scale = 1e3

input = "Id-Vgs_L054_W20_M1_Vsb0-07.vcsv"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot   input skip 6 using 1  : (sqrt($2 ) * y_scale) with lines title "Vsb : 0   V"
replot input skip 6 using 3  : (sqrt($4 ) * y_scale) with lines title "Vsb : 0.2 V"
replot input skip 6 using 5  : (sqrt($6 ) * y_scale) with lines title "Vsb : 0.7 V"



pause -1