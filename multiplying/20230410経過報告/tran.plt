set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"

set ylabel "voltage [mV]" font "Arial,30" offset -10,0
set xlabel "time [ms]" font "Arial,30" offset 0,-2
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.15
set xtics offset 0,-1
set xrange [ : 2]
set yrange [-120 : 120]
set ytics 25
set key font"Arial,20"
set key spacing 2
plot "tran.txt"  using 1 : 2  with lines title "vin (1 kHz/100 mV)"
replot "tran.txt" using 1 : 3  with lines title "vout (VCTRL:100 mV)"