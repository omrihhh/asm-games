IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
color_test db "Test!!!$"

grid_size equ 2
step_size equ 4
win_height equ 100 ; 200 / grid_size
win_width equ 160  ; 320 / grid_size
win_top_middle equ 160 ; 320 / 2

delay_time equ 1

block db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db '$'
;     y= *x /  +
line1 db 1,   4,  0
line2 db 1,   2,  0
cloud_ratio dw 2

sprite_offset dw 0
stretch_x1 dw 0
stretch_x2 dw 0
stretch_y1 dw 0
stretch_y2 dw 0
pos_x dw 0
pos_y dw 0

character db 't', 't', 't', 't', 't', 't', 't', 0fh, 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 0fh, 0fh, 0fh, 0,   0,   0,   0,   0fh, 0fh, 0fh, 't', 't', 't', 'n'
		  db 't', 't', 0fh, 0,   0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0fh, 't', 't', 'n'
		  db 't', 0fh, 0,   0,   0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0fh, 't', 'n'
		  db 0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0fh, 0,   0,   0,   0,   0fh, 'n'
		  db 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 'n'
		  db 't', 't', 't', 't', 't', 0fh, 0,   0fh, 0fh, 0,   0fh, 't', 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 't', 0fh, 0fh, 0,   0fh, 0fh, 0,   0fh, 0fh, 't', 't', 't', 't', 'n'
		  db 't', 't', 't', 0fh, 0,   0fh, 0,   0fh, 0fh, 0,   0fh, 0,   0fh, 't', 't', 't', 'n'
		  db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		  db '$'

cloud 	db 't', 't', 't', 't', 't', 't', 't', 0fh, 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 0fh, 0fh,   0fh,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 0fh, 0fh,   0fh,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 0fh, 0fh,   0fh,   0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh,   0fh,   0fh, 't', 't', 'n'
		db 't', 0fh, 0fh,   0fh,   0fh,   0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh,   0fh,   0fh,   0fh, 't', 'n'
		db 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 'n'
		db 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh,   0fh,   0fh,   0fh,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh,   0fh, 0fh, 0fh,   0fh, 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 0fh, 0fh, 0fh,   0fh, 0fh, 0fh,   0fh, 0fh, 't', 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh,   0fh, 0fh,   0fh, 0fh, 0fh,   0fh, 0fh,   0fh, 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db '$'

cloud1	db 't', 't', 't', 't', 0fh, 't', 0fh, 't', 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 'n'
		db 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 'n'
		db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 0fh, 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh, 't', 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		db, '$'

; --------------------------
CODESEG
; --------------------------

macro mult p1, p2
	push ax
	push dx

	mov ax, p2
	mul p1
	mov p1, ax
	pop dx
	pop ax
endm

macro divi p1, p2
	push ax
	push dx

	xor dx, dx
	mov ax, p1
	div p2
	mov p1, ax

	pop dx
	pop ax
endm

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
	mov bh,3h
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
	push bx
	push ax
	

	push cx

	mov cx, win_width  ; win_width = 320 / grid_size
	mov bx, win_height ; win_height = 200 / grid_size

	mult cx, grid_size
	mult bx, grid_size ; bx = 200
	mov ax, cx ; ax = 320
	
	pop cx

	cmp cx, ax
	jg end_draw_pixel

	cmp dx, bx
	jg end_draw_pixel

	cmp cx, 0
	jl end_draw_pixel

	cmp dx, 0
	jl end_draw_pixel

	pop ax
	push ax

	mov ah,0ch
	int 10h

	end_draw_pixel:
	
	pop ax
	pop bx
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

proc GetCollisions ; Get object in bp (mov bp, offset object)
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

