IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
color_test db "Test!!!$"

grid_size equ 2
step_size equ 5
win_height equ 100 ; 200 / grid_size
win_width equ 160  ; 320 / grid_size

delay_time equ 1

block db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db '$'
;     y= *x /  +
line1 db 1,   4,  0
line2 db 1,   2,  0
cloud_ratio equ 2


pos_x dw 0
pos_y dw 0

; character   db 0,     0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0fh,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
; 			db 0,     0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   'n'
; 			db 0,     0,   0,   0,   0fh, 0,   0,   0,   0,   0,   0fh, 0,   0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0,   0,   0fh, 0,   0,   0,   0,   0,   0fh, 0,   0,   0,   0,   'n'
; 			db 0,     0,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0,   0,   0fh, 0,   0fh, 0,   0,   0fh, 0,   0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0,   0fh, 0,   0fh, 0,   0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0fh, 0,   0,   0fh, 0,   0,   0,   0fh, 0,   0,   0fh, 0,   0,   'n'
; 			db 0,     0,   0,   0fh, 0fh, 0,   0,   0,   0,   0,   0fh, 0fh, 0,   0,   0,   'n'
; 		db '$'

character db 0,   0,   0,   0,     0,   0,   0,   0fh, 0fh, 0,   0,   0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0,   0,   0fh, 0,   0,   0fh, 0,   0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0,   0,   0fh, 0,   0,   0fh, 0,   0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0fh,   0fh, 0fh, 0,   0,   0,   0,   0fh, 0fh, 0fh, 0,   0,   0,   'n'
		  db 0,   0,   0fh, 0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0fh, 0,   0,   'n'
		  db 0,   0fh, 0,   0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0fh, 0,   'n'
		  db 0fh, 0,   0,   0,     0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0fh, 'n'
		  db 0fh, 0fh, 0fh, 0fh,   0fh, 0fh, 0,   0,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 'n'
		  db 0,   0,   0,   0,     0,   0fh, 0,   0fh, 0fh, 0,   0fh, 0,   0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0,     0fh, 0fh, 0,   0fh, 0fh, 0,   0fh, 0fh, 0,   0,   0,   0,   'n'
		  db 0,   0,   0,   0fh,   0,   0fh, 0,   0fh, 0fh, 0,   0fh, 0,   0fh, 0,   0,   0,   'n'
		  db 0,   0,   0,   0fh,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   'n'
		  db '$'

; --------------------------
CODESEG
; --------------------------

proc Terminate
	jmp exit
endp

proc GetLength  ; Get length of variable, where its offset is on bp. (mov bp, offset var)
	push bx
	mov bx, bp
	xor cx, cx
	length_loop:
		cmp [word ptr bx], "$"
		je end_length_loop
		
		inc bx
		inc cx
		jmp length_loop

	end_length_loop:
		pop bx
		ret
endp

proc GetHeight ; Get height of character, where its offset is on bp. (mov bp, offset var)
	push bx
	mov bx, bp
	xor cx, cx
	height_loop:
		cmp [byte ptr bx], "n"
		jne skip_height
			inc cx

		skip_height:

		cmp [byte ptr bx], "$"
		je end_height_loop
		
		inc bx
		
		jmp height_loop

	end_height_loop:
		pop bx
		ret
endp

proc GetWidth ; Get width of character, where its offset is on bp. (mov bp, offset var)
	push bx
	mov bx, bp
	xor cx, cx
	width_loop:
		cmp [byte ptr bx], 'n'
		je end_width_loop
		
		inc bx
		inc cx
		
		jmp width_loop

	end_width_loop:
		pop bx
		ret
endp

proc PrintAl ; Print to screen the value that is in al.
	push ax
	push dx

	mov cx, 100
	mov ah, 02h
	mov dl, al
	int 21h

	pop dx
	pop ax
	ret
endp

proc WaitKey ; Wait for key to be pressed (value is saved in al).
	mov ah, 07h
	int 21h
	ret
endp

proc InputEcho ; Get input, save it in al, and print it.
	call WaitKey
	call PrintAl
	ret
endp

