set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "r_{1}" font "Arial,30" offset 0,-1
set ylabel "vout [V]" font "Arial,30" offset -10,0
set key font"Arial,25"
set key top left spacing 3 offset 9,0
set terminal windows size 1000,700
set lmargin 21
set rmargin 22
set bmargin 5
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

#set ytics 0.2
set y2tics 1.5
set y2label "current [mA]" font "Arial,30" offset 8,0

vinb = 0.9
vth0 = 0.424192
g = 20e-3  
T = 0.167781
K = 246e-6

vout(x) = (vinb + vth0 - (g / (K * x))) / (1 + T)

vgs(x) = vinb - vout(x)
vth(x) = T * vout(x) + vth0

I1_1(x) = K * x * (vgs(x) - vth(x))**2
I1_2(x) = (g * (vgs(x) - vth(x))) / 2

Iout(x) = g * vout(x)

I2(x) = I1_2(x) - Iout(x)

set xrange [60 : 100]
set yrange [0 : ]
set y2range [0 : 13.5]

plot vout(x) axis x1y1 title "Vout"
#replot I1_1(x) * 1e3 axis x1y2 title "I_{1}"
replot I1_2(x) * 1e3 axis x1y2 title "I_{1}"
replot I2(x) * 1e3 axis x1y2 title "I_{2}"
replot Iout(x) * 1e3 axis x1y2 title "I_{out}"

pause -1