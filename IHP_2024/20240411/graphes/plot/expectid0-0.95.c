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
        //3.48196667569282e-15,
        3.52423814881671e-11,
        3.36414131455186e-11,
        3.20558170724802e-11,
        3.04873493990323e-11,
        2.89384681088216e-11,
        2.74125919693542e-11,
        2.59144177328305e-11,
        2.44499577139157e-11,
        2.30261899582338e-11,
        2.16503692821407e-11,
        1.98860014789617e-11,
    };

    double nVt[]  = {
        //0.0349377704294937,
        0.0532066161470912,
        0.0530200870142561,
        0.0528286252075968,
        0.0526319998859215,
        0.0524300358427989,
        0.0522226505868521,
        0.0520099088914408,
        0.0517920592931844,
        0.0515695321490225,
        0.0513428907181747,
        0.0510574836850415,
    };

    double aveIs = 0;
    double aveNVt = 0;

    for(int i = 0; i < 11; i++)
    {
        aveIs += Is[i];
        aveNVt += nVt[i];
    }
    aveIs /=  11;
    aveNVt /= 11;

    printf("Is : %e\tnVt : %e\n", aveIs, aveNVt);

    fprintf(pipe, "plot (%e * (exp(x / %e) - 1) * 1e3) with lines dt 3 lw 3 black notitle \n", aveIs, aveNVt);

    for(int i = 7; i <= 17; i++)
    {
        fprintf(pipe, "replot input skip 6 using ($%d) : (($%d) * 1e3) with lines notitle \n", 2 * i - 1, 2 * i);
    }

    pclose(pipe);

    return 0;
}