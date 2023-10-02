set datafile separator ","

set logscale x

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "freq [Hz]" font "Arial,30" offset 0,-2
set ylabel "v_{out} [dB]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 20,2
set key opaque
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
set xtics offset -3, -1
set ytics
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange[1e6:]
set yrange[-30:5]

input = "..\\data\\F_gd_ac.vcsv"

plot   input skip 6 using   1   : ($2 ) with lines linewidth 3 title "RL : 30 "
replot input skip 6 using ($3 ) : ($4 ) with lines linewidth 3 title "RL : 60 "
replot input skip 6 using ($5 ) : ($6 ) with lines linewidth 3 title "RL : 90 "
replot input skip 6 using ($7 ) : ($8 ) with lines linewidth 3 title "RL : 120"
replot input skip 6 using ($9 ) : ($10) with lines linewidth 3 title "RL : 150"
replot input skip 6 using ($11) : ($12) with lines linewidth 3 title "RL : 180"
replot input skip 6 using ($13) : ($14) with lines linewidth 3 title "RL : 210"
replot input skip 6 using ($15) : ($16) with lines linewidth 3 title "RL : 240"
replot input skip 6 using ($17) : ($18) with lines linewidth 3 title "RL : 270"
replot input skip 6 using ($19) : ($20) with lines linewidth 3 title "RL : 300"

pause -1