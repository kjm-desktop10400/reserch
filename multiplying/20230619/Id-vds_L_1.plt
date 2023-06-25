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

plot   "Id-vds_L_1.vcsv" skip 6 using 1  : ($2 ) * 1e6 with lines title "" #sprintf("W = %.1f um", 1.0 )
replot "Id-vds_L_1.vcsv" skip 6 using 3  : ($4 ) * 1e6 with lines title "" #sprintf("W = %.1f um", 1.4 )
replot "Id-vds_L_1.vcsv" skip 6 using 5  : ($6 ) * 1e6 with lines title "" #sprintf("W = %.1f um", 1.8 )
replot "Id-vds_L_1.vcsv" skip 6 using 7  : ($8 ) * 1e6 with lines title "" #sprintf("W = %.1f um", 2.2 )
replot "Id-vds_L_1.vcsv" skip 6 using 9  : ($10) * 1e6 with lines title "" #sprintf("W = %.1f um", 2.6 )
replot "Id-vds_L_1.vcsv" skip 6 using 11 : ($12) * 1e6 with lines title "" #sprintf("W = %.1f um", 3.0 )
replot "Id-vds_L_1.vcsv" skip 6 using 13 : ($14) * 1e6 with lines title "" #sprintf("W = %.1f um", 3.4 )
replot "Id-vds_L_1.vcsv" skip 6 using 15 : ($16) * 1e6 with lines title "" #sprintf("W = %.1f um", 3.8 )
replot "Id-vds_L_1.vcsv" skip 6 using 17 : ($18) * 1e6 with lines title "" #sprintf("W = %.1f um", 4.2 )
replot "Id-vds_L_1.vcsv" skip 6 using 19 : ($20) * 1e6 with lines title "" #sprintf("W = %.1f um", 4.6 )
replot "Id-vds_L_1.vcsv" skip 6 using 21 : ($22) * 1e6 with lines title "" #sprintf("W = %.1f um", 5.0 )
replot "Id-vds_L_1.vcsv" skip 6 using 23 : ($24) * 1e6 with lines title "" #sprintf("W = %.1f um", 5.4 )
replot "Id-vds_L_1.vcsv" skip 6 using 25 : ($26) * 1e6 with lines title "" #sprintf("W = %.1f um", 5.8 )
replot "Id-vds_L_1.vcsv" skip 6 using 27 : ($28) * 1e6 with lines title "" #sprintf("W = %.1f um", 6.2 )
replot "Id-vds_L_1.vcsv" skip 6 using 29 : ($30) * 1e6 with lines title "" #sprintf("W = %.1f um", 6.6 )
replot "Id-vds_L_1.vcsv" skip 6 using 31 : ($32) * 1e6 with lines title "" #sprintf("W = %.1f um", 7.0 )
replot "Id-vds_L_1.vcsv" skip 6 using 33 : ($34) * 1e6 with lines title "" #sprintf("W = %.1f um", 7.4 )
replot "Id-vds_L_1.vcsv" skip 6 using 35 : ($36) * 1e6 with lines title "" #sprintf("W = %.1f um", 7.8 )
replot "Id-vds_L_1.vcsv" skip 6 using 37 : ($38) * 1e6 with lines title "" #sprintf("W = %.1f um", 8.2 )
replot "Id-vds_L_1.vcsv" skip 6 using 39 : ($40) * 1e6 with lines title "" #sprintf("W = %.1f um", 8.6 )
replot "Id-vds_L_1.vcsv" skip 6 using 41 : ($42) * 1e6 with lines title "" #sprintf("W = %.1f um", 9.0 )
replot "Id-vds_L_1.vcsv" skip 6 using 43 : ($44) * 1e6 with lines title "" #sprintf("W = %.1f um", 9.4 )
replot "Id-vds_L_1.vcsv" skip 6 using 45 : ($46) * 1e6 with lines title "" #sprintf("W = %.1f um", 9.8 )

f(x) = g * x + i

#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 1  : ($2 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 3  : ($4 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 5  : ($6 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 7  : ($8 ) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 9  : ($10) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 11 : ($12) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 13 : ($14) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 15 : ($16) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 17 : ($18) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 19 : ($20) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 21 : ($22) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 23 : ($24) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 25 : ($26) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 27 : ($28) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 29 : ($30) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 31 : ($32) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 33 : ($34) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 35 : ($36) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 37 : ($38) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 39 : ($40) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 41 : ($42) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 43 : ($44) via g, i
#fit [0.4 : 1] f(x) "Id-vds_L_1.vcsv" skip 6 using 45 : ($46) via g, i

#W	gd	intercept
#1.0 	1.48183E-07	7.75087E-07
#1.4 	2.06335E-07	1.07707E-06
#1.8 	2.64677E-07	1.38034E-06
#2.2 	3.23199E-07	1.68477E-06
#2.6 	3.81897E-07	1.99029E-06
#3.0 	4.40767E-07	2.29685E-06
#3.4 	4.99804E-07	2.60439E-06
#3.8 	5.59005E-07	2.91290E-06
#4.2 	6.18366E-07	3.22234E-06
#4.6 	6.77882E-07	3.53267E-06
#5.0 	7.37550E-07	3.84388E-06
#5.4 	7.97367E-07	4.15592E-06
#5.8 	8.57327E-07	4.46879E-06
#6.2 	9.17429E-07	4.78245E-06
#6.6 	9.77666E-07	5.09687E-06
#7.0 	1.03804E-06	5.41205E-06
#7.4 	1.09854E-06	5.72796E-06
#7.8 	1.15917E-06	6.04457E-06
#8.2 	1.21992E-06	6.36188E-06
#8.6 	1.28079E-06	6.67985E-06
#9.0 	1.34177E-06	6.99847E-06
#9.4 	1.40288E-06	7.31773E-06
#9.8 	1.46409E-06	7.63760E-06
