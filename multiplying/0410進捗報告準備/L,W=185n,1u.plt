set xrange[0.4:1]
set yrange[0:]
name(i) = sprintf("Vds = %s mV", columnhead(2 * i - 1))
f(x) = a * x + b
plot for [i = 1 : 5] "L,W=185n,1u.dat" using 2 * i - 1 : 2 * i with lines title name(i)
array A[5]
array B[5]
do for [i = 1 : 5]{
fit [0.7 : 1] f(x) "L,W=185n,1u.dat" using 2 * i - 1 : 2 * i via a, b
A[i] = a
B[i] = b
}
replot for [i = 1 : 5] A[i] * x + B[i] title sprintf("liner recursion %4d mV", 200 * i) dt 3