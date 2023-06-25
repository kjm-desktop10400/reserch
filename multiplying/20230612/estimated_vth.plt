set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vsb [V]" font "Arial,30" offset -5,-3
set ylabel "Vth [V]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top left spacing 2 offset 60, -2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

vth(x) = A * x + B

plot "estimated_vth.txt" skip 1 using 1 : 3 title "Vth"
fit [0 : 1] vth(x) "" skip 1 using 1 : 3 via A , B
replot [0 : 1] vth(x) title sprintf("%f * Vsb + %f", A , B) 

#pause -1