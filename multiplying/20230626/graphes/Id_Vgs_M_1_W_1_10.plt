set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{gs} [V]" font "Arial,30" offset 0,-1
set ylabel "I_{1} [mA]" font "Arial,30" offset -8,0
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
#       M = 1
#       L = 1u
#       W = 1u - 20u    step : 1u       (second argument)
#       vds = 1.8
#       Vgs = 0 - 1     step : 0.1m     (first argument)
#       Vd = 0
#
###################################################################

x_scale = 1
y_scale = 1e3

set xrange [0.3 : 1]

plot   "Id_Vgs_M_1_W_1_10.vcsv" skip 6 using 1  : ($2 ) * y_scale with lines title "" #sprintf("W = %.1f um", 1.0  )
replot ""                       skip 6 using 3  : ($4 ) * y_scale with lines title "" #sprintf("W = %.1f um", 2.0  )
replot ""                       skip 6 using 5  : ($6 ) * y_scale with lines title "" #sprintf("W = %.1f um", 3.0  )
replot ""                       skip 6 using 7  : ($8 ) * y_scale with lines title "" #sprintf("W = %.1f um", 4.0  )
replot ""                       skip 6 using 9  : ($10) * y_scale with lines title "" #sprintf("W = %.1f um", 5.0  )
replot ""                       skip 6 using 11 : ($12) * y_scale with lines title "" #sprintf("W = %.1f um", 6.0  )
replot ""                       skip 6 using 13 : ($14) * y_scale with lines title "" #sprintf("W = %.1f um", 7.0  )
replot ""                       skip 6 using 15 : ($16) * y_scale with lines title "" #sprintf("W = %.1f um", 8.0  )
replot ""                       skip 6 using 17 : ($18) * y_scale with lines title "" #sprintf("W = %.1f um", 9.0  )
replot ""                       skip 6 using 19 : ($20) * y_scale with lines title "" #sprintf("W = %.1f um", 10.0 )
replot ""                       skip 6 using 21 : ($22) * y_scale with lines title "" #sprintf("W = %.1f um", 11.0 )
replot ""                       skip 6 using 23 : ($24) * y_scale with lines title "" #sprintf("W = %.1f um", 12.0 )
replot ""                       skip 6 using 25 : ($26) * y_scale with lines title "" #sprintf("W = %.1f um", 13.0 )
replot ""                       skip 6 using 27 : ($28) * y_scale with lines title "" #sprintf("W = %.1f um", 14.0 )
replot ""                       skip 6 using 29 : ($30) * y_scale with lines title "" #sprintf("W = %.1f um", 15.0 )
replot ""                       skip 6 using 31 : ($32) * y_scale with lines title "" #sprintf("W = %.1f um", 16.0 )
replot ""                       skip 6 using 33 : ($34) * y_scale with lines title "" #sprintf("W = %.1f um", 17.0 )
replot ""                       skip 6 using 35 : ($36) * y_scale with lines title "" #sprintf("W = %.1f um", 18.0 )
replot ""                       skip 6 using 37 : ($38) * y_scale with lines title "" #sprintf("W = %.1f um", 19.0 )
replot ""                       skip 6 using 39 : ($40) * y_scale with lines title "" #sprintf("W = %.1f um", 20.0 )
 
#f(x) = g * x + i

#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 1  : ($2 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 3  : ($4 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 5  : ($6 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 7  : ($8 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 9  : ($10) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 11 : ($12) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 13 : ($14) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 15 : ($16) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 17 : ($18) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 19 : ($20) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 21 : ($22) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 23 : ($24) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 25 : ($26) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 27 : ($28) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 29 : ($30) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 31 : ($32) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 33 : ($34) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 35 : ($36) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 37 : ($38) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 39 : ($40) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 41 : ($42) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 43 : ($44) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 45 : ($46) via g, i
