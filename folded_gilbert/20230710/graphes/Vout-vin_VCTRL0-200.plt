set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{in} [mV]" font "Arial,30" offset 0,-1
set ylabel "v_{out} [mV]" font "Arial,30" offset -8,0
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

set xrange [-0.2 : 0.2]
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

x_scale = 1e0
y_scale = 1e0

input = "gilbert_out.vcsv"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot   input skip 6 using ($1) * x_scale : (($2 ) * y_scale) with lines title "V_{CTRL} : 0   mV"
replot input skip 6 using ($1) * x_scale : (($4 ) * y_scale) with lines title "V_{CTRL} : 40  mV"
replot input skip 6 using ($1) * x_scale : (($6 ) * y_scale) with lines title "V_{CTRL} : 80  mV"
replot input skip 6 using ($1) * x_scale : (($8 ) * y_scale) with lines title "V_{CTRL} : 120 mV"
replot input skip 6 using ($1) * x_scale : (($10) * y_scale) with lines title "V_{CTRL} : 160 mV"
replot input skip 6 using ($1) * x_scale : (($12) * y_scale) with lines title "V_{CTRL} : 200 mV"

KA = 1e-3 / ((0.8 - 0.59)**2)
RL = 300
vout(x, y) = 4 * RL * KA * y * x

#replot vout(x, 0   * 1e-3) with lines dt (10, 20) title ""
#replot vout(x, 40  * 1e-3) with lines dt (10, 20) title ""
#replot vout(x, 80  * 1e-3) with lines dt (10, 20) title ""
#replot vout(x, 120 * 1e-3) with lines dt (10, 20) title ""
#replot vout(x, 160 * 1e-3) with lines dt (10, 20) title ""
#replot vout(x, 200 * 1e-3) with lines dt (10, 20) title ""

pause -1