set datafile separator ","
#set multiplot

#set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "Vds [V]" font "Arial,30" offset 0,-1.6
set ylabel "current [uA]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 15,0
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
set xtics 0.1 offset -3, -1
set ytics
#set y2tics 5
set mxtics 10
set mytics 10
set grid xtics mxtics ytics  linewidth 2, linewidth 1, linewidth 1

set xrange[ : 0.7]
#set yrange[-2 : 5]

input = "..\\data\\ibias_unit_sim.vcsv"

plot   input skip 6 using 1  : ($2 ) * 1e6 black with lines title "vgs = 0.1 V"
replot input skip 6 using 3  : ($4 ) * 1e6 black with lines title "vgs = 0.2 V"
replot input skip 6 using 5  : ($6 ) * 1e6 black with lines title "vgs = 0.3 V"
replot input skip 6 using 7  : ($8 ) * 1e6 black with lines title "vgs = 0.4 V"
replot input skip 6 using 9  : ($10) * 1e6 black with lines title "vgs = 0.5 V"
replot input skip 6 using 11 : ($12) * 1e6 black with lines title "vgs = 0.6 V"
replot input skip 6 using 13 : ($14) * 1e6 black with lines title "vgs = 0.7 V"
replot input skip 6 using 15 : ($16) * 1e6 black with lines title "vgs = 0.8 V"
replot input skip 6 using 17 : ($18) * 1e6 black with lines title "vgs = 0.9 V"
replot input skip 6 using 19 : ($20) * 1e6 black with lines title "vgs = 1.0 V"


pause -1