proc DrawCharacter ; draw a character, input: offset saved in bx, top left pixel position in (cx, dx).
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
		jne not_new_line
		  inc dx
		  pop cx
		  push cx
		  inc bx
		  jmp draw_line_loop

		not_new_line:

		cmp al, 't' ; dont draw pixel ('t' = transparent)
		jne not_transparent
		  inc bx
		  inc cx
		  jmp draw_line_loop

		
		not_transparent:
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

	mov dx, cx


	cmp dx, win_top_middle
	jge no_point_on_line_flip
	
		mov ax, win_top_middle
		sub ax, dx
		mov dx, ax

		mov al, [byte ptr bx]
		xor ah, ah
		mul dx ; ax = ax *dx
		inc bx
		xor dx, dx
		push cx
		mov cl, [byte ptr bx]
		xor ch, ch
		div cx
		pop cx
		mov dx, ax
		inc bx
		push cx
		mov cl, [byte ptr bx]
		xor ch, ch
		add dx, cx
		pop cx

		pop bx
		pop ax
		pop cx
		ret
	
	no_point_on_line_flip:
		sub dx, win_top_middle

		mov al, [byte ptr bx]
		xor ah, ah
		mul dx ; ax = ax *dx
		inc bx
		xor dx, dx
		push cx
		mov cl, [byte ptr bx]
		xor ch, ch
		div cx
		pop cx
		mov dx, ax
		inc bx

		push cx
		mov cl, [byte ptr bx]
		xor ch, ch
		add dx, cx
		pop cx


		pop bx
		pop ax
		pop cx
		ret
endp

proc GetOtherX ; get x at cx and return y at dx
	push dx
	push ax
	push bx

	cmp cx, win_top_middle
	jge no_other_x_flip

		mov ax, win_top_middle
		sub ax, cx
		mov cx, ax

		mov ax, 4
		add ax, [cloud_ratio]
		add ax, [cloud_ratio]
		mul cx

		mov bx, 4
		add bx, [cloud_ratio]
		xor dx, dx
		div bx
		mov cx, ax

		mov ax, win_top_middle
		sub ax, cx
		mov cx, ax

		pop bx
		pop ax
		pop dx
		
		ret
	no_other_x_flip:

		sub cx, win_top_middle

		mov ax, 4
		add ax, [cloud_ratio]
		add ax, [cloud_ratio]
		mul cx

		mov bx, 4
		add bx, [cloud_ratio]
		xor dx, dx
		div bx
		mov cx, ax

		pop bx
		pop ax
		pop dx

		add cx, win_top_middle
		
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

		cmp cx, win_top_middle
		je end_graph_loop

		mov dx, cx
		mov ax, [bx]
		mul dx ; ax = ax *dx
		inc bx
		push cx
		mov cl, [byte ptr bx]
		xor ch, ch
		div cx
		pop cx
		mov dl, al
		xor dh, dh
		inc bx
		push cx
		mov cl, [bx]
		xor ch, ch
		add dx, cx
		pop cx
		add cx, win_top_middle
		mov al, 0fh

		call DrawPixel

		sub cx, win_top_middle

		push cx
		push bx
		mov bx, win_top_middle
		sub bx, cx ; bx = win_width-cx
		mov cx, bx ; cx = win_width-cx
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
 ; stretch_x1>stretch_x2 and stretch_y1>stretch_y2 and (cx, dx) position
