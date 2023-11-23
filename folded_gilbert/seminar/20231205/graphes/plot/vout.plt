set datafile separator ","
#set multiplot

#set logscale x
#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "I_{B} [mA]" font "Arial,30" offset 0,-1.5
set ylabel "Current [mA]" font "Arial,30" offset -8,0
set y2label "Voltage [V]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 35,5
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set xtics offset 0 , -0.8
set ytics offset 0 , 0
set y2tics 0.3
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

input = "..\\data\\previous_dc.vcsv"

set xrange[0 : 10e-3]
#set yrange[-0.6 : 0.6]
set y2range[0 : 1.8]

gm = 20*1e-3
Rout = 50
#Vth0 = 0.424192
Vth0 = 0
T = 0.167781

set dummy IB

ib(IB) = gm * (1.26-Vth0) / (3 + T) + (1 + T) * IB / (3 + T)
Vout(IB) = Rout * (ib(IB) - IB)

plot ib(IB * 1e0) axis x1y1
replot IB * 1e0 axis x1y1
replot Vout(IB * 1e0) axis x1y2

pause -1