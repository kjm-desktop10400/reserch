set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "v_{in} [V]" font "Arial,30" offset 0,-1
set ylabel "v_{out} [V]" font "Arial,30" offset -8,0
#set y2label "g_{m} [uS]" font "Arial,30" offset 8,0
set key font"Arial,20"
set key top left spacing 2 offset 15,0
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set ytics
#set y2tics 150
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange [-0.3 : 0.3]
set yrange [-1.5 : 1.5]
#set y2range [0 : 750]

y_scale = 1e0

input = "prev_dc.vcsv"

plot   input skip 6 using 1  : ($2)  * y_scale with lines title sprintf("VCTRL :   %d [mV]", 50)
replot input skip 6 using 3  : ($4)  * y_scale with lines title sprintf("VCTRL : %d [mV]", 100 )
replot input skip 6 using 5  : ($6)  * y_scale with lines title sprintf("VCTRL : %d [mV]", 150 )
replot input skip 6 using 7  : ($8)  * y_scale with lines title sprintf("VCTRL : %d [mV]", 200 )
replot input skip 6 using 9  : ($10) * y_scale with lines title sprintf("VCTRL : %d [mV]", 250 )
replot input skip 6 using 11 : ($12) * y_scale with lines title sprintf("VCTRL : %d [mV]", 300 )
replot input skip 6 using 13 : ($14) * y_scale with lines title sprintf("VCTRL : %d [mV]", 350 )
replot input skip 6 using 15 : ($16) * y_scale with lines title sprintf("VCTRL : %d [mV]", 400 )

pause -1