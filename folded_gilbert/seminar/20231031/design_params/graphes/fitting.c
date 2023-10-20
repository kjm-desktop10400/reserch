#include<stdio.h>
#include<stdlib.h>

int main(void)
{
    //scan number of colum
    int data = 0;
    char flag = 0;
    char buf = 2;
    FILE* data_file = fopen("data\\gdp_L.vcsv", "r");
    if(data_file == NULL)
    {
        puts("data file couldnt opend");
        return 0;
    }
    else
    {
        puts("opened data file");
    }
    for(int i = 1; i < 2; i++)
    {//最初の二行を読み飛ばす
        while(1)
        {
            if(fgetc(data_file) == '\n')
            {
                break;
            }
            else
            {
                continue;
            }
        }
    }
    while(1)
    {
        switch(buf = fgetc(data_file))
        {
            case ';' :
                data++;
                putc(buf, stdout);
                break;
            case '\n' :
                flag = 1;
                putc(buf, stdout);
                break;
            default :
                putc(buf, stdout);
                continue;
        }
        if(flag)
        {
            break;
        }
    }
    fclose(data_file);
    printf("data number : %d\n", data + 1);

    //open pipe
    FILE* pipe;
    pipe = popen("gnuplot", "w");
    
    //set separator type
    fprintf(pipe, "set datafile separator \",\"\n");
    
    //set input file
    fprintf(pipe, "input = \"data\\\\gdp_L.vcsv\"\n");

    //set fitting function
    fprintf(pipe, "f(x) = A * x + B\n");
    fprintf(pipe, "A = 1\n");
    fprintf(pipe, "B = 1\n");

    //intrinsic fitting
    for(int i = 0; i <= data; i++){
        //fitting
        fprintf(pipe, "fit [2 : ] f(x) input skip 4 using %d : %d via A, B\n", 2 * i + 1, 2 * i + 2);

        //save fitlog
        fprintf(pipe, "save fit sprintf(\"data\\\\fitlog\\\\%d.fitlog\")\n", i + 1);
    }

    //close pipe
    fputs("e", pipe);
    pclose(pipe);

    return 0;
}