set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "freq [Hz]" font "Arial,30" offset 0,-1
set ylabel "gain [dB]" font "Arial,30" offset -8,0
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
#       ac
#
###################################################################

#x_scale = 1e3
#y_scale = 1e3

#set xrange [0.3 : 1]

set logscale x

plot "sim_new_ac.vcsv" skip 6 using 3 : 4 with lines title "" #sprintf("W = %.1f um", 10  )
 

pause -1