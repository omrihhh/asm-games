IDEAL
MODEL small
STACK 100h
DATASEG

ls dw 0
lp dw 0

CODESEG

macro alloc size
	push bx
	mov ah, 48h
	mov bx, size
	int 21h
	pop bx
endm

proc Get
	push bp
	push ax
	push bx

	mov cx, [lp]
	mov bx, [ls]
	inc bx
	cmp cx, 0
	je end_loop
	label1:
		mov bp, bx
		mov bx, [bp]
		inc bx

		loop label1
	end_loop:
	dec bx
	mov cx, [bx]

	pop bx
	pop ax
	pop bp
	ret
endp

; proc Append

; endp

start:
	mov ax, @data
	mov ds, ax

	alloc 1

	mov bp, ax
	mov [ls], bp	
	mov [word bp], 5
	inc bp
	mov [word bp], 174h

	alloc 1
	mov bp, ax
	mov [word bp], 7
	inc bp
	mov [word bp], 0

	mov [lp], 0
	call Get
exit:
	mov ax, 3
	int 16
	mov ax, 4c00h
	int 21h
END start
