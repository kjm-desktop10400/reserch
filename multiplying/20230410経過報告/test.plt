#set xrange [-0.2 : 0.2]
#set yrange [-0.2e1 : 0.2e1]
#set xtics 0.1
#set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1

#K = 1.56e-4
I = 20e-5
R = 10e3
Vctrl = 100e-3 
set dummy vin, K
f(v,i,K) = i / 2 + v * sqrt((i * K / 2) * (1 - K / (2 * i) * v ** 2)  )  
IB1(vin,K) = f(2  * vin, I, K)                                                  
IB2(vin,K) = f(-2 * vin, I, K)
IA1(vin,K) = f(2 * Vctrl,  IB1(vin, K), K)  
IA2(vin,K) = f(-2 * Vctrl, IB1(vin, K), K)  
IA3(vin,K) = f(-2 * Vctrl, IB2(vin, K), K)  
IA4(vin,K) = f(2 * Vctrl,  IB2(vin, K), K)  
vout(vin, K) = R * (IA1(vin, K) - IA2(vin, K) + IA3(vin, K) - IA4(vin, K))  
splot IA1(vin,K)
#pause -1