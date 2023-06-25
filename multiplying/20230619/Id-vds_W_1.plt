set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{ds} [V]" font "Arial,30" offset 0,-1
set ylabel "I_{1} [uA]" font "Arial,30" offset -12,0
set key font"Arial,15"
set key top left spacing 1.5 offset 5,0
set terminal windows size 1000,700
set lmargin 28
set rmargin 25
set bmargin 5
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

f(x) = g * x + i

plot   "Id-vds_W_1.vcsv" skip 6 using 1  : ($2 ) * 1e6 with lines title "" #sprintf("L = %.1f um", 0.2 )
replot "Id-vds_W_1.vcsv" skip 6 using 3  : ($4 ) * 1e6 with lines title "" #sprintf("L = %.1f um", 0.4 )
replot "Id-vds_W_1.vcsv" skip 6 using 5  : ($6 ) * 1e6 with lines title "" #sprintf("L = %.1f um", 0.6 )
replot "Id-vds_W_1.vcsv" skip 6 using 7  : ($8 ) * 1e6 with lines title "" #sprintf("L = %.1f um", 0.8 )
replot "Id-vds_W_1.vcsv" skip 6 using 9  : ($10) * 1e6 with lines title "" #sprintf("L = %.1f um", 1.0 )
replot "Id-vds_W_1.vcsv" skip 6 using 11 : ($12) * 1e6 with lines title "" #sprintf("L = %.1f um", 1.2 )
replot "Id-vds_W_1.vcsv" skip 6 using 13 : ($14) * 1e6 with lines title "" #sprintf("L = %.1f um", 1.4 )
replot "Id-vds_W_1.vcsv" skip 6 using 15 : ($16) * 1e6 with lines title "" #sprintf("L = %.1f um", 1.6 )
replot "Id-vds_W_1.vcsv" skip 6 using 17 : ($18) * 1e6 with lines title "" #sprintf("L = %.1f um", 1.8 )
replot "Id-vds_W_1.vcsv" skip 6 using 19 : ($20) * 1e6 with lines title "" #sprintf("L = %.1f um", 2.0 )
replot "Id-vds_W_1.vcsv" skip 6 using 21 : ($22) * 1e6 with lines title "" #sprintf("L = %.1f um", 2.2 )
replot "Id-vds_W_1.vcsv" skip 6 using 23 : ($24) * 1e6 with lines title "" #sprintf("L = %.1f um", 2.4 )
replot "Id-vds_W_1.vcsv" skip 6 using 25 : ($26) * 1e6 with lines title "" #sprintf("L = %.1f um", 2.6 )
replot "Id-vds_W_1.vcsv" skip 6 using 27 : ($28) * 1e6 with lines title "" #sprintf("L = %.1f um", 2.8 )
replot "Id-vds_W_1.vcsv" skip 6 using 29 : ($30) * 1e6 with lines title "" #sprintf("L = %.1f um", 3.0 )
replot "Id-vds_W_1.vcsv" skip 6 using 31 : ($32) * 1e6 with lines title "" #sprintf("L = %.1f um", 3.2 )
replot "Id-vds_W_1.vcsv" skip 6 using 33 : ($34) * 1e6 with lines title "" #sprintf("L = %.1f um", 3.4 )
replot "Id-vds_W_1.vcsv" skip 6 using 35 : ($36) * 1e6 with lines title "" #sprintf("L = %.1f um", 3.6 )
replot "Id-vds_W_1.vcsv" skip 6 using 37 : ($38) * 1e6 with lines title "" #sprintf("L = %.1f um", 3.8 )
replot "Id-vds_W_1.vcsv" skip 6 using 39 : ($40) * 1e6 with lines title "" #sprintf("L = %.1f um", 4.0 )

#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 1  : ($2 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 3  : ($4 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 5  : ($6 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 7  : ($8 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 9  : ($10) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 11 : ($12) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 13 : ($14) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 15 : ($16) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 17 : ($18) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 19 : ($20) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 21 : ($22) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 23 : ($24) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 25 : ($26) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 27 : ($28) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 29 : ($30) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 31 : ($32) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 33 : ($34) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 35 : ($36) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 37 : ($38) via g, i
#fit [0.4 : 1] f(x) "Id-vds_W_1.vcsv" skip 6 using 39 : ($40) via g, i

#L	gd	intercept
#0.2 	9.03377E-07	1.18065E-06
#0.4 	7.92126E-08	9.45595E-07
#0.6 	4.17220E-07	1.10147E-06
#0.8 	2.32158E-07	9.15017E-07
#1.0 	1.48183E-07	7.75087E-07
#1.2 	1.05122E-07	6.69404E-07
#1.4 	8.04712E-08	5.87843E-07
#1.6 	6.49315E-08	5.23426E-07
#1.8 	5.43117E-08	4.71458E-07
#2.0 	4.65718E-08	4.28746E-07
#2.2 	4.06462E-08	3.93067E-07
#2.4 	3.59397E-08	3.62840E-07
#2.6 	3.20978E-08	3.36918E-07
#2.8 	2.88969E-08	3.14449E-07
#3.0 	2.61877E-08	2.94789E-07
#3.2 	2.38661E-08	2.77445E-07
#3.4 	2.18564E-08	2.62031E-07
#3.6 	2.01020E-08	2.48241E-07
#3.8 	1.85593E-08	2.35834E-07
#4.0 	1.71942E-08	2.24610E-07
