#include<stdio.h>

FILE* fp;
FILE* fpout;
FILE* output;

int main(void){

    fp = popen("gnuplot -persist", "w");
    fpout = popen("gnuplot save fit \"-\"", "r");
    output = fopen("fited_valiables.dat", "w");

    char str[1000];

    fprintf(fp, "set datafile separator \",\"\n");
    fprintf(fp, "set dummuy vgs, arg\n");
    fprintf(fp, "fK = 1e-7\n");
    fprintf(fp, "fVth = 0.5\n");
    fprintf(fp, "I(vgs) = fK * (vgs - fVth)**2\n");

    for(int i = 1; i <= 9; i++){
        fprintf(fp, "fit I(vgs) \"current_source_estVth.vcsv\" skip 6 using 1 : %d via fK, fVth\n", i + 1);
        fgets(str, 1000, fpout);
        printf("%s\n", str);
    }


    fgetc(stdin);
    return 0;
}