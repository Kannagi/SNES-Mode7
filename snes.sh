#!/bin/sh

echo '[objects]' > temp
echo main.obj >> temp

/home/kannagi/Documents/SDK/SNES/bin/wla-65816 -o main.asm main.obj
/home/kannagi/Documents/SDK/SNES/bin/wlalink -vr temp main.smc

rm main.obj
rm temp