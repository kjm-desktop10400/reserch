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
set yrange[-25:5]

input = "..\\data\\Fs_gd_ac.vcsv"

plot   input skip 6 using   1   : ($2 ) with lines linewidth 3 title "Id : 3m "
replot input skip 6 using ($3 ) : ($4 ) with lines linewidth 3 title "Id : 4m "
replot input skip 6 using ($5 ) : ($6 ) with lines linewidth 3 title "Id : 5m "
replot input skip 6 using ($7 ) : ($8 ) with lines linewidth 3 title "Id : 6m "
replot input skip 6 using ($9 ) : ($10) with lines linewidth 3 title "Id : 7m "
replot input skip 6 using ($11) : ($12) with lines linewidth 3 title "Id : 8m "
replot input skip 6 using ($13) : ($14) with lines linewidth 3 title "Id : 9m "
replot input skip 6 using ($15) : ($16) with lines linewidth 3 title "Id : 10m"
replot input skip 6 using ($17) : ($18) with lines linewidth 3 title "Id : 11m"

pause -1