set datafile separator ","


set xrange [0 : 1]

K = 7.03515e-05  
W = 1e-6
L = 1e-6
Vth = 0.375259 
lambda = 0.142133 
Vds = 0.9

Id(x) = K * (W / L) * ((x - Vth)**2) * (1 + lambda * Vds) 
plot "specter_output.vcsv" skip 6 using 1 : 2 with lines title "Id"
replot Id(x) title "approximate"

