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
                if(buf == ',' || buf == '\n')
                {
                    break;
                }
                if(buf == 'E')
                {
                    buf = 'e';
                }
                dcop[i][j][count] = buf;
                putc(dcop[i][j][count], stdout);
                count++;
            }
            dcop[i][j][count] = '\0';
            putc('\t', stdout);
            
        }

        fputs("\n", stdout);
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
    fputs("plot sin(x)\n", pipe);
    fputs("set logscale x\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set tics font \"Arial,30\"\n", pipe);
    fputs("set xlabel \"frequency [Hz]\" font \"Arial,30\" offset 0,-1\n", pipe);
    fputs("set ylabel \"magnitude [dB]\" font \"Arial,30\" offset -8,0\n", pipe);
    fputs("set key font\"Arial,25\"\n", pipe);
    fputs("set key bottom left spacing 2.5 offset 35,2\n", pipe);
    fputs("set terminal windows size 1000,700\n", pipe);
    fputs("set lmargin 20\n", pipe);
    fputs("set rmargin 20\n", pipe);
    fputs("set bmargin 6\n", pipe);
    fputs("set tmargin 2\n", pipe);
    fputs("set tics font \"Arial,25\"\n", pipe);
    fputs("set ytics\n", pipe);
    fputs("set mxtics 5\n", pipe);
    fputs("set mytics 5\n", pipe);
    fputs("set grid xtics mxtics ytics linewidth 2, linewidth 1, linewidth 1\n", pipe);
    fputs("set xrange [1e6 : 1e12]\n", pipe);

    for(int i = 0; i < 10; i++)
    {

        char buf[100];
        sprintf(buf, "VCTRL = %s*1e-3\n", dcop[i][VCTRL]); 
        
        fputs(buf,pipe);     fputs("1\n",stdout);

        sprintf("gmn = %s\n", dcop[i][gmn]);     
        fputs(buf, pipe);    fputs("2\n",stdout);
        sprintf(buf, "gmp = %s\n",dcop[i][gmp]);
        fputs(buf, pipe);     fputs("3\n",stdout);
        sprintf(buf, "gds = %s\n",dcop[i][gds]);
        fputs(buf, pipe);     fputs("4\n",stdout);
        sprintf(buf, "cgs = %s\n",dcop[i][cgs]);
        fputs(buf, pipe);     fputs("5\n",stdout);
        sprintf(buf, "cdg = %s\n",dcop[i][cdg]);
        fputs(buf, pipe);     fputs("6\n",stdout);
        sprintf(buf, "cds = %s\n",dcop[i][cds]);
        fputs(buf, pipe);     fputs("7\n",stdout);

        fputs("Id = 1e-3\n", pipe);
        fputs("R = 300\n", pipe);
        fputs("Kp = gmp**2 / (4*Id)\n", pipe);

        fputs("vout(x) = 20*log10( 4* Kp * R * gmn * VCTRL * x / (sqrt( (gmp - 4 * pi * R * (x**2) * (cds+cdg)(cds+gs) )**2 + ( 2 * pi * x * ( (cds+cgs) + R * gmp * (cds+cdg) ) )**2 )) )\n", pipe);

        if(i == 0)
        {
            fputs("plot vout(x) with lines\n", pipe);
        }
        else
        {
            fputs("replot vout(x) with lines\n", pipe);
        }

    }

    pclose(pipe);

    return 0;
}