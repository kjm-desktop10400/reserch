set datafile separator ","
#set multiplot

#set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "v_{in} [V]" font "Arial,30" offset 0,-1.5
set ylabel "v_{out} [V]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 35,5
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set xtics offset 0 , -0.8
set ytics offset 0 , 0
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

input = "..\\data\\previous_dc.vcsv"

#set xrange[1e6 : 1e12]
set yrange[-0.6 : 0.6]

plot   input skip 6 using 1  : 2   with lines title  "VCTRL = 20  mV" 
replot input skip 6 using 3  : 4   with lines title  "VCTRL = 40  mV" 
replot input skip 6 using 5  : 6   with lines title  "VCTRL = 60  mV" 
replot input skip 6 using 7  : 8   with lines title  "VCTRL = 80  mV" 
replot input skip 6 using 9  : 10  with lines title  "VCTRL = 10  mV" 
replot input skip 6 using 11 : 12  with lines title  "VCTRL = 120 mV" 
replot input skip 6 using 13 : 14  with lines title  "VCTRL = 140 mV" 
replot input skip 6 using 15 : 16  with lines title  "VCTRL = 160 mV" 
replot input skip 6 using 17 : 18  with lines title  "VCTRL = 180 mV" 
replot input skip 6 using 19 : 20  with lines title  "VCTRL = 200 mV" 

pause -1