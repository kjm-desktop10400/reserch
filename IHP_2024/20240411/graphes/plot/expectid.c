#include<stdio.h>
#include<stdlib.h>
#include<string.h>

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
    fputs("set xlabel \"V_{BE} [V]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"I_{C} [mA]\" font \"Arial,30\" offset -8,0\n", pipe);
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
    fputs("set xrange [0.6 : 1.1]\n", pipe);
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
    
    double Is[]  = {
        1.87173845572722e-09,
        1.77227676550119e-09,
        1.71648543261281e-09,
        1.66250782567958e-09,
        1.60793200687931e-09,
        1.55257654051431e-09,
        1.49653028086608e-09,
        1.43981639266176e-09,
        1.38270040051655e-09,
        1.32552336928955e-09,
        1.26877021360967e-09,
        1.21307502008694e-09
    };

    double nVt[]  = {
        0.0694404644407099,
        0.0690775340254522,
        0.0688336960843752,
        0.0685902228537533,
        0.0683395818245278,
        0.0680806984047932,
        0.067813281130594 ,
        0.0675367634013803,
        0.067251352712556 ,
        0.066957530381003 ,
        0.0666563532815534,
        0.0663495733765555
    };

    double aveIs = 0;
    double aveNVt = 0;

    for(int i = 0; i < 12; i++)
    {
        aveIs += Is[i];
        aveNVt += nVt[i];
    }
    aveIs /= 12;
    aveNVt /= 12;

    printf("Is : %e\tnVt : %e\n", aveIs, aveNVt);

    fprintf(pipe, "plot (%e * (exp(x / %e) - 1) * 1e3) with lines dt 3 lw 3 black notitle \n", aveIs, aveNVt);

    for(int i = 6; i <= 17; i++)
    {
        fprintf(pipe, "replot input skip 6 using ($%d) : (($%d) * 1e3) with lines notitle \n", 2 * i - 1, 2 * i);
    }

    pclose(pipe);

    return 0;
}