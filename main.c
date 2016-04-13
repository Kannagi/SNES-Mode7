#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>


int main(int argc, char** argv)
{
    int i;

    FILE *fichier;
    fichier = fopen("main.smc","rb+");

    if(fichier == NULL) return 0;

    fseek(fichier,0x8000*4,SEEK_SET);

    float zoom = 0x340;
    float sub;
    int octet[0x200];
    float div = zoom*0.024; //0.024 = angle
    int ozoom;
    float pr,tzoom = zoom;

    for(i = 0; i < 0x80;i++) //0x80 (128 lines)
    {
        sub = zoom/div;

        pr = ((float)zoom/tzoom);

        octet[i] = zoom;

        ozoom = zoom;
        fputc(ozoom&0xFF,fichier);
        fputc((ozoom>>8)&0xFF,fichier);
        printf("$%x %f \n",ozoom,pr);

        zoom -= (sub  *pr);
    }

    

    fclose(fichier);

    fichier = fopen("m7.bin","wb");
    for(i = 0; i < 0x100;i++)
    {
        ozoom = octet[i];
        fputc(ozoom&0xFF,fichier);
        fputc((ozoom>>8)&0xFF,fichier);
    }

    fclose(fichier);


    

    return 0;
}