proc GetInput ; Get game input (arrows to move, esc to quit).
    mov ah, 1
    int 16h
    jz next_k
    ; get value:
    mov ah, 0
    int 16h

    ; parse the input:
    cmp ah, 1 ; esc
		je esc_pressed
	
    cmp ah, 1bh ; esc
		je esc_pressed
	
    cmp ah, 48h ; up arrow
		je up_pressed
	
	cmp ah, 50h ; down arrow
		je down_pressed
	
    cmp ah, 4bh ; left arrow
		je left_pressed
	
    cmp ah, 4dh ; right arrow
		je right_pressed
	
    ret
    ; load the command codes:
	next_k:
        ret
    esc_pressed:
        call Terminate
        ret
    up_pressed:
		cmp [word ptr offset pos_y], step_size
		jge move_up
			mov [word ptr offset pos_y], 0
			ret

		move_up:
		sub [word ptr offset pos_y], step_size
        ret
    down_pressed:
		push bx
		push cx
		push bp
		
		mov bx, win_height
		mov bp, offset character
		call GetHeight
		sub bx, cx
		sub bx, step_size
		cmp [word ptr offset pos_y], bx

		pop bp
		pop cx
		pop bx
		jle move_down
			push bx
			push cx
			push bp

			mov bx, win_height
			mov bp, offset character
			call GetHeight
			sub bx, cx

			pop bp
			pop cx
			mov [word ptr offset pos_y], bx
			pop bx
			ret

		move_down:
		add [word ptr offset pos_y], step_size
        ret
    left_pressed:
		cmp [word ptr offset pos_x], step_size
		jge move_left
			mov [word ptr offset pos_x], 0
			ret

		move_left:
		sub [word ptr offset pos_x], step_size
        ret
    right_pressed:
		push bx
		push cx
		push bp
		
		mov bx, win_width
		mov bp, offset character
		call GetWidth
		sub bx, cx
		sub bx, step_size
		cmp [word ptr offset pos_x], bx

		pop bp
		pop cx
		pop bx
		jle move_right
			push bx
			push cx
			push bp

			mov bx, win_width
			mov bp, offset character
			call GetWidth
			sub bx, cx

			pop bp
			pop cx
			mov [word ptr offset pos_x], bx
			pop bx
			ret
		
		move_right:
		add [word ptr offset pos_x], step_size
        ret
    
endp

proc ClearAndDelay ; Clear screen and delay
	call Delay
	call Clear
	
	ret
endp

proc Delay ; Sleep.
	push cx
	push dx
	push ax
	
	mov al, 0
	mov ah, 86h
	mov cx, delay_time
	mov dx, 1000
	int 15h

	pop ax
	pop dx
	pop cx
	
	ret
endp

proc Clear ; Clear screen.
	push ax
	push bx
	push cx
	push dx

	mov ax,0600h
	mov bh,0h
	mov cx,0h
	mov dx,184fh
	int 10h

	pop dx
	pop cx
	pop bx
	pop ax

	ret
endp

proc DrawPixel ; draw a single pixel at (cx, dx) and with color al.
	push ax

	mov ah,0ch
	int 10h

	pop ax
	ret
endp


proc ColTest ; Just a test.
	push bx
	push cx
	push ax

	mov bl, 0
	mov bh, 1
	mov cx, 0
	
	anim:
		call ClearAndDelay
		
		cmp bh, 10
		je end_anim
		
		call DrawCharacter
		add cx, 10
		inc cx
		inc bh
		
		jmp anim
		
	end_anim:
		pop ax
		pop cx
		pop bx
		
		ret
endp

proc CollisionDetection ; Get object in bp (mov bp, offset object)
	push ax
	push bx
	push cx
	push dx



	pop dx
	pop cx
	pop bx
	pop ax
endp


proc AddCollision
	push ax
	push bx
	push cx
	push dx

	

	pop dx
	pop cx
	pop bx
	pop ax
endp


proc DrawTile ; Draw a tile (size is set by grid_size variable)
	push bx
	push cx
	push dx
	push ax

	xor ah, ah
	xor bx, bx

	; multiply both cx (x cord) and dx (y cord) by the grid size.
	push ax
	xor ax, ax

	push dx
	mov ax, grid_size
	mul cx
	mov cx, ax
	pop dx

	mov ax, grid_size
	mul dx
	mov dx, ax

	pop ax

	tile_y:
		xor ah, ah

		cmp bx, grid_size
		je end_tile_y

		tile_x:
			cmp ah, grid_size
			je end_tile_x

			; push ax
			; mov ah, 0dh
			; int 10h
			; cmp al, 0
			; je no_collision_detected
			; 	call AddCollision
			
			; no_collision_detected:
			; pop ax

			

			call DrawPixel

			inc cx
			inc ah

			jmp tile_x

		end_tile_x:
			sub cx, grid_size

			inc dx
			inc bx

			jmp tile_y

	end_tile_y:
		pop ax
		pop dx
		pop cx
		pop bx

		ret
endp

proc DrawCharacter ; draw a character, offset saved in bx, position in (cx, dx).
	push dx
	push bx
	push ax
	push cx

	;mov bx, offset character
	
	draw_line_loop:
		mov al, [bx]
		
		cmp al, '$'
		je end_line_loop
		
		cmp al, 'n'
		jne skip_new_line
		  inc dx
		  pop cx
		  push cx
		  inc bx
		  jmp draw_line_loop

		cmp al, 't'
		jne skip_new_line
		  inc dx
		  pop cx
		  push cx
		  inc bx
		  jmp draw_line_loop

		skip_new_line:
		;call DrawPixel
		call DrawTile
		
		inc cx
		inc bx
		
		jmp draw_line_loop
		
		
	end_line_loop:
		pop cx
		pop ax
		pop bx
		pop dx
		ret
