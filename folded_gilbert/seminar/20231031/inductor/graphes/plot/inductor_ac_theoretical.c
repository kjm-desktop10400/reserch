#include<stdio.h>
#include<stdlib.h>

#define ROW 7       //行
#define COLUMN 5    //列

int main(void)
{

    FILE* input = fopen("..\\data\\dcop.data", "r");
    if(input == NULL)
    {
        fputs("couldnt open file.", stderr);
        return 0;
    }

    enum annotato
    {
        L,
        gmn,
        gmp,
        gds,
        cgs,
        cdg,
        cds
    };

    char buf;
    char dcop[COLUMN][ROW][100];
    fputs("skip first line.\n", stdout);
    while(1)
    {
        buf = fgetc(input);
        if(buf == '\n')
        {
            fputs("\nfinished read first line.\n", stdout);
            break;
        }
        else
        {
            fputc(buf, stdout);
        }
    }


    for(int i = 0; i < COLUMN; i++)
    {
        for(int j = 0; j < ROW; j++)
        {
            int count = 0;
            while(1)
            {
                buf = fgetc(input);
                if(buf == EOF)
                {
                    fputs("input file end.\n", stdout);
                    return 0;
                }
                if(buf == '\t' || buf == '\n')
                {
                    break;
                }
                if(buf == 'E')
                {
                    buf = 'e';
                }
                dcop[i][j][count] = buf;
                //putc(dcop[i][j][count], stdout);
                count++;
            }
            dcop[i][j][count] = '\0';
            //putc('\t', stdout);
            
        }

        //fputs("\n", stdout);
    }

    fputs("finished reading file.\n", stdout);
    fclose(input);

    FILE* pipe = popen("gnuplot -persist", "w");
    if(pipe == NULL)
    {
        fputs("couldnt open pipe.", stderr);
        return 0;
    }

    int count = 0;

    //gnuplot setting
    fputs("set logscale x\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,30\"\n", pipe);
    fputs("set xlabel \"frequency [Hz]\" font \"Arial,30\" offset 0,-1.5\n", pipe);
    fputs("set ylabel \"magnitude [dB]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key top left spacing 2.5 offset 15,-2\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set xtics offset 0 , -0.8\n", pipe);
    fputs("set ytics offset 0 , 0\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [2e8 :3e10]\n", pipe);
    fputs("set yrange [-10 : 20]\n", pipe);

    //凡例の設定
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

    for(int i = 0; i < COLUMN; i++)
    {

        fprintf(pipe, "L%d = %s*1e-9\n", i, dcop[i][L]);
        fprintf(pipe, "gmn%d = %s\n", i, dcop[i][gmn]);
        fprintf(pipe, "gmp%d = %s\n", i, dcop[i][gmp]);
        fprintf(pipe, "gds%d = %s\n", i, dcop[i][gds]);
        fprintf(pipe, "cgs%d = %s\n", i, dcop[i][cgs]);
        fprintf(pipe, "cdg%d = %s\n", i, dcop[i][cdg]);
        fprintf(pipe, "cds%d = %s\n", i, dcop[i][cds]);

        fputs("VCTRL = 200*1e-3\n", pipe);
        fputs("Id = 1e-3\n", pipe);
        fputs("R = 300\n", pipe);
        fprintf(pipe, "Kp%d = gmp%d**2 / (4*Id)\n", i, i);
        fputs("omg(x) = 2 * pi * x\n", pipe);

        fprintf(pipe, "va%d(x) = 20*log10( 4*Kp%d*gmn%d*VCTRL/gmp%d )\n", i, i, i, i);
        fprintf(pipe, "vb%d(x) = 20*log10( sqrt( R**2 + (omg(x)*L%d)**2 ) )\n", i, i);
        fprintf(pipe, "vc%d(x) = 20*log10( sqrt( ( 1-2*(omg(x)**2)*L%d*(cds%d+cdg%d) )**2 + ( 2*R*(omg(x))*(cds%d+cdg%d) )**2 ))\n", i, i, i, i, i, i);
        fprintf(pipe, "vd%d(x) = 20*log10( sqrt( 1 + ( omg(x)*(cds%d+cgs%d)/gmp%d )**2 ) )\n", i, i, i, i);
        fprintf(pipe, "vout%d(x) = va%d(x)+vb%d(x)-vc%d(x)-vd%d(x)\n", i, i, i, i, i);

        if(i == 0)
        {
            fprintf(pipe, "  plot vout%d(x) black dt 4 title \"theoretical\"\n", i, dcop[i][L]);
        }
        else
        {
            fprintf(pipe, "replot vout%d(x) black dt 4 notitle\n", i, dcop[i][L]);
        }

    }

    fputs("set datafile separator \",\"\n", pipe);
    fputs("input = \"..\\\\data\\\\inductor_ac.vcsv\"\n", pipe);
    for(int i = 0; i < COLUMN; i++)
    {
        if(i == 0)
        {
        fprintf(pipe, "replot input skip 6 using %d : %d black with lines title \"simulation\"\n", 2 * i + 1, 2 * i + 2);
        }
        else
        {
        fprintf(pipe, "replot input skip 6 using %d : %d black with lines notitle\n", 2 * i + 1, 2 * i + 2);
        }
    }

    pclose(pipe);

    return 0;
}