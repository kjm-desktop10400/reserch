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
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.97
set bmargin screen 0.6
set xrange [1e6 : 1e12]
set yrange [-20: 20]
set ytics 5
plot   "..\\data\\gilbert_ac_gain.vcsv" skip 6 using  1 : 2   with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using  3 : 4   with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using  5 : 6   with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using  7 : 8   with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using  9 : 10  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 11 : 12  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 13 : 14  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 15 : 16  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 17 : 18  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 19 : 20  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 21 : 22  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 23 : 24  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 25 : 26  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 27 : 28  with lines notitle
replot "..\\data\\gilbert_ac_gain.vcsv" skip 6 using 29 : 30  with lines notitle

set format x "1x10^{%L}"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-2
set ylabel "phase [deg]" font "Arial,30" offset -10,0
set yrange [-90 : 0]
set ytics 30
set xtics offset 0,-1
set lmargin screen 0.1
set rmargin screen 0.95
set tmargin screen 0.55
set bmargin screen 0.15

plot   "..\\data\\gilbert_ac_phase.vcsv" skip 6 using  1 : 2   with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using  3 : 4   with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using  5 : 6   with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using  7 : 8   with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using  9 : 10  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 11 : 12  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 13 : 14  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 15 : 16  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 17 : 18  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 19 : 20  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 21 : 22  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 23 : 24  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 25 : 26  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 27 : 28  with lines notitle
replot "..\\data\\gilbert_ac_phase.vcsv" skip 6 using 29 : 30  with lines notitle

#set label 1   right at graph 0.25  , 0. "0.02 V" font ", 20"
#set label 2   right at graph 0.25  , 0. "0.04 V" font ", 20"
#set label 3   right at graph 0.25  , 0. "0.06 V" font ", 20"
#set label 4   right at graph 0.25  , 0. "0.08 V" font ", 20"
#set label 5   right at graph 0.25  , 0. "0.10 V" font ", 20"
#set label 6   right at graph 0.25  , 0. "0.12 V" font ", 20"
#set label 7   right at graph 0.25  , 0. "0.14 V" font ", 20"
#set label 8   right at graph 0.25  , 0. "0.16 V" font ", 20"
#set label 9   right at graph 0.25  , 0. "0.18 V" font ", 20"
#set label 10  right at graph 0.25  , 0. "0.20 V" font ", 20"
#set label 11  right at graph 0.25  , 0. "0.22 V" font ", 20"
#set label 12  right at graph 0.25  , 0. "0.24 V" font ", 20"
#set label 13  right at graph 0.25  , 0. "0.26 V" font ", 20"
#set label 14  right at graph 0.25  , 0. "0.28 V" font ", 20"
#set label 15  right at graph 0.25  , 0. "0.30 V" font ", 20"


