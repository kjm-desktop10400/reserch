set datafile separator ","
#set multiplot
set logscale x

set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "frequency [Hz]" font "Arial,30" offset 0,-1
set ylabel "phase [deg]" font "Arial,30" offset -8,0
#set y2label "g_{m} [mS]" font "Arial,30" offset 8,0
set key font"Arial,25"
set key bottom left spacing 2.5 offset 35,2
set terminal windows size 1000,700
set lmargin 20
set rmargin 20
set bmargin 6
set tmargin 2
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set ytics
#set y2tics 1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

set xrange [1e6 : ]
set yrange [ : 10]
#set y2range [0 : 6]

###################################################################
#       M = 1
#       L = 0.72u
#       W = 20u
#       vds = 1
#       Vgs = 0 - 1
#       Vbs = 0
#
#       vin = vgs
#
###################################################################

#x_scale = 1e3
#y_scale = 1e3

input = "data\\pahse_sim.vcsv"

plot   input skip 6 using 1  : 2  with lines title sprintf("VCTRL :   %d [mV]", 50)
replot input skip 6 using 3  : 4  with lines title sprintf("VCTRL : %d [mV]", 100 )
replot input skip 6 using 5  : 6  with lines title sprintf("VCTRL : %d [mV]", 150 )
replot input skip 6 using 7  : 8  with lines title sprintf("VCTRL : %d [mV]", 200 )
replot input skip 6 using 9  : 10 with lines title sprintf("VCTRL : %d [mV]", 250 )
replot input skip 6 using 11 : 12 with lines title sprintf("VCTRL : %d [mV]", 300 )
replot input skip 6 using 13 : 14 with lines title sprintf("VCTRL : %d [mV]", 350 )
replot input skip 6 using 15 : 16 with lines title sprintf("VCTRL : %d [mV]", 400 )

pause -1