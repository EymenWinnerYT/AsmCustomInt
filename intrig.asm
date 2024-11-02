;Assembly custom interrupt triggerer
;Created by EymenWinnerYT on 2 November 2024
;Compile: nasm -f bin intrig.asm -o intrig.com

bits 16 ;16 bit rel mode
org 100h ;100th memory adress

int 31h ;Trigger our interupt

;Quit program
mov ax,4c00h
int 21h
