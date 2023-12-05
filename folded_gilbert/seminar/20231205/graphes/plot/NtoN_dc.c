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
    //fputs("set logscale x\n", pipe);
    //fputs("set logscale y\n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,20\"\n", pipe);
    fputs("set xlabel \"v_{in} [V]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"v_{out} [V]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key center right spacing 2.5 offset 22,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics offset 0 , -0.8\n", pipe);
    fputs("set ytics 0.25 offset 0 , 0\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [-0.2 : 0.2]\n", pipe);
    fputs("set yrange [-1.6 : 1.6]\n", pipe);
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

    fputs("input = \"..\\\\data\\\\NtoN_dc.vcsv\"\n", pipe);

    for(int i = 1; i*0.02 <= 0.31; i++)
    {

        fprintf(pipe, "A%d = 1\n", i);
        fprintf(pipe, "B%d = 0.6\n", i);
        fprintf(pipe, "f%d(x) = A%d * x + B%d\n", i, i, i);
        
        if(i == 1)
        {
            fprintf(pipe, "plot input skip 6 using %d : (($%d) * 1e0) with lines title \"%.2f V\" \n", 2 * i - 1, 2 * i, i * 0.02);
        }
        else 
        {
            fprintf(pipe, "replot input skip 6 using %d : (($%d) * 1e0) with lines title \"%.2f V\" \n", 2 * i - 1, 2 * i, i * 0.02);
        }

        fprintf(pipe, "fit [-0.1 : 0.1] f%d(x) input skip 6 using %d : %d via A%d, B%d \n",i ,2 * i - 1, 2 * i, i, i);

        fprintf(pipe, "replot f%d(x) with lines dt 3 notitle \n", i);

        fprintf(pipe, "save fit sprintf(\"..\\\\data\\\\dc_fitlog\\\\fitlog\\\\%d.fitlog\") \n", i);

    }

    pclose(pipe);

    return 0;
}