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

    //gnuplot setting
    fputs("set datafile separator \",\"\n", pipe);
    //fputs("set logscale x\n", pipe);
    //fputs("set logscale y\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,30\"\n", pipe);
    fputs("set xlabel \"time [ns]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"v_{out} [V]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,18\"\n", pipe);
    fputs("set key center right spacing 2.5 offset 19,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics 0.5 offset 0 , -0.8\n", pipe);
    fputs("set ytics  offset 0 , 0\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics mytics linewidth 2, linewidth 1, linewidth 1, linewidth 0.5\n", pipe);
    fputs("set xrange [0 : 5]\n", pipe);
    fputs("set yrange [0 : 1.8]\n", pipe);

    //凡例の設定
    //fputs("set label 1   center at graph 0.89 , 0.50 \"10 nH\" font \", 20\" \n", pipe);
    //fputs("set label 2   center at graph 0.85 , 0.68 \"15 nH\" font \", 20\" \n", pipe);
    //fputs("set label 3   center at graph 0.83 , 0.80 \"20 nH\" font \", 20\" \n", pipe);
    //fputs("set label 4   center at graph 0.82 , 0.90 \"25 nH\" font \", 20\" \n", pipe);
    //fputs("set label 5   center at graph 0.79 , 0.95 \"30 nH\" font \", 20\" \n", pipe);
//
    //fputs("set label 6   center at graph 0.53 , 0.12 \"10 nH\" font \", 20\" \n", pipe);
    //fputs("set label 7   center at graph 0.53 , 0.23 \"15 nH\" font \", 20\" \n", pipe);
    //fputs("set label 8   center at graph 0.53 , 0.29 \"20 nH\" font \", 20\" \n", pipe);
    //fputs("set label 9   center at graph 0.82 , 0.90 \"     \" font \", 20\" \n", pipe);
    //fputs("set label 10  center at graph 0.30 , 0.38 \"30 nH\" font \", 20\" \n", pipe);

    //データファイルの選択
    fputs("input = \"..\\\\data\\\\buf_tr.vcsv\" \n", pipe);

    fprintf(pipe, "plot   input skip 6 using ($1 * 1e9) : ($2) with lines title \"v_{out}\" \n");
    fprintf(pipe, "replot input skip 6 using ($3 * 1e9) : ($4) with lines title \"v_{in}\" \n");

    pclose(pipe);

    return 0;
}