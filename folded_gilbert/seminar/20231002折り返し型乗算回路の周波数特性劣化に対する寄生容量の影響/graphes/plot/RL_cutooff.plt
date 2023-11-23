set datafile separator ","

set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "R_{L} [ohm]" font "Arial,30" offset 0,-2
set ylabel "cutoff freq [GHz]" font "Arial,30" offset -10,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top right spacing 2.5 offset -10,-10
set key opaque
set terminal windows size 1000,700
set lmargin 25
set rmargin 20
set bmargin 8
set tmargin 2
set tics font "Arial,25"
set xtics offset -3, -0.7
set ytics
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics mytics linewidth 2, linewidth 1, linewidth 2, linewidth 1

input = "..\\data\\RL_cutoff.data"

gmp = 2.031*1e-3
gmn = 10.72*1e-3
gdp = 54.88*1e-6

sg = 2.646067e-13
gs = 1.851268e-13
sd = 3.792425e-14
ds = 4.155563e-14
gd = 8.45082e-14
dg = 5.028321e-15

Csg = sg
Csd = ds
Cgd = gd

R = 300
VCTRL = 200*1e-3

K = (gmp**2)/(4*1e-3)

fcut(x) = ( 1+2*x*gdp ) / ( 4*pi*x*Cgd )

set xrange [1:330]


plot   input skip 1 using 1 : ($2) * 1e9 with points pt 22 ps 3 lc black title ""
replot fcut(x) title "ideal cutoff freq"

pause -1