endp
	
proc PrintText ; Print a variable to screen, offset saved in bp, dh - row, dl - column, bl - color.
	push ax
	push bx
	push cx

	mov ah, 02h
	mov bh, 0
	
	int 10h
	
	mov ah, 13H ; WRITE THE STRING
	mov al, 01H; ATTRIBUTE IN BL, movE CURSOR TO THAT POSITION
	mov bh, 0
	;mov bl, 5 ;GREEN
	call GetLength
	;mov cx, 7 ; LENGTH OF THE STRING
	int 10H
	
	pop cx
	pop bx
	pop ax

	ret
endp

proc PrintSingle ; Print 
	push ax
	push bx
	push cx

	mov ah, 0Ah
	mov bh, 0
	mov bl, 5
	mov cx, 1
	int 10h

	pop cx
	pop bx
	pop ax

	ret
endp

; win_height 200
; win_width 320

proc GetPointOnLine ; get x at cx and return y at dx
	push cx
	push ax
	push bx ; offset line

	sub cx, 160

	mov dx, cx
	mov ax, [bx]
	mul dx ; ax = ax *dx
	inc bx
	div [word ptr bx]
	mov dl, al
	xor dh, dh
	inc bx
	add dx, [bx]

	pop bx
	pop ax
	pop cx
	ret
endp

proc GetOtherX ; get x at cx and return y at dx
	push ax
	push bx ; offset line
	push cx

	mov dx, 4
	add dx, cloud_ratio
	add dx, cloud_ratio
	mov ax, cx
	mul dx

	pop cx
	push cx
	
	mov dx, 4
	add dx, cloud_ratio

	div dx
	xor ah, ah
	mov dx, ax

	pop cx
	pop bx
	pop ax
	
	ret
endp

proc DrawGraph
	push cx
	push dx
	push ax
	push bx ; offset line

	xor cx, cx

	graph_loop:
		pop bx
		push bx

		cmp cx, 160
		je end_graph_loop

		mov dx, cx
		mov ax, [bx]
		mul dx ; ax = ax *dx
		inc bx
		div [word ptr bx]
		mov dl, al
		xor dh, dh
		inc bx
		add dl, [bx]
		add cx, 160
		mov al, 0fh

		call DrawPixel

		sub cx, 160

		push cx
		push bx
		mov bx, 160
		sub bx, cx ; bx = 160-cx
		mov cx, bx ; cx = 160-cx
		pop bx

		mov al, 0fh
		call DrawPixel
		pop cx
		

		inc cx
		jmp graph_loop

	end_graph_loop:
		pop bx
		pop ax
		pop dx
		pop cx
		ret
endp

proc DrawCloud
	push dx
	push bx
	push ax
	push cx
	
	call GetPointOnLine
	mov al, 5

	call DrawPixel

	pop cx
	pop ax
	pop bx
	pop dx
	ret
endp

proc MainLoop ; Main loop of the game.
	mov cx, [offset pos_x]
	mov dx, [offset pos_y]
	
	main_loop:
		mov bx, offset character
		call DrawCharacter
		

		; Makes linear graph in format y=mx+b
		mov bx, offset line1
		call DrawGraph

		mov bx, offset line2
		call DrawGraph

		mov bx, offset line2
		
		push cx
		mov cx, 160
		call DrawCloud
		pop cx

		; push cx
		; push dx
		; mov cx, 0
		; mov dx, 0
		; mov bx, offset block
		; call DrawCharacter
		; pop dx
		; pop cx

		push ax
		call GetInput
		pop ax

		; mov dh, 8 ;row
		; mov dl, 8 ;column
		; mov bp, offset color_test ; string position
		; call PrintText
		xor cx, cx
		xor dx, dx

		mov cx, [offset pos_x]
		mov dx, [offset pos_y]

		call ClearAndDelay
		jmp main_loop

	end_main_loop:
		ret
endp

start:
	mov ax, @data
	mov ds, ax

	mov ax, 013h ; set vga mode
	int 16

	mov ax, 0a000h
	mov es, ax

	push ax
	push bx
	; change keyboard refresh rate to match delay between frames.
	mov ah, 03h 
	mov al, 05h
	mov bh, 00h
	mov bl, 08h
	int 16h

	pop bx
	pop ax
	
	call MainLoop

	
exit:
	mov ax, 3
	int 16
	mov ax, 4c00h
	int 21h
END start

; --------------------------