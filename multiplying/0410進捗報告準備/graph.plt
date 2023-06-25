set xlabel "v1 - v2" font "Arial,30" offset 0,-3
set ylabel "Id" font "Arial,30" offset -30,0
set tics font "Arial,30"
set key font"Arial,20"
set lmargin 50
set bmargin 8
set tmargin 3 
set key bottom spacing 1.9 offset 0, 2
set xtics offset 0, -1
set ytics 4e-6
set mxtics 5
set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1
I = 1e-5
K = 7e-5
min = -0.5
max = 0.5
plot [min : max] I / 2 + sqrt(I * K / 2) * x * sqrt(1 - K * (x**2) / (2 * I)) title "original"
replot [min : max] I / 2 + x * sqrt(I * K / 2) title "approximation"