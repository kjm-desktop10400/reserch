set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vgs [V]" font "Arial,30" offset 0,-3
set ylabel "sqrt I1 [A^{1/2}]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top left spacing 2 offset 10, -2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set datafile separator ","

set xrange[0:1]
set yrange[0:]

f(x) = A * x + B

plot   "vth_est.vcsv" using 1 :  (sqrt($2 )) with lines title sprintf("%.1f V", 0.0)
replot "" using 3 :  (sqrt($4 )) with lines title sprintf("%.1f V", 0.1)
replot "" using 5 :  (sqrt($6 )) with lines title sprintf("%.1f V", 0.2)
replot "" using 7 :  (sqrt($8 )) with lines title sprintf("%.1f V", 0.3)
replot "" using 9 :  (sqrt($10)) with lines title sprintf("%.1f V", 0.4)
replot "" using 11 : (sqrt($12)) with lines title sprintf("%.1f V", 0.5)
replot "" using 13 : (sqrt($14)) with lines title sprintf("%.1f V", 0.6)
replot "" using 15 : (sqrt($16)) with lines title sprintf("%.1f V", 0.7)
replot "" using 17 : (sqrt($18)) with lines title sprintf("%.1f V", 0.8)
replot "" using 19 : (sqrt($20)) with lines title sprintf("%.1f V", 0.9)

#plot   "vth_est.vcsv" using 1 :  2 with lines title sprintf("%.1f V", 0.0)
#replot "" using 3 :  4  with lines title sprintf("%.1f V", 0.1)
#replot "" using 5 :  6  with lines title sprintf("%.1f V", 0.2)
#replot "" using 7 :  8  with lines title sprintf("%.1f V", 0.3)
#replot "" using 9 :  10 with lines title sprintf("%.1f V", 0.4)
#replot "" using 11 : 12 with lines title sprintf("%.1f V", 0.5)
#replot "" using 13 : 14 with lines title sprintf("%.1f V", 0.6)
#replot "" using 15 : 16 with lines title sprintf("%.1f V", 0.7)
#replot "" using 17 : 18 with lines title sprintf("%.1f V", 0.8)
#replot "" using 19 : 20 with lines title sprintf("%.1f V", 0.9)



set xrange[0 : 0]
unset yrange

#fit [vte() : 1] f(x) "" using 1 :  $2  via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 3  : $4  via A, B 
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 5  : $6  via A, B 
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 7  : $8  via A, B 
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 9  : $10 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 11 : $12 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 13 : $14 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 15 : $16 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 17 : $18 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
#fit [vte() : 1] f(x) "" using 19 : $20 via A, B
#plot B
##replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)

#pause -1

#	vds	slope	vth
#	0	0.0108516	0.418383464
#	0.1	0.0108876	0.439197803
#	0.2	0.0109187	0.458866898
#	0.3	0.0109447	0.477466719
#	0.4	0.0109649	0.495067898
#	0.5	0.0109784	0.511731218
#	0.6	0.0109842	0.52750223
#	0.7	0.0109812	0.542417951
#	0.8	0.0109683	0.556503743
#	0.9	0.010944	0.569797149
