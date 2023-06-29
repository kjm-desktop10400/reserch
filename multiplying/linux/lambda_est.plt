set datafile separator ","

set xrange [0.5e-6 : 5e-6]

set dummy L
Id(L) = K *(1 + delta / L) / L

vds = 0.9
K = 1e-12
delta = 0.5

plot "specter_output.vcsv" skip 6 using 1 : 2 with lines title "Id"
fit Id(L) "specter_output.vcsv" skip 6 via K, delta
replot Id(L)