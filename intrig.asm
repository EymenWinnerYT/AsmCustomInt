;Assembly custom interrupt triggerer
;Created by EymenWinnerYT on 2 November 2024
;Compile: nasm -f bin intrig.asm -o intrig.com

bits 16
org 100h

int 31h ;Trigger our interupt

mov ax,4c00h
int 21h