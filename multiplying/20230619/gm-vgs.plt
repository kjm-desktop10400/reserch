set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "vgs [V]" font "Arial,30" offset 0,-3
set ylabel "gm [S]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key top left spacing 2 offset 40, -2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,25"
#set xtics 1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

plot "gm-vgs.txt" using 1 : 2 with lines title sprintf("Vsb = %.1f", 0.1 * 0)
replot "gm-vgs.txt" using 1 : 3  with lines title sprintf("Vsb = %.1f", 0.1 * 1)
replot "gm-vgs.txt" using 1 : 4  with lines title sprintf("Vsb = %.1f", 0.1 * 2)
replot "gm-vgs.txt" using 1 : 5  with lines title sprintf("Vsb = %.1f", 0.1 * 3)
replot "gm-vgs.txt" using 1 : 6  with lines title sprintf("Vsb = %.1f", 0.1 * 4)
replot "gm-vgs.txt" using 1 : 7  with lines title sprintf("Vsb = %.1f", 0.1 * 5)
replot "gm-vgs.txt" using 1 : 8  with lines title sprintf("Vsb = %.1f", 0.1 * 6)
replot "gm-vgs.txt" using 1 : 9  with lines title sprintf("Vsb = %.1f", 0.1 * 7)
replot "gm-vgs.txt" using 1 : 10 with lines title sprintf("Vsb = %.1f", 0.1 * 8)
replot "gm-vgs.txt" using 1 : 11 with lines title sprintf("Vsb = %.1f", 0.1 * 9)

pause -1