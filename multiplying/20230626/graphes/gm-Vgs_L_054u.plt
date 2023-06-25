#set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{gs} [V]" font "Arial,30" offset 0,-1
set ylabel "g_{m} [mS]" font "Arial,30" offset -8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 20,-2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

###################################################################
#       M = 1
#       L = 0.54u
#       W = 15u - 50u    step : 5u       (second argument)
#       vds = 1.8
#       Vgs = 0 - 0.9     step : 0.1m     (first argument)
#       Vd = 0
#
###################################################################

#x_scale = 1
y_scale = 1e3
set xrange[0.3 : 0.9]

plot "gm-Vgs_L_054u.dat" using 1 : ($2) * y_scale with lines title sprintf("W : %d um", 15 )
replot ""                using 1 : ($3) * y_scale with lines title sprintf("W : %d um", 20 )
replot ""                using 1 : ($4) * y_scale with lines title sprintf("W : %d um", 25 )
replot ""                using 1 : ($5) * y_scale with lines title sprintf("W : %d um", 30 )
replot ""                using 1 : ($6) * y_scale with lines title sprintf("W : %d um", 40 )
replot ""                using 1 : ($7) * y_scale with lines title sprintf("W : %d um", 45 )
replot ""                using 1 : ($8) * y_scale with lines title sprintf("W : %d um", 50 )

f(x) = g * x + i
g = 100e-6
i = 1e-3
vth = 0.424192

fit_s = 0.70
fit_e = 0.80

fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 2 via g, i
save fit sprintf("fitlog/%d.fitlog",1);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 3 via g, i
save fit sprintf("fitlog/%d.fitlog",2);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 4 via g, i
save fit sprintf("fitlog/%d.fitlog",3);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 5 via g, i
save fit sprintf("fitlog/%d.fitlog",4);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 6 via g, i
save fit sprintf("fitlog/%d.fitlog",5);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 7 via g, i
save fit sprintf("fitlog/%d.fitlog",6);
fit [fit_s : fit_e] f(x) "gm-Vgs_L_054u.dat" using 1 : 8 via g, i
save fit sprintf("fitlog/%d.fitlog",7);

h1(x) = 0.00569604357454773  * x 	-0.00203487548252598  	
h2(x) = 0.0075493027860556   * x 	-0.00268637305441195  	
h3(x) = 0.00938724714251726  * x 	-0.00332914334698062  	
h4(x) = 0.0112124079775004   * x 	-0.00396464287710439  	
h5(x) = 0.0130265339848979   * x 	-0.00459387554597189  	
h6(x) = 0.0148309142099474   * x 	-0.00521758017066908  	
h7(x) = 0.0166265427626189   * x 	-0.00583632581358901  	

set yrange [0 : 9]

replot h1(x) * y_scale with lines dt "-" notitle
replot h2(x) * y_scale with lines dt "-" notitle
replot h3(x) * y_scale with lines dt "-" notitle
replot h4(x) * y_scale with lines dt "-" notitle
replot h5(x) * y_scale with lines dt "-" notitle
replot h6(x) * y_scale with lines dt "-" notitle
replot h7(x) * y_scale with lines dt "-" notitle
