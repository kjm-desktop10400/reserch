set xlabel "Hz"
set ylabel "Vout"
set grid
name(i) = sprintf("Vctrl = %d mV", 50 * i) 
plot for [i = 1 : 4] "input.dat" using 2 * i - 1 : 2 * i with lines title name(i)