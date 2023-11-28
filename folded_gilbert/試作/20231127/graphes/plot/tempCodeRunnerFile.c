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
    //fputs("set datafile separator \",\"\n", pipe);
    //fputs("set logscale x\n", pipe);
    //fputs("set logscale y\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,30\"\n", pipe);
    fputs("set xlabel \"freq [Hz]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \" [dB]\" font \"Arial,30\" offset -8,0\n", pipe);
    //fputs("set y2label \"g_{m} [mS]\" font \"Arial,30\" offset 5,0\n", pipe);
    fputs("set key font\"Arial,18\"\n", pipe);
    fputs("set key bottom right spacing 2.5 offset -5,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics offset 0 , -0.8\n", pipe);
    fputs("set ytics offset 0 , 0\n", pipe);
    //fputs("set y2tics 1 offset 0 , 0\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    //fputs("set grid xtics mxtics ytics mytics linewidth 2, linewidth 1, linewidth 1, linewidth 0.5\n", pipe);
    fputs("set xrange  [0 : 1e11]\n", pipe);
    //fputs("set yrange  [0 : 0.9]\n", pipe);
    //fputs("set y2range [16 : 25]\n", pipe);

    //データファイルの選択
    fputs("input = \"..\\\\data\\\\gilbert_fft_log10.data\" \n", pipe);

   fprintf(pipe,   "plot input skip 0 using 1 : 2 with lines notitle  \n");

    pclose(pipe);

    return 0;
}