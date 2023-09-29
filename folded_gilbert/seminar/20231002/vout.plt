#set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vin [mV]" font "Arial,30" offset 0,-1
set ylabel "vout [mV]" font "Arial,30" offset -8,0
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

R = 300
VCTRL = 200*1e-3

#K=101e-6
K=(gmp**2)/(4*1e-3)

vout(x)=4*R*K*gmn*VCTRL*x /( gmp*(1+2*R*gdp))

set xrange[-0.2 : 0.2]

plot vout(x)

pause -1