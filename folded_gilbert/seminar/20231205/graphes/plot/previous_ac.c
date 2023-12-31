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
    #pragma region 
    fputs("set logscale x\n", pipe);
    //fputs("set logscale y\n", pipe);
    fputs("set format x \"10^{%L}\" \n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,20\"\n", pipe);
    fputs("set xlabel \"freq [Hz]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel  \"gain [dB]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set y2label \"pahse [deg]\" font \"Arial,30\" offset 7,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key top left spacing 2.5 offset 15, -5\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics    offset 0 , -0.8\n", pipe);
    fputs("set ytics   offset 0 , 0\n", pipe);
    fputs("set y2tics  offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set my2tics 5\n", pipe);
    fputs("set grid xtics mxtics ytics mytics linewidth 2, linewidth 1, linewidth 1 linewidth 1\n", pipe);
    fputs("set xrange [1e6 : 1e12]\n", pipe);
    //fputs("set yrange [-6 : -3]\n", pipe);
    //fputs("set y2range [0 : 9]\n", pipe);
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

    fputs("input = \"..\\\\data\\\\previous_ac.vcsv\"\n", pipe);

    fputs(" plot   input skip 6 using 3 : 4 axis x1y2 with lines title \"phase\" \n", pipe);
    fputs(" replot input skip 6 using 1 : 2 axis x1y1 with lines title \"gain\" \n", pipe);

    pclose(pipe);

    return 0;
}