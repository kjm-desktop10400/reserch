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
    fputs("set xlabel  \"{/BKM-cmmi10=25 V_{GS}}&{a}{/BKM-cmr10=25 [V]}\" offset 0,-3\n", pipe);
    fputs("set ylabel  \"{/BKM-cmmi10=25 I_{D}}&{a}{/BKM-cmr10=25 [mA]}\" offset -7,0\n", pipe);
    fputs("set y2label \"{/BKM-cmmi10=25 g_{m}}&{a}{/BKM-cmr10=25 [mS]}\" offset  8,0\n", pipe);
    fputs("set key font\"BKM-cmmi10,25\"\n", pipe);
    fputs("set key top left spacing 2.5 offset 22,0\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 7\n", pipe);
    fputs("set tmargin 1\n", pipe);
    fputs("set tics font \"BKM-cmmi10,25\"\n", pipe);
    fputs("set xtics  font \"BKM-cmmi10,25\" offset 0 , -0.8\n", pipe);
    fputs("set ytics  font \"BKM-cmmi10,25\" offset 0 , 0\n", pipe);
    fputs("set y2tics 0.1 font \"BKM-cmmi10,25\" offset 0 , 0\n", pipe);
    fputs("set mxtics 10\n", pipe);
    fputs("set mytics 5\n", pipe);
    //fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set grid xtics mxtics ytics y2tics linewidth 2, linewidth 1, linewidth 2, linewidth 1\n", pipe);
    fputs("set xrange  [0 : 1.8]\n", pipe);
    fputs("set yrange  [0 : 0.6]\n", pipe);
    fputs("set y2range [0 : 0.6]\n", pipe);  
    #pragma endregion

    //凡例の設定
    #pragma region legends
    
    //fputs("set label 6  right  at graph 0.25  , 0.28  \"V_{CTRL} = \" font \"BKM-cmmi10, 20\" \n", pipe);
    //fputs("set label 1  left   at graph 0.27  , 0.28  \"20 \"         font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 2  left   at graph 0.27  , 0.44  \"40 \"         font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 3  left   at graph 0.27  , 0.53  \"60 \"         font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 4  left   at graph 0.27  , 0.60  \"80 \"         font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 5  left   at graph 0.27  , 0.92  \"200 \"        font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 12 center at graph 0.35  , 0.28  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 22 center at graph 0.35  , 0.44  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 32 center at graph 0.35  , 0.53  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 42 center at graph 0.35  , 0.60  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    //fputs("set label 52 center at graph 0.374 , 0.92  \"mV\"          font \"BKM-cmr10, 20\" \n", pipe);
    
    #pragma endregion

    #pragma region objects

    fputs("set style arrow 1 head size screen 0.012,30,60 filled front lw 1.5  \n", pipe);

    fputs("set object 1 ellipse at 1.4,0.38 size 0.07,0.2 angle 30 unit xx front fillcolor black linewidth 0.7 \n", pipe);
    fputs("set arrow  1 from 1.33,0.39 to 1.2,0.39 as 1 black \n", pipe);

    fputs("set object 2 ellipse at 1,0.48 size 0.07,0.2 angle 0 unit xx front fillcolor black linewidth 1 \n", pipe);
    fputs("set arrow  2 from 1.03,0.51 to 1.16,0.51 as 1 black \n", pipe);

    fputs("set object 3 ellipse at 0.775,0.55 size 0.07,0.2 angle 60 unit xx front fillcolor black linewidth 1 \n", pipe);
    fputs("set arrow  3 from 0.87,0.54 to 1,0.54 as 1 black \n", pipe);

    #pragma endregion

    fputs("input = \"id_vgs.vcsv\"\n", pipe);

    fprintf(pipe, "plot   input skip 6 using 1 : (($4) * 1e3) axis x1y1 black with lines notitle  \n");
    fprintf(pipe, "replot input skip 6 using 1 : (($2) * 1e3) axis x1y2 black with lines notitle  \n");

    fprintf(pipe, "f(x) =K * (x - Vth) \n");
    fprintf(pipe, "K = 100e-6 \n");
    fprintf(pipe, "Vth = 0.4 \n");
    fprintf(pipe, "fit [0.5:0.65] f(x) input skip 6 using 1 : 2 via K, Vth \n");

    fprintf(pipe, "replot [:] f(x)*1e3 axis x1y2 black dt 2 notitle \n");


    pclose(pipe);

    return 0;
}