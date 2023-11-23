#include<stdio.h>
#include<stdlib.h>

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
        VCTRL,
        gmn,
        gmp,
        gds,
        cgs,
        cdg,
        cds
    };

    char buf;
    char dcop[10][7][100];
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


    for(int i = 0; i < 10; i++)
    {
        for(int j = 0; j < 7; j++)
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
    fputs("set key top right spacing 2.5 offset 0,-1\n", pipe);
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
    fputs("set xrange [1e6 : 1e12]\n", pipe);
    fputs("set yrange [-40 : 5]\n", pipe);

    //凡例の設定
    fputs("set label 1  center at graph 0.2  , 0.47 \"V_{CTRL} = 20  mV\" font \", 20\" \n", pipe);
    fputs("set label 2  center at graph 0.2  , 0.61 \"           40  mV\" font \", 20\" \n", pipe);
    fputs("set label 3  center at graph 0.2  , 0.69 \"           60  mV\" font \", 20\" \n", pipe);
    fputs("set label 4  center at graph 0.2  , 0.75 \"           80  mV\" font \", 20\" \n", pipe);
    fputs("set label 5  center at graph 0.2  , 0.99 \"                 \" font \", 20\" \n", pipe);
    fputs("set label 6  center at graph 0.2  , 0.99 \"                 \" font \", 20\" \n", pipe);
    fputs("set label 7  center at graph 0.2  , 0.99 \"                 \" font \", 20\" \n", pipe);
    fputs("set label 8  center at graph 0.2  , 0.99 \"                 \" font \", 20\" \n", pipe);
    fputs("set label 9  center at graph 0.2  , 0.99 \"                 \" font \", 20\" \n", pipe);
    fputs("set label 10 center at graph 0.43 , 0.97 \"           200 mV\" font \", 20\" \n", pipe);

    for(int i = 0; i < 10; i++)
    {

        fprintf(pipe, "VCTRL%d = %s*1e-3\n", i, dcop[i][VCTRL]);
        fprintf(pipe, "gmn%d = %s\n", i, dcop[i][gmn]);
        fprintf(pipe, "gmp%d = %s\n", i, dcop[i][gmp]);
        fprintf(pipe, "gds%d = %s\n", i, dcop[i][gds]);
        fprintf(pipe, "cgs%d = %s\n", i, dcop[i][cgs]);
        fprintf(pipe, "cdg%d = %s\n", i, dcop[i][cdg]);
        fprintf(pipe, "cds%d = %s\n", i, dcop[i][cds]);

        fputs("Id = 1e-3\n", pipe);
        fputs("R = 300\n", pipe);
        fprintf(pipe, "Kp%d = gmp%d**2 / (4*Id)\n", i, i);
        fputs("omg(x) = 2 * pi * x\n", pipe);

        fprintf(pipe, "vdc%d = 20*log10(4*Kp%d*R*gmn%d*VCTRL%d/gmp%d)\n", i, i, i, i, i);
        fprintf(pipe, "vaca%d(x) = 20*log10( sqrt( 1 + ( 2*R*omg(x)*(cds%d+cdg%d) )**2 ) )\n", i, i, i);
        fprintf(pipe, "vacb%d(x) = 20*log10( sqrt( 1 + ( omg(x)*(cds%d+cgs%d)/gmp%d )**2 ) ) \n", i, i, i, i);
        fprintf(pipe, "vout%d(x) = vdc%d - vaca%d(x) - vacb%d(x)\n", i, i, i, i);

        if(i == 0)
        {
            fprintf(pipe, "plot vout%d(x) black with lines notitle\n", i);
        }
        else
        {
            fprintf(pipe, "replot vout%d(x) black with lines notitle\n", i);
        }

    }

    pclose(pipe);

    return 0;
}