set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vds [V]" font "Arial,30" offset 0,-1
set ylabel "Id [A]" font "Arial,30" offset -12,0
set key font"Arial,15"
set key top left spacing 1.5 offset 3,0
set terminal windows size 1000,700
set lmargin 28
set rmargin 5
set bmargin 5
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

plot for[i = 3 : 20] "gd_est.vcsv" skip 6 using 2 * i - 1 : i * 2 with lines title sprintf("L : %.1f um", 0.2 * i)

f(x) = A * x + B

do for[i = 3 : 20]{
    fit [0.1 : 1] f(x) "" skip 6 using 2 * i - 1 : i * 2 via A, B
}

#L [um]	A	B	intercept
#0.6	4.36233E-07	1.08749E-06	-2.492910899
#0.8	2.45837E-07	9.04953E-07	-3.681109841
#1	1.58167E-07	7.67742E-07	-4.853996093
#1.2	1.12486E-07	6.63986E-07	-5.902832352
#1.4	8.59673E-08	5.83800E-07	-6.790954235
#1.6	6.90881E-08	5.20369E-07	-7.531962813
#1.8	5.74995E-08	4.69115E-07	-8.158592683
#2	4.90512E-08	4.26924E-07	-8.703640278


pause -1