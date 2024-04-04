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

    int count = 0;

    double fit_s = 0;
    double fit_e = 0;

    //gnuplot setting
    #pragma region 
    //fputs("set logscale x\n", pipe);
    //fputs("set logscale y\n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,20\"\n", pipe);
    fputs("set xlabel \"Voltage [V]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"Current [mA]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key center right spacing 2.5 offset 22,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics  offset 0 , -0.8\n", pipe);
    fputs("set ytics  offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [0 : 1.2]\n", pipe);
    fputs("set yrange [-0.5 : 6]\n", pipe);
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

    fputs("input = \"..\\\\data\\\\Ic_Vbe_vcc.vcsv\"\n", pipe);

    fprintf(pipe, "plot   input skip 6 using (($33) * 1e0) : (($34) * 1e3) with lines notitle \n");

    fit_s = 0.7;
    fit_e = 1;

    fprintf(pipe, "Is = 1e-9\n nVt = 26*1e-3\n");
    fprintf(pipe, "f(x) = Is * (exp(x / nVt) - 1) \n");
    fprintf(pipe, "fit[%lf : %lf] f(x) input using 33 : 34 via Is, nVt \n", fit_s, fit_e);
    fprintf(pipe, "replot [%lf : %lf] f(x) * 1e3 with lines dt 3 notitle \n", fit_s, 1.8);

    pclose(pipe);

    return 0;
}