#set datafile separator ","
#set multiplot

#set logscale xy

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "R'_{L}/R_{L} [ohm]" font "Arial,30" offset 0,-1
set ylabel "cutoff freq [Hz]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 35,2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set ytics
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

g = 54.88*1e-6
C = 10e-12

RL = 30

set xrange[1:10]

fgd(x) = (1+2*x*RL*g) / (x*(1+2*RL*g))



plot fgd(x)
replot 1/x

pause -1