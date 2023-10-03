#set datafile separator ","
#set multiplot

#set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "g_{mp} [mS]" font "Arial,30" offset 0,-1
set ylabel "cutoff freq [GHz]" font "Arial,30" offset -8,0
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

Cs = Csg + Csd
Cd = Csd + Cgd

R = 300
VCTRL = 200*1e-3

set yrange [0 : 6]
set xrange[1 : 3]

fRp(x) = ( Cs +2*x*gmp*Cd + sqrt( (Cs+2*x*gmp*Cd)**2 + 8*x*gmp*Cs*Cd ) ) / ( 8*pi*x*Cs*Cd )
fRn(x) = ( Cs +2*x*gmp*Cd - sqrt( (Cs+2*x*gmp*Cd)**2 + 8*x*gmp*Cs*Cd ) ) / ( 8*pi*x*Cs*Cd )

fgp(x) = ( Cs +2*R*x*1e-3*Cd + sqrt( (Cs+2*R*x*1e-3*Cd)**2 + 8*R*x*1e-3*Cs*Cd ) ) / ( 8*pi*R*Cs*Cd )
fgn(x) = ( Cs +2*R*x*1e-3*Cd - sqrt( (Cs+2*R*x*1e-3*Cd)**2 + 8*R*x*1e-3*Cs*Cd ) ) / ( 8*pi*R*Cs*Cd )

plot   fgp(x)*1e-9
#replot fgn(x)*1e-9




pause -1