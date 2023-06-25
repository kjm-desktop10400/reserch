set datafile separator ","

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{gs} [V]" font "Arial,30" offset 0,-1
set ylabel "I [mA]" font "Arial,30" offset -8,0
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
#       W = 12u - 50u    step : 2u       (second argument)
#       vds = 1.8
#       Vgs = 0 - 0.9     step : 0.1m     (first argument)
#       Vd = 0
#
###################################################################

#x_scale = 1
y_scale = 1e3

set xrange[0.3 : ]

plot "Id-Vgs_L_054u.vcsv" skip 6 using 1  : (($2 ) * y_scale) with lines title "" #sprintf("W : %d um", 12 )
replot ""                 skip 6 using 3  : (($4 ) * y_scale) with lines title "" #sprintf("W : %d um", 14 )
replot ""                 skip 6 using 5  : (($6 ) * y_scale) with lines title "" #sprintf("W : %d um", 16 )
replot ""                 skip 6 using 7  : (($8 ) * y_scale) with lines title "" #sprintf("W : %d um", 18 )
replot ""                 skip 6 using 9  : (($10) * y_scale) with lines title "" #sprintf("W : %d um", 20 )
replot ""                 skip 6 using 11 : (($12) * y_scale) with lines title "" #sprintf("W : %d um", 22 )
replot ""                 skip 6 using 13 : (($14) * y_scale) with lines title "" #sprintf("W : %d um", 24 )
replot ""                 skip 6 using 15 : (($16) * y_scale) with lines title "" #sprintf("W : %d um", 26 )
replot ""                 skip 6 using 17 : (($18) * y_scale) with lines title "" #sprintf("W : %d um", 28 )
replot ""                 skip 6 using 19 : (($20) * y_scale) with lines title "" #sprintf("W : %d um", 30 )
replot ""                 skip 6 using 21 : (($22) * y_scale) with lines title "" #sprintf("W : %d um", 32 )
replot ""                 skip 6 using 23 : (($24) * y_scale) with lines title "" #sprintf("W : %d um", 34 )
replot ""                 skip 6 using 25 : (($26) * y_scale) with lines title "" #sprintf("W : %d um", 36 )
replot ""                 skip 6 using 27 : (($28) * y_scale) with lines title "" #sprintf("W : %d um", 38 )
replot ""                 skip 6 using 29 : (($30) * y_scale) with lines title "" #sprintf("W : %d um", 40 )
replot ""                 skip 6 using 31 : (($32) * y_scale) with lines title "" #sprintf("W : %d um", 42 )
replot ""                 skip 6 using 33 : (($34) * y_scale) with lines title "" #sprintf("W : %d um", 44 )
replot ""                 skip 6 using 35 : (($36) * y_scale) with lines title "" #sprintf("W : %d um", 46 )
replot ""                 skip 6 using 37 : (($38) * y_scale) with lines title "" #sprintf("W : %d um", 48 )
replot ""                 skip 6 using 39 : (($40) * y_scale) with lines title "" #sprintf("W : %d um", 50 )

f(x) = g * x + i
g = 0.15
i = 0.42

#fit [0.75 : ] f(x) "Id-Vgs_L_054u.vcsv" skip 6 using 1  : (sqrt($2 )) via g, i
#save fit sprintf("fitlog/%d.fitlog", 1  )
#fit [0.75 : ] f(x) "" skip 6 using 3  : (sqrt($4 )) via g, i
#save fit sprintf("fitlog/%d.fitlog", 2  )
#fit [0.75 : ] f(x) "" skip 6 using 5  : (sqrt($6 )) via g, i
#save fit sprintf("fitlog/%d.fitlog", 3  )
#fit [0.75 : ] f(x) "" skip 6 using 7  : (sqrt($8 )) via g, i
#save fit sprintf("fitlog/%d.fitlog", 4  )
#fit [0.75 : ] f(x) "" skip 6 using 9  : (sqrt($10)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 5  )
#fit [0.75 : ] f(x) "" skip 6 using 11 : (sqrt($12)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 6  )
#fit [0.75 : ] f(x) "" skip 6 using 13 : (sqrt($14)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 7  )
#fit [0.75 : ] f(x) "" skip 6 using 15 : (sqrt($16)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 8  )
#fit [0.75 : ] f(x) "" skip 6 using 17 : (sqrt($18)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 9  )
#fit [0.75 : ] f(x) "" skip 6 using 19 : (sqrt($20)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 10 )
#fit [0.75 : ] f(x) "" skip 6 using 21 : (sqrt($22)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 11 )
#fit [0.75 : ] f(x) "" skip 6 using 23 : (sqrt($24)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 12 )
#fit [0.75 : ] f(x) "" skip 6 using 25 : (sqrt($26)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 13 )
#fit [0.75 : ] f(x) "" skip 6 using 27 : (sqrt($28)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 14 )
#fit [0.75 : ] f(x) "" skip 6 using 29 : (sqrt($30)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 15 )
#fit [0.75 : ] f(x) "" skip 6 using 31 : (sqrt($32)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 16 )
#fit [0.75 : ] f(x) "" skip 6 using 33 : (sqrt($34)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 17 )
#fit [0.75 : ] f(x) "" skip 6 using 35 : (sqrt($36)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 18 )
#fit [0.75 : ] f(x) "" skip 6 using 37 : (sqrt($38)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 19 )
#fit [0.75 : ] f(x) "" skip 6 using 39 : (sqrt($40)) via g, i
#save fit sprintf("fitlog/%d.fitlog", 20 )

