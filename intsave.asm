;Assembly custom interrupt maker
;Created by EymenWinnerYT on 2 November 2024
;Compile: nasm -f bin intsave.asm -o intsave.com

bits 16 ;16 bit rel mode
org 100h ;100th memory adress

mov ax,0x3569 ;DOS read interrupt cevtor table function
int 21h
mov [old_int_off],bx ;Move old table ofset to old_int_off variable
mov bx,es
mov [old_int_seg],bx ;Move old table segment to old_int_seg variable

mov ax,cs
mov ds,ax
mov ah,0x25 ;DOS set interrupt function
mov al,0x31 ;Number of out interrupt (31)
mov dx,int_prog	;Program of our interrupt
int 21h ;Hook the interrupt using dos interrupt

;Clear screen
mov ah,06h ;BIOS clear screen function
mov al,00h
mov bh,07h
mov ch,0
mov cl,0
mov dh,24d
mov dl,79h
int 10h

mov ah,02h
mov bh,00h
mov dh,0
mov dl,0
int 10h

;Print "INT 31h hooked"
mov ah,09h ;DOS print text function
mov dx,successMsg
int 21h

;Uncomment lines below if you wanna restore old interrupt vector table back

;mov ax, [old_int_seg]
;mov ds, ax
;mov dx, [old_int_off]
;mov ax, 0x2569
;int 21h

;Terminate program
mov ax, 4c00h
int 21h

;Our interrupt program
;Our interrupt fill scrren with green color and print text :-)
int_prog:
	pusha ;Store data of all registers in memory
	
	;Chance to grahpics mode (320x200 256 colors)
	mov ax,13h
	int 10h
	
	;Fill entire screen with color
	mov ax,0xa000
	mov es,ax
	xor di,di
	
	mov al,10 ;Lime color, you can change it with your own (make sure color number is bettween 0 and 255)
	
	;How many pixels
	mov cx,64000
	rep stosb ;Repeat STOSB instruction for 64000 times (STOSB: http://yassinebridi.github.io/asm-docs/8086_instruction_set.html#STOSB)
	
	;Print text
	mov ah,09h
	mov dx,triggerMsg
	int 21h
	
	;Read key
	mov ah,00h
	int 16h
	
	;Chance to text mode again
	mov ax,3
	int 10
	
	popa ;Restore data of all registers in memory
	iret ;Return from interrupt program

;DW stand for define word
old_int_off dw 0
old_int_seg dw 0

successMsg db "INT 31h hooked$"
triggerMsg db "INT 31h triggered",13,10,"Press any key to exit$"
