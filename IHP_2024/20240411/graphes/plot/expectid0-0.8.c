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
    fputs("set logscale y\n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,20\"\n", pipe);
    fputs("set xlabel \"V_{BE} [V]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"I_{C} [A]\" font \"Arial,30\" offset -8,0\n", pipe);
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
    fputs("set xrange [ : 1.1]\n", pipe);
    fputs("set yrange [1e-15 : 6]\n", pipe);
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
        1.31098878686215e-17,
        1.28471816890667e-17,
        1.25875901878789e-17,
        1.23311906674405e-17,
        1.20781533306404e-17,
        1.18287051901297e-17,
        1.15830853131546e-17,
        1.13414117356266e-17,
        1.11037330089715e-17,
        1.08698011472219e-17,
        1.06391458974873e-17,
        1.04109922439517e-17,
    };

    double nVt[]  = {
        0.0274932913692731,
        0.0274716177729068,
        0.0274498459543436,
        0.0274279730494856,
        0.0274060045523471,
        0.0273839501677347,
        0.0273618193807306,
        0.0273396055462234,
        0.0273172949784527,
        0.0272948368968566,
        0.0272721538211124,
        0.0272491289060359,
    };

    double aveIs = 0;
    double aveNVt = 0;

    for(int i = 0; i < 12; i++)
    {
        aveIs += Is[i];
        aveNVt += nVt[i];
    }
    aveIs /=  12;
    aveNVt /= 12;

    printf("Is : %e\tnVt : %e\n", aveIs, aveNVt);

    fprintf(pipe, "plot (%e * (exp(x / %e) - 1) * 1e0) with lines dt 3 lw 3 black notitle \n", aveIs, aveNVt);

    for(int i = 7; i <= 17; i++)
    {
        fprintf(pipe, "replot input skip 6 using ($%d) : (($%d) * 1e0) with lines notitle \n", 2 * i - 1, 2 * i);
    }

    pclose(pipe);

    return 0;
}