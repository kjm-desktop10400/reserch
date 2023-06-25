set multiplot

set logscale x
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"

set key font"Arial,20"
set key left bottom spacing 2 offset 20, 0
set format x ""
set ylabel "Vout [dB]" font "Arial,30" offset -10,0
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.6
plot for [i = 1 : 5] "ACanalsysGain.txt" using 1 : i + 1 with lines notitle

set format x "1x10^{%L}"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-2
set ylabel "phase [deg]" font "Arial,30" offset -10,0
set yrange [-360 : 10]
set xtics offset 0,-1
set ytics 90
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.55
set bmargin screen 0.15
plot for [i = 1 : 5] "ACanalsysPhase.txt" using 1 : i + 1 with lines title sprintf("VCTRL : %d mV", 20 * i)