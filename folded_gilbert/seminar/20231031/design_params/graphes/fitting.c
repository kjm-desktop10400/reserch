#include<stdio.h>
#include<stdlib.h>

int main(void)
{
    //open pipe
    FILE* pipe;
    pipe = popen("gnuplot", "w");
    if(pipe == NULL)
    {
        printf("couldnt open pipe");
    }
    else
    {
        printf("pipe opend");
    }

    
    //set input file
    fputs("input = \"data\\\\test.data\"", pipe);

    //set fitting function
    fputs("f(x) = A * x + B", pipe);
    fputs("A = 1", pipe);
    fputs("B = 1", pipe);

    int i = 1;

    //fitting
    fprintf(pipe, "fit f(x) input skip 0 using %d : %d via A, B", i, i + 1);

    //save fitlog
    fprintf(pipe, "save fit sprintf(\"data\\\\fitlog\\\\fitlog%d\",)", i);

    i++;

    //fitting
    fprintf(pipe, "fit f(x) input skip 0 using %d : %d via A, B", i, i + 1);

    //save fitlog
    fprintf(pipe, "save fit sprintf(\"data\\\\fitlog\\\\fitlog%d\",)", i);


    //close pipe
    fputs("e", pipe);
    pclose(pipe);

    return 0;
}