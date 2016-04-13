#include <stdlib.h>
#include <stdio.h>
#include <math.h>


int main(int argc, char** argv)
{
    int i;

    FILE *file;
    file = fopen("main.smc","rb+");

    if(file == NULL) return 0;

    fseek(file,0x8000*4,SEEK_SET);

    float zoom = 0x340;
    float sub;
    int byte[0x200];
    float div = zoom*0.024; //0.024 = angle
    int ozoom;
    float pr,tzoom = zoom;

    for(i = 0; i < 0x80;i++) //0x80 (128 lines)
    {
        sub = zoom/div;

        pr = ((float)zoom/tzoom);

        byte[i] = zoom;

        ozoom = zoom;
        fputc(ozoom&0xFF,file);
        fputc((ozoom>>8)&0xFF,file);
        //printf("$%x %f \n",ozoom,pr);

        zoom -= (sub  *pr);
    }

    

    fclose(file);

    file = fopen("m7.bin","wb");
    for(i = 0; i < 0x100;i++)
    {
        ozoom = byte[i];
        fputc(ozoom&0xFF,file);
        fputc((ozoom>>8)&0xFF,file);
    }

    fclose(file);

    return 0;
}
