#include<stdio.h>
#include<stdlib.h>

int main(void)
{

    FILE* pipe = popen("gnuplot -persist", "w");
    if(pipe == NULL)
    {
        fputs("couldnt open pipe.", stderr);
        return 0;
    }

    //pipe = fopen("plotfile.plt", "w");

    int count = 0;

    //gnuplot setting
    #pragma region 
    fputs("set logscale x\n", pipe);
    fputs("set logscale y\n", pipe);
    fputs("set logscale z\n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    //fputs("set terminal postscript eps enhanced \",\" \n", pipe);
    //fputs("set output \"output.eps\" \n", pipe);
    fputs("set tics font \"Arial,20\"\n", pipe);
    fputs("set xlabel \"frequency [Hz]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    //fputs("set format x \"10^{%%L}\" \n", pipe);
    //fputs("set format y \"10^{%%L}\" \n", pipe);
    fputs("set ylabel \"R [ohm]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key bottom left spacing 2.5 offset 0,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    //fputs("set xtics  offset 0 , -0.8\n", pipe);
    //fputs("set ytics  offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [1e9 : 1e12]\n", pipe);
    fputs("set yrange [1 : 10e3]\n", pipe);
    #pragma endregion

    //凡例の設定
    #pragma region
    /*
    fputs("set label 1   center at graph 0.89 , 0.50 \"10 nH\" font \", 20\" \n", pipe);
    fputs("set label 2   center at graph 0.85 , 0.68 \"15 nH\" font \", 20\" \n", pipe);
    fputs("set label 3   center at graph 0.83 , 0.80 \"20 nH\" font \", 20\" \n", pipe);
    fputs("set label 4   center at graph 0.82 , 0.90 \"25 nH\" font \", 20\" \n", pipe);
    fputs("set label 5   center at graph 0.79 , 0.95 \"30 nH\" font \", 20\" \n", pipe);
    fputs("set label 6   center at graph 0.53 , 0.12 \"10 nH\" font \", 20\" \n", pipe);
    fputs("set label 7   center at graph 0.53 , 0.23 \"15 nH\" font \", 20\" \n", pipe);
    fputs("set label 8   center at graph 0.53 , 0.29 \"20 nH\" font \", 20\" \n", pipe);
    fputs("set label 9   center at graph 0.82 , 0.90 \"     \" font \", 20\" \n", pipe);
    fputs("set label 10  center at graph 0.30 , 0.38 \"30 nH\" font \", 20\" \n", pipe);
    */
    #pragma endregion

    //fputs("input = \"..\\\\data\\\\.vcsv\"\n", pipe);

    fputs("i = {0, 1}  \n", pipe);
    fputs("gm = 24.82e-3  \n", pipe);
    fputs("gce = 52e-6  \n", pipe);
    fputs("gie = 88e-6  \n", pipe);

    //fputs("Gc = 1.15e-3  \n", pipe);
    fprintf(pipe, "Gc = %lf  \n", 1.0/870);

    fprintf(pipe, "Ge = %lf  \n", 1/650);
    
    fputs("Gce = gie + Ge  \n", pipe);
    fputs("Cpd = 16e-15  \n", pipe);
    fputs("Cjc = 2.396e-15  \n", pipe);
    fputs("Cje = 12.95e-15  \n", pipe);

    fputs("p(x, y) = 5e3+x*1e-36 \n", pipe);
    fputs("T(x) = (gm + gce) / ( (gie + Ge) * gce + Gc*( (gie + Ge) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + Ge) + gm + gie + gce) * Cjc + Gc * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", pipe);
    fputs("f(x, y) = (gm + gce) / ( (gie + y) * gce + Gc*( (gie + y) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + y) + gm + gie + gce) * Cjc + Gc * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", pipe);
    fputs("g(x, y) = (gm + gce) / ( (gie + Ge) * gce + y*( (gie + Ge) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + Ge) + gm + gie + gce) * Cjc + y * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", pipe);

    fputs("j(x) = (gm + gce) / ( (gie + 1.0/800) * gce + (1.0/600)*( (gie + 1.0/800) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + 1.0/800) + gm + gie + gce) * Cjc + (1.0/600) * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", pipe);

    fputs("h(x, y, C) = (gm + gce) / ( (gie + y) * gce + C*( (gie + y) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + y) + gm + gie + gce) * Cjc + C * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", pipe);


    //fprintf(pipe, "splot abs(f(x, 1/y)) with lines title \"RE\" , abs(g(x, 1/y)) with lines title \"RC\" \n");    

    for(int i = 0; i < 10; i++)
    {
        fprintf(pipe, "h%d(x, y) = (gm + gce) / ( (gie + y) * gce + %lf*( (gie + y) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + y) + gm + gie + gce) * Cjc + %lf * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", i,  1.0/((i + 1) * 100),  1.0/((i + 1) * 100));    
        fprintf(pipe, "i%d(x, y) = (gm + gce) / ( (gie + %lf) * gce + y*( (gie + %lf) + gm + gie + gce ) + i * 2*pi* x * ( gce*(Cpd+Cje) + ((gie + %lf) + gm + gie + gce) * Cjc + y * (Cpd+Cje) ) - (2 * pi * x)**2 * Cjc * (Cpd + Cje) ) \n", i,  1.0/((i + 1) * 100),  1.0/((i + 1) * 100), 1.0/((i + 1) * 100));
    }

    fprintf(pipe, "splot ");
    for(int i = 0; i < 10; i++)
    {
        fprintf(pipe, "abs(h%d(x, 1/y)) with lines title \"RE : %d\"", i, (i + 1) * 100);

        if(i != 9)
        {
            fprintf(pipe, " , ");
        }
    }
    fprintf(pipe, "\n");

    fprintf(pipe, "plot abs(j(x)) with lines title \"new\", abs(T(x)) with lines title \"pre\" \n");    


    pclose(pipe);

    return 0;
}