proc DrawStrechedCloud; bx is counter (mov bx, offset cloud), top left corner (cx, dx)
	push dx
	push bx
	push ax
	push cx

	; stretch_x2 = cx
	; stretch_y2 = dx

	; w:16, h:8
	
	draw_cloud_line_loop:

		mov al, [bx]

		cmp al, "$"
		jne not_end_of_cloud_line
			jmp end_cloud_line_loop

		not_end_of_cloud_line:

		cmp al, 'n'
		jne not_new_cloud_line
			inc dx
			pop cx
			push cx
			inc bx
			jmp draw_cloud_line_loop
		
		not_new_cloud_line:

		mov al, [bx]
		
		cmp al, 't' ; dont draw pixel ('t' = transparent)
		jne cloud_not_transparent
		  inc bx
		  inc cx
		  jmp draw_cloud_line_loop

		
		cloud_not_transparent:
		push bx
		push cx
		push dx

		sub cx, [stretch_x2]
		sub dx, [stretch_y2]

		mov bx, [stretch_x1]
		sub bx, [stretch_x2]
		mult cx, bx ; cx = dx * new_width
		push cx
		mov cx, dx
		mov bx, [stretch_y1]
		sub bx, [stretch_y2]
		mult cx, bx
		mov dx, cx ; dx = dx * new_height
		pop cx

		push cx
		mov bp, [sprite_offset]
		call GetWidth
		mov bx, cx
		pop cx
		divi cx, bx ; cx = cx * new_width / original_width
		push cx
		mov bp, [sprite_offset]
		call GetHeight
		mov bx, cx
		mov cx, dx
		divi cx, bx
		mov dx, cx ; dx = dx * new_height / original_height
		pop cx

		add cx, [stretch_x2]
		add dx, [stretch_y2]

		
		push bx
		push cx
		mov bx, grid_size
		mov cx, dx
		divi cx, bx
		mov dx, cx
		pop cx
		divi cx, bx
		pop bx

		call DrawTile


		

		pop dx
		pop cx
		pop bx
		;call DrawTile
		
		inc cx
		inc bx
		
		jmp draw_cloud_line_loop
		
	end_cloud_line_loop:
		pop cx
		pop ax
		pop bx
		pop dx
		ret
endp

proc DrawSpriteOnLine
	push dx
	push bx
	push ax
	push cx
	
	; multiply x by grid size
	push dx
	push ax
	mov ax, grid_size
	xor dx, dx
	mul cx
	mov cx, ax
	pop ax
	pop dx

	mov bx, offset line2
	call GetPointOnLine

	cmp cx, win_top_middle
	jg left_side_of_screen_1
		mov [stretch_x1], cx
		jmp continue_1
	left_side_of_screen_1:
		mov [stretch_x2], cx
	continue_1:

	mov [stretch_y1], dx

	mov al, 5
	;call DrawPixel

	push cx ;*
	push dx ;**

	call GetOtherX
	mov bx, offset line1
	call GetPointOnLine

	cmp cx, win_top_middle
	jg left_side_of_screen_2
		mov [stretch_x2], cx
		jmp continue_2
	left_side_of_screen_2:
		mov [stretch_x1], cx
	continue_2:

	mov [stretch_y2], dx

	;call DrawPixel
	
	; set cx, dx to be lower x and lower y (top left corner of the rectangle).
	cmp cx, win_top_middle
	jl use_other_x_as_position
		pop cx
		push cx

		mult cx, grid_size
		add cx, win_top_middle

	use_other_x_as_position:

	; push bx
	; mov bx, grid_size
	; divi cx, bx ; cx = cx / grid_size
	; push cx
	; mov cx, dx
	; divi cx, bx ; cx = dx / grid_size
	; mov dx, cx ; dx = dx / grid_size
	; pop cx
	; pop bx

	mov bx, [sprite_offset]
	mov bp, [sprite_offset]

	push cx
	push dx
	push bx
	call GetWidth
	mov dx, cx
	call GetHeight
	mov bx, dx

	divi bx, cx ; bx = width / height
	mov [cloud_ratio], bx
	pop bx
	pop dx
	pop cx

	call DrawStrechedCloud

	;call DrawStrechedCloud; [bp+2], [bp], cx, dx
	; pop bx

	;mov bx, offset cloud
	;call DrawCharacter

	pop dx
	pop cx

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
		;call DrawGraph

		mov bx, offset line2
		;call DrawGraph

		mov bx, offset line2
		
		push cx
		mov [sprite_offset], offset cloud
		mov cx, [offset pos_x]
		call DrawSpriteOnLine
		pop cx

		; mov cx, 40
		; call DrawCloud
		; pop cx

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