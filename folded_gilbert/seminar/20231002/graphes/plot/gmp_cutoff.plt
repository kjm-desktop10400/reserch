set datafile separator ","

#set logscale x

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "gm [mS]" font "Arial,30" offset 0,-2
set ylabel "cutoff freq [GHz]" font "Arial,30" offset -8,0
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

input = "..\\data\\gmp_cutoff.data"

set xrange[1 : 3]
set yrange[0 : 6]

plot   input skip 1 using 2 : 3 with points pt 2 ps 3 title ""

pause -1