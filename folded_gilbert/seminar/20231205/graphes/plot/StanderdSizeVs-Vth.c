#include<stdio.h>
#include<stdlib.h>

#define DATA_NUM    8      //入力データ数

int main(void)
{

    FILE* pipe = popen("gnuplot -persist", "w");
    if(pipe == NULL)
    {
        fputs("couldnt open pipe.", stderr);
        return 0;
    }

    int count = 0;

    //gnuplot setting
    #pragma region 
    //fputs("set logscale x\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,30\"\n", pipe);
    fputs("set xlabel \"frequency [Hz]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"magnitude [dB]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key top left spacing 2.5 offset 30,-2\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics offset 0 , -0.8\n", pipe);
    fputs("set ytics offset 0 , 0\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [0.4 :1]\n", pipe);
    fputs("set yrange [0 : 1.5]\n", pipe);
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

    fputs("set datafile separator \",\"\n", pipe);
    fputs("input = \"..\\\\data\\\\NtoN_dc.vcsv\"\n", pipe);
    fputs("param = \"..\\\\data\\\\StanderdSizeVs-Vthfitting\\\\fit_param.dat\"\n", pipe);

    double parametor[9][2] = {
        {0.00308105405607822,-0.00184596849623672},
        {0.0030077185788975,-0.00182576842876109},
        {0.0029346726827454,-0.00180166121305549},
        {0.00286252791610072,-0.00177470246030111},
        {0.0027918030795547,-0.00174577420860902},
        {0.00272291891176586,-0.00171560276844272},
        {0.0026562023832666,-0.0016847780813811},
        {0.00259189597698924,-0.00165377300510517},
        {0.00315399686914752,-0.00186101790392019}
        };

    //plot
    for(int i = 0; i < DATA_NUM; i++)
    {
        if(i == 0)
        {
            fprintf(pipe, "plot input skip 6 using 1 : (($%d) * 1e3) with lines title \"Vs = %.1lf V\"\n", 2 * (i + 1), ((i + 1) * 0.1));
        }
        else 
        {
            fprintf(pipe, "replot input skip 6 using 1 : (($%d) * 1e3) with lines title \"Vs = %.1lf V\"\n", 2 * (i + 1), ((i + 1) * 0.1));
        }

        //fprintf(pipe, "f%d(x) = %lf * x + %lf\n", i, parametor[i][0], parametor[i][1]);
        //fprintf(pipe, "replot f%d(x) * 1e3 dt 3 notitle\n", i);
    }

    pclose(pipe);

    



    return 0;
}