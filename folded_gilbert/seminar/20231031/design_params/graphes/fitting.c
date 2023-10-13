#include<stdio.h>
#include<stdlib.h>

int main(void)
{

    FILE* pipe;
    pipe = popen("gnuplot -persist", "w");

    fprintf(pipe, "plot sin(x)\n");

    pclose(pipe);

    return 0;
}