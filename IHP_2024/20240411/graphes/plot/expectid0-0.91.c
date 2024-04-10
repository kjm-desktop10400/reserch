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
        5.22674633492532e-13,
        4.92516675336137e-13,
        4.6292103947011e-13	,
        4.34539472327628e-13,
        4.07086128909925e-13,
        3.80589363712121e-13,
        3.5508236115376e-13	,
        3.30600302057624e-13,
        3.07442908549372e-13,
        2.85081475937763e-13,
        2.6379033261205e-13	,
        2.43541689885933e-13,
    };

    double nVt[]  = {
        0.0424128699332232,
        0.0422700958252106,
        0.0421213775181314,
        0.0419723156196243,
        0.0418200286454793,
        0.0416644779344385,
        0.0415056683652256,
        0.0413436414215174,
        0.041181269951981 ,
        0.0410129458384106,
        0.0408413023544324,
        0.0406659922904669,
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

    fprintf(pipe, "plot (%e * (exp(x / %e) - 1) * 1e3) with lines dt 3 lw 3 black notitle \n", aveIs, aveNVt);

    for(int i = 7; i <= 17; i++)
    {
        fprintf(pipe, "replot input skip 6 using ($%d) : (($%d) * 1e3) with lines notitle \n", 2 * i - 1, 2 * i);
    }

    pclose(pipe);

    return 0;
}