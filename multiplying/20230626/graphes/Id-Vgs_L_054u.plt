set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{gs} [V]" font "Arial,30" offset 0,-1
set ylabel "I [mA]" font "Arial,30" offset -8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 20,-2
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
#       M = 1
#       L = 0.54u
#       W = 15u - 50u    step : 5u       (second argument)
#       vds = 1.8
#       Vgs = 0 - 0.9     step : 0.1m     (first argument)
#       Vd = 0
#
###################################################################

#x_scale = 1
y_scale = 1e3

set xrange[0.3 : ]

plot "Id-Vgs_L_054u.vcsv" skip 6 using 1  : ($2 ) * y_scale with lines title sprintf("W : %d um", 15 )
replot ""                 skip 6 using 3  : ($4 ) * y_scale with lines title sprintf("W : %d um", 20 )
replot ""                 skip 6 using 5  : ($6 ) * y_scale with lines title sprintf("W : %d um", 25 )
replot ""                 skip 6 using 7  : ($8 ) * y_scale with lines title sprintf("W : %d um", 30 )
replot ""                 skip 6 using 9  : ($10) * y_scale with lines title sprintf("W : %d um", 40 )
replot ""                 skip 6 using 11 : ($12) * y_scale with lines title sprintf("W : %d um", 45 )
replot ""                 skip 6 using 13 : ($14) * y_scale with lines title sprintf("W : %d um", 50 )

