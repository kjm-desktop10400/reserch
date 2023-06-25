set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vgs [V]" font "Arial,30" offset 0,-3
set ylabel "gm [S]" font "Arial,30" offset -20,0
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

set xrange[0 : 0.9]
set yrange[0:]

f(x) = A * x + B

plot   "gm_estimate.vcsv" using 1 : 2  skip 1 with lines title sprintf("%.1f V", 0.0)
replot "gm_estimate.vcsv" using 1 : 3  skip 1 with lines title sprintf("%.1f V", 0.1)
replot "gm_estimate.vcsv" using 1 : 4  skip 1 with lines title sprintf("%.1f V", 0.2)
replot "gm_estimate.vcsv" using 1 : 5  skip 1 with lines title sprintf("%.1f V", 0.3)
replot "gm_estimate.vcsv" using 1 : 6  skip 1 with lines title sprintf("%.1f V", 0.4)
replot "gm_estimate.vcsv" using 1 : 7  skip 1 with lines title sprintf("%.1f V", 0.5)
replot "gm_estimate.vcsv" using 1 : 8  skip 1 with lines title sprintf("%.1f V", 0.6)
replot "gm_estimate.vcsv" using 1 : 9  skip 1 with lines title sprintf("%.1f V", 0.7)
replot "gm_estimate.vcsv" using 1 : 10 skip 1 with lines title sprintf("%.1f V", 0.8)
replot "gm_estimate.vcsv" using 1 : 11 skip 1 with lines title sprintf("%.1f V", 0.9)

set xrange[0 : 0]
unset yrange

vth(x) = 0.167781 * x + 0.424192

fit [vth(0) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 2   via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.1) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 3  via A, B 
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.2) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 4  via A, B 
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.3) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 5  via A, B 
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.4) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 6  via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.5) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 7  via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.6) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 8  via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.7) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 9  via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.8) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 10 via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)
fit [vth(0.9) : 1] f(x) "gm_estimate.vcsv" skip 1 using 1 : 11 via A, B
#replot f(x) title sprintf("slope : %f S, vth : %f V", A, B)

#pause -1

#   vds	A	B
#   0.0 	0.000244898	-0.000104933
#   0.1 	0.000245287	-0.000109813
#   0.2 	0.000245580	-0.000114449
#   0.3 	0.000245797	-0.000118867
#   0.4 	0.000245992	-0.000123120
#   0.5 	0.000246218	-0.000127258
#   0.6 	0.000246453	-0.000131276
#   0.7 	0.000246760	-0.000135231
#   0.8 	0.000247103	-0.000139105
#   0.9 	0.000247540	-0.000142953
#   ave.	0.000246163	
#   
#
#vth(vds) = 0.167781*vds + 0.424192