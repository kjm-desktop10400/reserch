set multiplot

set logscale x
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xrange [1e7:]

set format x ""
set ylabel "Vout [dB]" font "Arial,30" offset -10,0
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.6
set arrow from 1071519305.23758,-24 to 1071519305.23758,-12 nohead dt 3 lw 2 lc rgb "red"
plot "ACanalsysGain.txt" using 1 : 2 with lines notitle 

set format x "1x10^{%L}"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-2
set ylabel "phase [deg]" font "Arial,30" offset -10,0
set xtics offset 0,-2
set ytics 90
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.55
set bmargin screen 0.15
set arrow from 1071519305.23758,-360 to 1071519305.23758,0 nohead dt 3 lw 2 lc rgb "red"
set arrow from 1e7,-1.40143289182901e+002 to 1e10,-1.40143289182901e+002 nohead dt 3 lw 2 lc rgb "red"
plot "ACanalsysPhase.txt" using 1 : 2 with lines notitle
