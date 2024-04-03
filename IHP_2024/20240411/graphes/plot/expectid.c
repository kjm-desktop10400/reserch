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
    //fputs("set datafile separator \",\" \n", pipe);
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
    //fputs("set yrange [-0.5 : 6]\n", pipe);
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

    fputs("input = \"..\\\\data\\\\fit_param.dat\"\n", pipe);
    
    double Is[]  = {1.11170860541161e-16 ,
                    -4.1939998695612e-06 ,
                    3.72109657804553e-16 ,
                    9.97445399511497e-16 ,
                    -1.99573687115542e-06,
                    9.93578688160171e-15 ,
                    3.78098348096064e-14 ,
                    -5.06425976254592e-05,
                    5.04740602297164e-13 ,
                    1.85498501854192e-12 ,
                    2.18892456293681     ,
                    -103.400585050921    ,
                    -23902.7194104083    ,
                    -238517.459374802    ,
                    990.192068164852     ,
                    197.00208400261      ,
                    1282.70340164136};

    double nVt[]  = {0.0297325949613834  ,
                    0.000479855143422414,
                    0.0310618062401813  ,
                    0.0322605059162088  ,
                    0.000918334902307028,
                    0.0353987760759854  ,
                    0.0374873741806549  ,
                    0.000717906238011878,
                    0.0422428561355249  ,
                    0.0450691646425714  ,
                    3417.34967959301    ,
                    -136745.872385607   ,
                    -27295450.759349    ,
                    -233293633.33112    ,
                    841569.422943622    ,
                    145756.2806498      ,
                    838171.526971914    };

    fprintf(pipe, "plot %lf * (exp(x / %lf) - 1) notitle \n", Is[0], nVt[0]);

    for(int i = 2; i <= 17; i++)
    {
        fprintf(pipe, "replot %lf * (exp(x / %lf) - 1) notitle \n", Is[i - 1], nVt[i - 1]);
    }

    pclose(pipe);

    return 0;
}