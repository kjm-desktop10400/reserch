set datafile separator ","
#set multiplot

set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-1.5
set ylabel "magnitude [dB]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top right spacing 2.5 offset 0,-1
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

input = "..\\data\\acout.vcsv"

set xrange[1e6 : 1e12]
set yrange[-40 : 5]

set label 1  center at graph 0.2  , 0.42 "V_{CTRL} = 20  mV" font ", 20"
set label 2  center at graph 0.2  , 0.55 "           40  mV" font ", 20"
set label 3  center at graph 0.2  , 0.63 "           60  mV" font ", 20"
set label 4  center at graph 0.2  , 0.69 "           80  mV" font ", 20"
set label 5  center at graph 0.2  , 0.99 "                 " font ", 20"
set label 6  center at graph 0.2  , 0.99 "                 " font ", 20"
set label 7  center at graph 0.2  , 0.99 "                 " font ", 20"
set label 8  center at graph 0.2  , 0.99 "                 " font ", 20"
set label 9  center at graph 0.2  , 0.99 "                 " font ", 20"
set label 10 center at graph 0.2  , 0.93 "           200 mV" font ", 20"


plot   input skip 6 using 1  : 2  black with lines notitle # "VCTRL =  20 mV"
replot input skip 6 using 3  : 4  black with lines notitle # "VCTRL =  40 mV"
replot input skip 6 using 5  : 6  black with lines notitle # "VCTRL =  60 mV"
replot input skip 6 using 7  : 8  black with lines notitle # "VCTRL =  80 mV"
replot input skip 6 using 9  : 10 black with lines notitle # "VCTRL = 100 mV"
replot input skip 6 using 11 : 12 black with lines notitle # "VCTRL = 120 mV"
replot input skip 6 using 13 : 14 black with lines notitle # "VCTRL = 140 mV"
replot input skip 6 using 15 : 16 black with lines notitle # "VCTRL = 160 mV"
replot input skip 6 using 17 : 18 black with lines notitle # "VCTRL = 180 mV"
replot input skip 6 using 19 : 20 black with lines notitle # "VCTRL = 200 mV"



pause -1