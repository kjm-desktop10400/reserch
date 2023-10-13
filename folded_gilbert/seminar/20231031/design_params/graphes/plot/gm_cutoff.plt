#set datafile separator ","

#set logscale y

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "g_{mp} [mS]" font "Arial,30" offset 0,-2
set ylabel "cutoff freq [GHz]" font "Arial,30" offset -10,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 20,-5
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

input = "..\\data\\gm_cutoff.data"

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

fcut(x) = (x*1e-3) / (2*pi*Csg)

set xrange[1.8 : 2.6]
set yrange[0.9 : 1.6]

plot   input skip 1 using 2 : 3 with points pt 22 ps 3 lc black title "simulated"
replot input skip 1 using 2 : 3 with lines black title ""
replot fcut(x) * 1e-9 black title "ideal cutoff freq"

predict(x) = A * x + B
A = 0
B = 0

input_predict = "..\\data\\gm_cutoff_predict.data"

fit predict(x) input_predict skip 1 using 2 : 3 via A, B

replot predict(x) with lines dt (10 , 5) black title "approximate"

pause -1