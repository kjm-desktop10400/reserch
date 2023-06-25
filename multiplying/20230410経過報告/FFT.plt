set logscale x
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"

set format x "1x10^{%L}"
set ylabel "Vout [dB]" font "Arial,30" offset -10,0
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.1
plot "FFT.txt" using 1 : 2  with lines notitle
replot"FFT.txt" using 1 : 2 notitle with points pt 6