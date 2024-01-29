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
    //fputs("set format x \"10^{%L}\" font \"BKM-cmmi10,25\" \n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xlabel \"v_{refU} [V]\"  font \"BKM-cmr10,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"dI/dV_{refU} [mS]\" font \"BKM-cmr10,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key bottom right spacing 2.5 offset -22,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"BKM-cmmi10,25\"\n", pipe);
    fputs("set xtics 0.05 offset 0 , -0.8\n", pipe);
    fputs("set ytics  offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    //fputs("set xrange [1e6 : 1e12]\n", pipe);
    //fputs("set yrange [-1.5 : 1.5]\n", pipe);
    #pragma endregion

    //凡例の設定
    #pragma region
    
//    fputs("set label 6  right  at 0.15  , 0.07  \"V_{CTRL} = \" font \"BKM-cmmi10, 20\" \n", pipe);
//    fputs("set label 1  left   at 0.15  , 0.07  \"20 \"         font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 2  left   at 0.15  , 0.32  \"40 \"         font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 3  left   at 0.15  , 0.53  \"60 \"         font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 4  left   at 0.15  , 0.70  \"80 \"         font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 5  left   at 0.15  , 1.31  \"200 \"        font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 12 center at 0.18  , 0.07  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 22 center at 0.18  , 0.32  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 32 center at 0.18  , 0.53  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 42 center at 0.18  , 0.70  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
//    fputs("set label 52 center at 0.189 , 1.31  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    
    #pragma endregion

    fputs("TF = \"Vref_IU_TF.vcsv\" \n", pipe);
    fputs("TT = \"Vref_IU_TT.vcsv\" \n", pipe);
    fputs("TS = \"Vref_IU_TS.vcsv\" \n", pipe);

    fputs("plot   TF skip 6 using 1 : ($4) * 1e3 with lines title \"TF\" \n", pipe);
    fputs("replot TT skip 6 using 1 : ($4) * 1e3 with lines title \"TT\" \n", pipe);
    fputs("replot TS skip 6 using 1 : ($4) * 1e3 with lines title \"TS\" \n", pipe);

    pclose(pipe);

    return 0;
}