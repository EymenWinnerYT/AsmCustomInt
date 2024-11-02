bits 16
org 100h

mov ax,0x3569
int 21h
mov [old_int_off],bx
mov bx,es
mov [old_int_seg],bx

mov ax,cs
mov ds,ax
mov ah,0x25
mov al,0x31
mov dx,int_prog
int 21h

mov ah,06h
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

mov ah,09h
mov dx,successMsg
int 21h

;mov ax, [old_int_seg]
;mov ds, ax
;mov dx, [old_int_off]
;mov ax, 0x2569
;int 21h

mov ax, 4c00h
int 21h

int_prog:
	pusha
	
	mov ax,13h
	int 10h
	
	mov ax,0xa000
	mov es,ax
	xor di,di
	
	mov al,10
	
	mov cx,64000
	rep stosb
	
	mov ah,09h
	mov dx,triggerMsg
	int 21h
	
	mov ah,00h
	int 16h
	
	mov ax,3
	int 10
	
	popa
	iret
	
old_int_off dw 0
old_int_seg dw 0

successMsg db "INT 31h hooked$"
triggerMsg db "INT 31h triggered",13,10,"Press any key to exit$"