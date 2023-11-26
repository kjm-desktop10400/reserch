set multiplot

set logscale x
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set datafile separator ","

set key font"Arial,20"
set key left bottom spacing 2 offset 20, 0
set format x ""
set xlabel""
set ylabel "gain [dB]" font "Arial,30" offset -10,0
set lmargin screen 0.12
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.6
set xrange [1e6 : 1e12]
set yrange [-5.5: -5.2]
set ytics 0.1
plot   "..\\data\\buf_ac_gain.vcsv" skip 6 using  1 : 2   with lines notitle

set format x "1x10^{%L}"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-2
set ylabel "phase [deg]" font "Arial,30" offset -10,0
set yrange [0 : 1]
set ytics 0.2
set xtics offset 0,-1
set lmargin screen 0.12
set rmargin screen 0.95
set tmargin screen 0.55
set bmargin screen 0.15

plot   "..\\data\\buf_ac_phase.vcsv" skip 6 using  1 : 2   with lines notitle


