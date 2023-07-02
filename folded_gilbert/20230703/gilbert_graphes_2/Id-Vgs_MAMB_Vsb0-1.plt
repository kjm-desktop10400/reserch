set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "I_{D} [mA]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top center spacing 2.5 offset 10,-2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
#set ytics
#set y2tics
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange [0 : 1]
#set yrange [0 : 50e-3]
#set y2range [ : ]

###################################################################
#       M = 
#       L = 
#       W = 
#       vds
#       Vgs
#       Vbs
#
#       vin 
#
###################################################################

#x_scale = 1e3
y_scale = 1e3

input = "Id-Vgs_MAMB_Vsb0-1.vcsv"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot   input skip 6 using 1  : (($2 ) * y_scale) with lines title "" #"V_{SB} : 0.0"
replot input skip 6 using 3  : (($4 ) * y_scale) with lines title "" #"V_{SB} : 0.1"
#replot input skip 6 using 5  : (sqrt($6 ) * y_scale) with lines title "" #"V_{SB} : 0.2"
#replot input skip 6 using 7  : (sqrt($8 ) * y_scale) with lines title "" #"V_{SB} : 0.3"
#replot input skip 6 using 9  : (sqrt($10) * y_scale) with lines title "" #"V_{SB} : 0.4"
#replot input skip 6 using 11 : (sqrt($12) * y_scale) with lines title "" #"V_{SB} : 0.5"
#replot input skip 6 using 13 : (sqrt($14) * y_scale) with lines title "" #"V_{SB} : 0.6"
#replot input skip 6 using 15 : (sqrt($16) * y_scale) with lines title "" #"V_{SB} : 0.7"
#replot input skip 6 using 17 : (sqrt($18) * y_scale) with lines title "" #"V_{SB} : 0.8"
#replot input skip 6 using 19 : (sqrt($20) * y_scale) with lines title "" #"V_{SB} : 0.9"
#replot input skip 6 using 21 : (sqrt($22) * y_scale) with lines title "" #"V_{SB} : 1.0"

f(x) = A * x + B
g(x) = C * x + D
A = C = 100e-6
B = D = -1e-3


fit [0.6 : 0.8] f(x) input skip 6 using 1  : (sqrt($2 )) via A, B 
save fit sprintf(".\\fitlog\\%d.fitlog",1 )
fit [0.6 : 0.8] g(x) input skip 6 using 3  : (sqrt($4 )) via C, D 
save fit sprintf(".\\fitlog\\%d.fitlog",2 )
#fit [0.6 : 0.8] f(x) input skip 6 using 5  : (sqrt($6 )) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",3 )
#fit [0.6 : 0.8] f(x) input skip 6 using 7  : (sqrt($8 )) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",4 )
#fit [0.6 : 0.8] f(x) input skip 6 using 9  : (sqrt($10)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",5 )
#fit [0.6 : 0.8] f(x) input skip 6 using 11 : (sqrt($12)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",6 )
#fit [0.6 : 0.8] f(x) input skip 6 using 13 : (sqrt($14)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",7 )
#fit [0.6 : 0.8] f(x) input skip 6 using 15 : (sqrt($16)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",8 )
#fit [0.6 : 0.8] f(x) input skip 6 using 17 : (sqrt($18)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",9 )
#fit [0.6 : 0.8] f(x) input skip 6 using 19 : (sqrt($20)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",10)
#fit [0.6 : 0.8] f(x) input skip 6 using 21 : (sqrt($22)) via A, B 

#f1(x)  = 0.0864537364304869 * x -0.0374790383518164   	
#f2(x)  = 0.0862866371653302 * x -0.0390570691108715   	
#f3(x)  = 0.0858289271849395 * x -0.0403442503452024   	
#f4(x)  = 0.0850487587823804 * x -0.0413210596278238   	
#f5(x)  = 0.0839172440640335 * x -0.0419692280688711   	
#f6(x)  = 0.082412767232365  * x -0.0422750117246184   	
#f7(x)  = 0.0805247858406084 * x -0.0422321240066375   	
#f8(x)  = 0.0782566278835392 * x -0.0418439456971481   	
#f9(x)  = 0.0756267891697637 * x -0.0411246384880268   	
#f10(x) = 0.072668566284184  * x -0.0400990311034868   	
#f11(x) = 0.0694281243288226 * x -0.0388013438775408   	

set xrange[0 : 1]
set yrange[0 : ]

#replot f(x)  * y_scale title sprintf("slope : %f, Vth : %f", A, -1 * B / A)
#replot g(x)  * y_scale title sprintf("slope : %f, Vth : %f", C, -1 * D / C)
#replot f3(x)  * y_scale
#replot f4(x)  * y_scale
#replot f5(x)  * y_scale
#replot f6(x)  * y_scale
#replot f7(x)  * y_scale
#replot f8(x)  * y_scale
#replot f9(x)  * y_scale
#replot f10(x) * y_scale
#replot f11(x) * y_scale

pause -1