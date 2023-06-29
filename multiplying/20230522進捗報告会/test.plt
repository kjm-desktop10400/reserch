set logscale x
set xrange [1e-3:1e3]

a=1e-3
b=1e-3
c=1e-3
d=1e-3

f(x)=d*x**2
g(x)=f(x)+c*x**3
h(x)=g(x)+b*x**4
i(x)=(1+a*x)*(1+b*x)
i(x)=1/i(x)

#F(x)=20*log10(1/f(x))
#G(x)=20*log10(1/g(x))
#H(x)=20*log10(1/h(x))
#I(x)=20*log10(1/i(x))

F(x)=atan(x/f(x))
G(x)=atan(x/g(x))
H(x)=atan(x/h(x))
I(x)=atan(x/i(x))

#plot F(x),G(x),H(x),I(x)

a=1e0
plot I(x) title "1e-3 : a , other 1e0"
a=1e-3
b=1e0
replot I(x) title "1e-3 : b , other 1e0"
b=1e-3
c=1e0
replot I(x) title "1e-3 : c , other 1e0"
c=1e-3
d=1e0
replot I(x) title "1e-3 : d , other 1e0"