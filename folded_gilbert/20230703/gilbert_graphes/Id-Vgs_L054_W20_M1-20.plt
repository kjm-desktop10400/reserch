set datafile separator ","
#set multiplot

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "V_{GS} [V]" font "Arial,30" offset 0,-1
set ylabel "sqrt I_{D} [mA^{1/2}]" font "Arial,30" offset -8,0
#set y2label " []" font "Arial,30" offset 8,0
set key font"Arial,25"
set key top left spacing 2.5 offset 10,-2
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

input = "Id-Vgs_L054_W20_M1-20.vcsv"
#input = "Id-Vds_Vgs_10.vcsv"
#input = "Id-Vds_Vgs_18.vcsv"


plot   input skip 6 using 1  : (sqrt($2 ) * y_scale) with lines title "" #"M : 1 "
replot input skip 6 using 3  : (sqrt($4 ) * y_scale) with lines title "" #"M : 2 "
replot input skip 6 using 5  : (sqrt($6 ) * y_scale) with lines title "" #"M : 3 "
replot input skip 6 using 7  : (sqrt($8 ) * y_scale) with lines title "" #"M : 4 "
replot input skip 6 using 9  : (sqrt($10) * y_scale) with lines title "" #"M : 5 "
replot input skip 6 using 11 : (sqrt($12) * y_scale) with lines title "" #"M : 6 "
replot input skip 6 using 13 : (sqrt($14) * y_scale) with lines title "" #"M : 7 "
replot input skip 6 using 15 : (sqrt($16) * y_scale) with lines title "" #"M : 8 "
replot input skip 6 using 17 : (sqrt($18) * y_scale) with lines title "" #"M : 9 "
replot input skip 6 using 19 : (sqrt($20) * y_scale) with lines title "" #"M : 10"
replot input skip 6 using 21 : (sqrt($22) * y_scale) with lines title "" #"M : 11"
replot input skip 6 using 23 : (sqrt($24) * y_scale) with lines title "" #"M : 12"
replot input skip 6 using 25 : (sqrt($26) * y_scale) with lines title "" #"M : 13"
replot input skip 6 using 27 : (sqrt($28) * y_scale) with lines title "" #"M : 14"
replot input skip 6 using 29 : (sqrt($30) * y_scale) with lines title "" #"M : 15"
replot input skip 6 using 31 : (sqrt($32) * y_scale) with lines title "" #"M : 16"
replot input skip 6 using 33 : (sqrt($34) * y_scale) with lines title "" #"M : 17"
replot input skip 6 using 35 : (sqrt($36) * y_scale) with lines title "" #"M : 18"
replot input skip 6 using 37 : (sqrt($38) * y_scale) with lines title "" #"M : 19"
replot input skip 6 using 39 : (sqrt($40) * y_scale) with lines title "" #"M : 20"

#f(x) = A * x + B
#A = 100e-6
#B = -1e-3
#
#fit [0.6 : 0.8] f(x) input skip 6 using 1  : (sqrt($2 )) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",1 )
#fit [0.6 : 0.8] f(x) input skip 6 using 3  : (sqrt($4 )) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",2 )
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
#save fit sprintf(".\\fitlog\\%d.fitlog",11)
#fit [0.6 : 0.8] f(x) input skip 6 using 23 : (sqrt($24)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",12)
#fit [0.6 : 0.8] f(x) input skip 6 using 25 : (sqrt($26)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",13)
#fit [0.6 : 0.8] f(x) input skip 6 using 27 : (sqrt($28)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",14)
#fit [0.6 : 0.8] f(x) input skip 6 using 29 : (sqrt($30)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",15)
#fit [0.6 : 0.8] f(x) input skip 6 using 31 : (sqrt($32)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",16)
#fit [0.6 : 0.8] f(x) input skip 6 using 33 : (sqrt($34)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",17)
#fit [0.6 : 0.8] f(x) input skip 6 using 35 : (sqrt($36)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",18)
#fit [0.6 : 0.8] f(x) input skip 6 using 37 : (sqrt($38)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",19)
#fit [0.6 : 0.8] f(x) input skip 6 using 39 : (sqrt($40)) via A, B 
#save fit sprintf(".\\fitlog\\%d.fitlog",20)

f1(x)  = 0.0584338229243382 * x -0.0248574589496742
f2(x)  = 0.0826379049247956 * x -0.0351537556150335
f3(x)  = 0.101210350257164  * x -0.043054381916963 
f4(x)  = 0.116867645941875  * x -0.0497149179890885
f5(x)  = 0.130662000355165  * x -0.0555829680664126
f6(x)  = 0.143133050011626  * x -0.0608880908510184
f7(x)  = 0.15460136375352   * x -0.0657666547415321
f8(x)  = 0.165275809915625  * x -0.0703075112936156
f9(x)  = 0.175301468938749  * x -0.0745723770085942
f10(x) = 0.184783973008756  * x -0.0786061872954154
f11(x) = 0.193803065893495  * x -0.082442864758158 
f12(x) = 0.202420700568236  * x -0.0861087638858085
f13(x) = 0.210686144981945  * x -0.0896248430199569
f14(x) = 0.218639345398239  * x -0.0930080951033937
f15(x) = 0.226313223265871  * x -0.0962725247574401
f16(x) = 0.233735291930435  * x -0.099429836023107 
f17(x) = 0.240928824266884  * x -0.102489929066186 
f18(x) = 0.247913714891775  * x -0.105461266958073 
f19(x) = 0.254707129268613  * x -0.108351151801962 
f20(x) = 0.261324000752084  * x -0.111165936173011 

set xrange[0 : 1]
set yrange[0 : 160]

replot f1(x)  * 1e3
replot f2(x)  * 1e3
replot f3(x)  * 1e3
replot f4(x)  * 1e3
replot f5(x)  * 1e3
replot f6(x)  * 1e3
replot f7(x)  * 1e3
replot f8(x)  * 1e3
replot f9(x)  * 1e3
replot f10(x) * 1e3
replot f11(x) * 1e3
replot f12(x) * 1e3
replot f13(x) * 1e3
replot f14(x) * 1e3
replot f15(x) * 1e3
replot f16(x) * 1e3
replot f17(x) * 1e3
replot f18(x) * 1e3
replot f19(x) * 1e3
replot f20(x) * 1e3

pause -1