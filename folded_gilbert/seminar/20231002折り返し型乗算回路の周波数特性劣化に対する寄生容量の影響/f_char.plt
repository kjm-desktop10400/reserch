#set datafile separator ","
#set multiplot

set logscale x

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "freq [Hz]" font "Arial,30" offset 0,-1
set ylabel "vout [dB]" font "Arial,30" offset -8,0
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

R = 300
VCTRL = 200*1e-3

K = (gmp**2)/(4*1e-3)
#K=101e-6

#Csg = 10*1e-15 
#Csd = 10*1e-15
#Cgd = 10*1e-15

set xrange [1e6:1e10]

fsg(x) = 20 * log10( (4*K*R*gmn * VCTRL) / ((1+2*R*gdp)*( sqrt(gmp**2+(2*pi*x*Csg)**2 ) )) )
fsd(x) = 20 * log10( (4*K*R*gmn * VCTRL) / ((1+2*R*gdp)*( sqrt(gmp**2+(2*pi*x*Csd)**2 ) )) )
fgd(x) = 20*log10( (4* K * R * gmn * VCTRL) / ( (gmp) * ( sqrt( (1+2*R*gdp)**2 + (4*pi*R*x*Cgd)**2 ) ) ) )

plot fsg(x)
replot fsd(x)
replot fgd(x)

pause -1