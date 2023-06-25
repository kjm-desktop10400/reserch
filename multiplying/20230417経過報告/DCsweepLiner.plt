set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set tics font "Arial,30"
set xlabel "Vin [V]" font "Arial,30" offset 0,-3
set ylabel "vout [V]" font "Arial,30" offset -20,0
set key font"Arial,20"
set key bottom spacing 2 offset 0, 2
set lmargin 35
set rmargin 5
set bmargin 8
set tmargin 3
set tics font "Arial,30"
set xtics 0.1 offset -3, -1
set mxtics 5
set mytics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
set xrange [-0.2 : 0.2]
set yrange [-0.2 : 0.2]

plot for [i = 1 : 5] "DCsweep.txt" using 1 : i + 1 with lines notitle

#Arraty line_color[5]
#line_color[1] = "dark-magenta"
#line_color[2] = "web-green"
#line_color[3] = "dark-cyan"
#line_color[4] = "orange"
#line_color[5] = "goldenrod"
#Array slope[5]
#Array intercept[5]
#do for[i = 1 : 5]{
#    fit [-0.01 : 0.01] slope[i] * x + intercept[i] "DCsweep.txt" using 1 : i + 1 via slope[i], intercept[i]
#    replot slope[i] * x + intercept[i] lc rgb line_color[i] dt 3 title sprintf("slope : %d", slope[i])
#}

line1(x) = 0.3148 * x - 1.486e-07
line2(x) = 0.6478 * x - 3.235e-07
line3(x) = 1.011 * x - 5.732e-07
line4(x) = 1.399 * x - 9.842e-07
line5(x) = 1.768 * x - 1.54e-06
replot line1(x) lc rgb "dark-magenta" dt 3 title sprintf("slope : 0.3148")
replot line2(x) lc rgb "web-green" dt 3 title sprintf("slope : 0.6478")
replot line3(x) lc rgb "dark-cyan" dt 3 title sprintf("slope : 1.011")
replot line4(x) lc rgb "orange" dt 3 title sprintf("slope : 1.399")
replot line5(x) lc rgb "goldenrod" dt 3 title sprintf("slope : 1.768")