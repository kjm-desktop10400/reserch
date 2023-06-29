set datafile separator ","
set multiplot

#set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
#set tics font "Arial,30"
#set xlabel "freq [Hz]" font "Arial,30" offset 0,-1
#set ylabel "phase [deg]" font "Arial,30" offset -8,0
#set key font"Arial,25"
#set key top left spacing 1.5 offset 20,-2
#set terminal windows size 1000,700
#set lmargin 20
#set rmargin 20
#set bmargin 6
#set tmargin 2
#set tics font "Arial,25"
##set xtics 1 offset -3, -1
#set mxtics 5
#set mytics 5
#set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

###################################################################
#       M = 6
#       L = 0.54u
#       W = 15.5u
#       vds
#       Vgs
#       Vd
#
#       ac
#
###################################################################

#x_scale = 1e3
#y_scale = 1e3

#set xrange [0.3 : 1]


set logscale x
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xrange[1e6 : ]

set key font"Arial,20"
set key left bottom spacing 2 offset 20, 0
set format x ""
set ylabel "gain [dB]" font "Arial,30" offset -10,0
set ytics 0.4
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.6
plot "sim_new_ac.vcsv" skip 6 using 3 : 4 with lines notitle

set format x "1x10^{%L}"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-2
set ylabel "phase [deg]" font "Arial,30" offset -10,0
#set yrange [-360 : 10]
set xtics offset 0,-1
set ytics 3
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.55
set bmargin screen 0.15
plot "sim_new_ac.vcsv" skip 6 using 1 : 2 with lines notitle
 
#0pause -1
