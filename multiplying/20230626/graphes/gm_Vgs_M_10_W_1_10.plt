#set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{gs} [V]" font "Arial,30" offset 0,-1
set ylabel "g_{m} [mS]" font "Arial,30" offset -8,0
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
#       M = 10
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

#plot   "gm_Vgs_M_10_W_1_10.dat" skip 6 using 1 : ($2 ) * y_scale with lines title "" #sprintf("W = %.1f um", 10  )
#replot ""                       skip 6 using 1 : ($3 ) * y_scale with lines title "" #sprintf("W = %.1f um", 20  )
#replot ""                       skip 6 using 1 : ($4 ) * y_scale with lines title "" #sprintf("W = %.1f um", 30  )
#replot ""                       skip 6 using 1 : ($5 ) * y_scale with lines title "" #sprintf("W = %.1f um", 40  )
#replot ""                       skip 6 using 1 : ($6 ) * y_scale with lines title "" #sprintf("W = %.1f um", 50  )
#replot ""                       skip 6 using 1 : ($7 ) * y_scale with lines title "" #sprintf("W = %.1f um", 60  )
#replot ""                       skip 6 using 1 : ($8 ) * y_scale with lines title "" #sprintf("W = %.1f um", 70  )
#replot ""                       skip 6 using 1 : ($9 ) * y_scale with lines title "" #sprintf("W = %.1f um", 80  )
#replot ""                       skip 6 using 1 : ($10) * y_scale with lines title "" #sprintf("W = %.1f um", 90  )
#replot ""                       skip 6 using 1 : ($11) * y_scale with lines title "" #sprintf("W = %.1f um", 100 )
#replot ""                       skip 6 using 1 : ($12) * y_scale with lines title "" #sprintf("W = %.1f um", 110 )
#replot ""                       skip 6 using 1 : ($13) * y_scale with lines title "" #sprintf("W = %.1f um", 120 )
#replot ""                       skip 6 using 1 : ($14) * y_scale with lines title "" #sprintf("W = %.1f um", 130 )
#replot ""                       skip 6 using 1 : ($15) * y_scale with lines title "" #sprintf("W = %.1f um", 140 )
#replot ""                       skip 6 using 1 : ($16) * y_scale with lines title "" #sprintf("W = %.1f um", 150 )
#replot ""                       skip 6 using 1 : ($17) * y_scale with lines title "" #sprintf("W = %.1f um", 160 )
#replot ""                       skip 6 using 1 : ($18) * y_scale with lines title "" #sprintf("W = %.1f um", 170 )
#replot ""                       skip 6 using 1 : ($19) * y_scale with lines title "" #sprintf("W = %.1f um", 180 )
#replot ""                       skip 6 using 1 : ($20) * y_scale with lines title "" #sprintf("W = %.1f um", 190 )
#replot ""                       skip 6 using 1 : ($21) * y_scale with lines title "" #sprintf("W = %.1f um", 200 )
 
f(x) = g * x + i
g = 100e-6
i = 1e-3
vth = 0.424192

do for[i = 1 : 20]{
    fit [vth : 0.8] f(x) "gm_Vgs_M_10_W_1_10.dat" skip 6 using 1 : (i + 1) via g, i
    save fit sprintf("fitlog/%d.fitlog",i);
}

#fit [vth : 0.8] f(x) "gm_Vgs_M_10_W_1_10.dat" skip 6 using 1 : ($2 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($3 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($4 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($5 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($6 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($7 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($8 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($9 ) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($10) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($11) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($12) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($13) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($14) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($15) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($16) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($17) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($18) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($19) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($20) via g, i
#fit [vth : 0.8] f(x) ""                       skip 6 using 1 : ($21) via g, i