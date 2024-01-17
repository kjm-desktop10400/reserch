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
    fputs("set format x \"10^{%L}\" font \"BKM-cmmi10,25\" \n", pipe);
    fputs("set datafile separator \",\" \n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xlabel \"Freq [Hz]\" font \"BKM-cmr10,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"Gain [dB]\" font \"BKM-cmr10,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key center right spacing 2.5 offset 22,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"BKM-cmmi10,25\"\n", pipe);
    fputs("set xtics  offset 0 , -0.8\n", pipe);
    fputs("set ytics  offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [1e6 : 1e12]\n", pipe);
    fputs("set yrange [-25 : 15]\n", pipe);
    #pragma endregion

    //凡例の設定
    #pragma region
    
    fputs("set label 6  right  at graph 0.25  , 0.28  \"V_{CTRL} = \" font \"BKM-cmmi10, 20\" \n", pipe);
    fputs("set label 1  left   at graph 0.27  , 0.28  \"20 \"         font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 2  left   at graph 0.27  , 0.44  \"40 \"         font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 3  left   at graph 0.27  , 0.53  \"60 \"         font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 4  left   at graph 0.27  , 0.60  \"80 \"         font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 5  left   at graph 0.27  , 0.92  \"200 \"        font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 12 center at graph 0.35  , 0.28  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 22 center at graph 0.35  , 0.44  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 32 center at graph 0.35  , 0.53  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 42 center at graph 0.35  , 0.60  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    fputs("set label 52 center at graph 0.374 , 0.92  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    
    #pragma endregion

    fputs("input = \"folded_ac.vcsv\"\n", pipe);

    for(int i = 1; i*0.02 <= 0.2; i++)
    {
        if(i == 1)
        {
            fprintf(pipe, "plot input skip 6 using %d : (($%d) * 1e0) black with lines notitle  \n", 2 * i - 1, 2 * i);
        }
        else 
        {
            fprintf(pipe, "replot input skip 6 using %d : (($%d) * 1e0) black with lines notitle  \n", 2 * i - 1, 2 * i);
        }

    }

    pclose(pipe);

    return 0;
}