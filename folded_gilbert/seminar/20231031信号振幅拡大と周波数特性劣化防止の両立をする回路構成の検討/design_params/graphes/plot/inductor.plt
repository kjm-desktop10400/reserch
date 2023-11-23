set datafile separator ","
#set multiplot

set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "frequency [GHz]" font "Arial,30" offset 0,-1
set ylabel "magnitude [dB]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 15,0
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

#set xrange[1e-1 : 1e1]
#set yrange[-2 : 5]

input = "..\\data\\inductor.vcsv"

plot   input skip 6 using ($1 ) * 1e-9 : 2  with lines title sprintf("L = %d nH", 20)
replot input skip 6 using ($3 ) * 1e-9 : 4  with lines title sprintf("L = %d nH", 21)
replot input skip 6 using ($5 ) * 1e-9 : 6  with lines title sprintf("L = %d nH", 22)
replot input skip 6 using ($7 ) * 1e-9 : 8  with lines title sprintf("L = %d nH", 23)
replot input skip 6 using ($9 ) * 1e-9 : 10 with lines title sprintf("L = %d nH", 24)
replot input skip 6 using ($11) * 1e-9 : 12 with lines title sprintf("L = %d nH", 25)
replot input skip 6 using ($13) * 1e-9 : 14 with lines title sprintf("L = %d nH", 26)
replot input skip 6 using ($15) * 1e-9 : 16 with lines title sprintf("L = %d nH", 27)
replot input skip 6 using ($17) * 1e-9 : 18 with lines title sprintf("L = %d nH", 28)
replot input skip 6 using ($19) * 1e-9 : 20 with lines title sprintf("L = %d nH", 29)
replot input skip 6 using ($21) * 1e-9 : 22 with lines title sprintf("L = %d nH", 30)

pause -1