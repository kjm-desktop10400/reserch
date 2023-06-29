set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{in} [mV]" font "Arial,30" offset 0,-1
set ylabel "V_{out} [mV]" font "Arial,30" offset -8,0
set key font"Arial,25"
set key top left spacing 1.5 offset 20,-2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

###################################################################
#       M = 6
#       L = 0.54u
#       W = 15.5u
#       vds
#       Vgs
#       Vd
#
#       vin = -150m ~ 150m
#
###################################################################

x_scale = 1e3
y_scale = 1e3

#set xrange [0.3 : 1]

plot "sim_new_dc.vcsv" skip 6 using ($1) * x_scale : ($2) * y_scale with lines title "" #sprintf("W = %.1f um", 10  )
 

pause -1