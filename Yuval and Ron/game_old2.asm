IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------

grid_size equ 2
step_size equ 4
win_height equ 100 ; 200 / grid_size
win_width equ 160  ; 320 / grid_size
win_top_middle equ 160 ; 320 / 2

delay_time dw 1

drawing_tile_x_offset dw 0

block db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db 5, 5, 5, 5, 'n'
	  db '$'

line_xs     dw 0, 20, 40, 60, 80, 100, 120, 140
line_ys     dw 0, 0, 0, 0, 0, 0, 0, 0
line_types  dw 2, 2, 2, 2, 2, 2, 2, 2
random_nums dw 0, 0, 0, 0, 0, 0, 0, 0

temp_char db '0$'

pos_x dw 70
pos_y dw 85
speed dw 1
turn db 0

tick dw 0
last_tick_bullet dw 0
bullet_limit dw 2

past_enemies dw 0

score_text db "Score:$", 0
score dw 10
high_score dw 10

hp_text db "Hitpoints:$"
hp dw 3
had_collision_with_enemy dw 0

game_over db "Game Over!$"

drawing_main_character db 0
drawing_bullet db 0
in_cloud db 0

bonus_active_text db "Bonus Time:$"

bullet_mode dw 1
bonus_active db 0
bonus_pos dw 0, 0
bonus_mod dw 2
bonus_time_on_screen dw 100
bonus_timer dw 0
bullet_mode_timer dw 0
bullet_mode_max_time dw 180
collected_bonus dw 0

bonus 	db 't', 't', 0eh, 0eh, 0eh, 0eh, 't', 't', 'n'
		db 't', 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 't', 'n'
		db 0eh, 0eh, 0eh, 06h, 06h, 0eh, 0eh, 0eh, 'n'
		db 0eh, 0eh, 06h, 0eh, 0eh, 06h, 0eh, 0eh, 'n'
		db 0eh, 0eh, 06h, 0eh, 0eh, 06h, 0eh, 0eh, 'n'
		db 0eh, 0eh, 0eh, 06h, 06h, 0eh, 0eh, 0eh, 'n'
		db 't', 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 't', 'n'
		db 't', 't', 0eh, 0eh, 0eh, 0eh, 't', 't', 'n'
		db '$'

;      active x  y speed
bullets dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0
		dw 0, 0, 0, 0

current_bullet dw 0
current_shooted_bullet dw 0
total_bullets equ 256 ; bullets variable size in memory
maximum_bullets equ 32 ; maximum amount of bullets on screen

character 	db 't', 't', 't', 't', 't', 't', 't', 0fh, 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
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

char_left 	db 't', 't', 't', 't', 't', 't', 't', 0fh, 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 0fh, 0fh, 0fh, 0,   0,   0,   0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		  	db 't', 't', 0fh, 0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 't', 't', 'n'
		  	db 't', 0fh, 0,   0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0fh, 't', 'n'
		  	db 't', 0fh, 0,   0,   0,   0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 'n'
		  	db 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0fh, 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0fh, 0fh, 0,   0fh, 0fh, 0fh, 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		  	db '$'

char_right 	db 't', 't', 't', 't', 't', 't', 't', 0fh, 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 't', 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0fh, 0fh, 0fh, 't', 't', 't', 'n'
		  	db 't', 't', 0fh, 0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0fh, 't', 't', 'n'
		  	db 't', 0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   0fh, 't', 'n'
		  	db 0fh, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0fh, 0,   0,   0,   0fh, 't', 'n'
		  	db 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0,   0,   0,   0fh, 0fh, 0fh, 0fh, 0fh, 't', 'n'
		  	db 't', 't', 't', 't', 't', 0fh, 0,   0,   0fh, 0fh, 0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0,   0fh, 0fh, 0fh, 't', 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 0fh, 0,   0,   0,   0,   0fh, 0fh, 0fh, 0fh, 't', 't', 't', 't', 'n'
		  	db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 't', 'n'
		  	db '$'

enemy 	db 't', 't', 't', 1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   't', 't', 't', 'n'
		db 't', 't', 't', 1,   4,   1,   4,   1,   1,   4,   1,   4,   1,   't', 't', 't', 'n'
		db 't', 't', 't', 't', 1,   1,   4,   1,   1,   4,   1,   1,   't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 1,   4,   1,   1,   4,   1,   't', 't', 't', 't', 't', 'n'
		db 1,   1,   1,   1,   1,   1,   4,   4,   4,   4,   1,   1,   1,   1,   1,   1,   'n'
		db 1,   4,   4,   4,   4,   1,   4,   4,   4,   4,   1,   4,   4,   4,   4,   1,   'n'
		db 't', 1,   4,   4,   4,   1,   4,   4,   4,   4,   1,   4,   4,   4,   1,   't', 'n'
		db 't', 't', 1,   4,   4,   1,   4,   4,   4,   4,   1,   4,   4,   1,   't', 't', 'n'
		db 't', 't', 't', 1,   1,   1,   4,   4,   4,   4,   1,   1,   1,   't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 1,   4,   4,   4,   4,   1,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 1,   4,   4,   4,   4,   1,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 1,   4,   4,   4,   4,   1,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 1,   4,   4,   1,   't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 1,   4,   4,   1,   't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 't', 1,   1,   't', 't', 't', 't', 't', 't', 't', 'n'
		db '$'

cloud	db 't', 't', 't', 't', 0fh, 't', 0fh, 't', 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 'n'
		db 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 'n'
		db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 't', 't', 'n'
		db 't', 't', 't', 't', 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 't', 0fh, 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0fh, 0fh, 't', 0fh, 't', 't', 't', 't', 't', 't', 't', 'n'
		db '$'

explosion	db 't', 't', 't', 't', 04h, 't', 04h, 't', 04h, 04h, 04h, 04h, 't', 't', 't', 't', 'n'
			db 't', 't', 't', 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 't', 't', 't', 'n'
			db 't', 't', 04h, 04h, 04h, 04h, 04h, 04h, 06h, 06h, 06h, 04h, 04h, 04h, 04h, 't', 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 04h, 04h, 04h, 't', 'n'
			db 't', 't', 't', 04h, 04h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 04h, 04h, 'n'
			db 't', 't', 't', 04h, 04h, 06h, 0eh, 0eh, 0eh, 0eh, 0eh, 06h, 06h, 04h, 04h, 04h, 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 0eh, 0eh, 0eh, 0eh, 0eh, 06h, 06h, 04h, 04h, 't', 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 0eh, 0eh, 0eh, 0eh, 0eh, 06h, 06h, 04h, 04h, 04h, 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 0eh, 0eh, 0eh, 0eh, 0eh, 06h, 06h, 06h, 04h, 04h, 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 06h, 06h, 0eh, 0eh, 0eh, 06h, 06h, 06h, 04h, 04h, 'n'
			db 't', 't', 04h, 04h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 04h, 04h, 't', 'n'
			db 't', 't', 't', 04h, 04h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 04h, 04h, 't', 't', 'n'
			db 't', 't', 't', 04h, 04h, 04h, 04h, 04h, 06h, 06h, 04h, 04h, 04h, 04h, 't', 't', 'n'
			db 't', 't', 't', 't', 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 't', 't', 't', 'n'
			db 't', 't', 't', 't', 't', 04h, 04h, 't', 04h, 04h, 't', 't', 't', 't', 't', 't', 'n'
			db '$'

clear_exp	db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h, 'n'
			db '$'

bullet  db 0fh, 0fh, 'n'
        db 0fh, 0fh, 'n'
        db 0fh, 0fh, 'n'
        db 0fh, 0fh, 'n'
        db '$'

bullet2  db 0fh, 0fh, 't', 't', 't', 't', 't', 't', 0fh, 0fh, 'n'
         db 0fh, 0fh, 't', 't', 't', 't', 't', 't', 0fh, 0fh, 'n'
         db 0fh, 0fh, 't', 't', 't', 't', 't', 't', 0fh, 0fh, 'n'
         db 0fh, 0fh, 't', 't', 't', 't', 't', 't', 0fh, 0fh, 'n'
         db '$'

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
		cmp [byte bx], "$"
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

	cmp al, 20h ; space
	jne space_not_pressed
		push cx

		mov cx, [tick]
		sub cx, [last_tick_bullet]
		cmp cx, [bullet_limit]

		pop cx
		jge space_pressed
		
	space_not_pressed:
	
    cmp ah, 48h ; up arrow
		jne up_not_pressed
			jmp up_pressed
		up_not_pressed:
	
	cmp ah, 50h ; down arrow
		jne down_not_pressed
			jmp down_pressed
		down_not_pressed:
	
    cmp ah, 4bh ; left arrow
		jne left_not_pressed
			jmp left_pressed
		left_not_pressed:
	
    cmp ah, 4dh ; right arrow
		jne right_not_pressed
			jmp right_pressed
		right_not_pressed:
	
    ret
    ; load the command codes:
	next_k:
		mov [turn], 0
        ret
    esc_pressed:
        call Terminate
        ret
	space_pressed:
		push cx
		mov cx, [tick]
		mov [last_tick_bullet], cx
		pop cx
		mov [turn], 0
		push bx
		mov bx, [current_bullet]
		cmp bx, [maximum_bullets]
		jne can_add_more_bullets
			pop bx
			ret
		can_add_more_bullets:
		push cx
		push dx
		xor dx, dx
		mov cx, 8
		mult bx, cx ; bx = current_bullet * 8
		pop dx
		pop cx
		
		add bx, offset bullets

		push cx
		push dx

		mov dx, [pos_x]
		
		push dx
		mov cx, [bullet_mode]
		dec cx
		push bx
		mov bx, 6
		mult cx, bx
		pop bx
		pop dx

		sub [pos_x], cx

		mov cx, [bullet_mode]
		draw_bullets_loop:
			mov [word bx], 1 ; activate bullet
			
			call MakeBullet

			inc [current_bullet]
			add [pos_x], 12
			add bx, 8

			push bx
			mov bx, [current_bullet]
			cmp bx, [maximum_bullets]
			jne can_add_more_bullets2
				xor cx, cx
			can_add_more_bullets2:
			pop bx

			loop draw_bullets_loop
		
		mov [pos_x], dx
		pop dx
		pop cx

		pop bx
		ret
    up_pressed:
		mov [turn], 0
		cmp [word ptr offset pos_y], step_size
		jge move_up
			mov [word ptr offset pos_y], 0
			ret

		move_up:
		sub [word ptr offset pos_y], step_size
        ret
    down_pressed:
		mov [turn], 0
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
		mov [turn], 1
		cmp [word ptr offset pos_x], step_size
		jge move_left
			mov [word ptr offset pos_x], 0
			ret

		move_left:
		sub [word ptr offset pos_x], step_size
        ret
    right_pressed:
		mov [turn], 2
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
	mov bh, 03h
	call Clear
	
	ret
endp

proc Delay ; Sleep.
	push cx
	push dx
	push ax
	
	mov al, 0
	mov ah, 86h
	mov cx, [offset delay_time]
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
	;mov bh,3h
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

proc WaitKey2
	call WaitKey
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

proc GetLine ;input in cx (x cord), output: line index in bx
	push cx
	push dx

	xor dx, dx
	mov bx, 20
	divi cx, bx
	mov bx, cx
	
	pop dx
	pop cx
	ret
endp

proc BulletCollision
	push ax
	push bx
	push cx
	push dx

	mov bh, 03h
	call Clear
	mov bx, [current_shooted_bullet]
	mov [word bx], 0
	add bx, 2
	mov cx, [bx]
	add bx, 2
	mov dx, [bx]
	sub bx, 4
	push cx
	push dx
	sub cx, 8
	sub dx, 5
	mov bx, offset explosion
	call DrawCharacter
	pop dx
	pop cx

	call GetLine
	shl bx, 1
	add bx, offset line_ys
	mov [word bx], 0
	sub bx, offset line_ys
	add bx, offset line_types
	mov [word bx], 2

	inc [score]
	dec [current_bullet]

	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp

proc EnemyCollision
	push ax
	push bx
	push cx
	push dx

	dec [hp]
	mov [had_collision_with_enemy], 1

	call WaitKey

	cmp [hp], 0
	jg hp_is_not_0_yet
		mov bh, 03h
		call Clear
		mov bx, offset explosion
		mov cx, [offset pos_x]
		mov dx, [offset pos_y]
		call DrawCharacter
	
		mov bl, 0fh
		mov dh, 11
		mov dl, 55
		mov bp, offset game_over
		call PrintText

		mov [word speed], 0
		call WaitKey

		pop dx
		pop cx
		pop bx
		pop ax
		ret

	hp_is_not_0_yet:
		mov bx, offset explosion
		mov cx, [offset pos_x]
		mov dx, [offset pos_y]
		call DrawCharacter

		pop dx
		pop cx
		pop bx
		pop ax
		ret
endp


proc CloudCollision
	push ax
	push bx
	push cx
	push dx

	mov bh, 0fh
	call Clear
	
	mov cx, 22
	push bx
	push dx
	xor dx, dx
	mov bx, [offset speed]
	divi cx, bx
	pop dx
	pop bx
	in_cloud_move:
		call GetInput
		call MoveAllEnemies
		call Delay
		loop in_cloud_move

	mov bh, 03h
	call Clear

	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp

proc BonusCollision
	push bx
	push cx

	inc [score]

	mov [collected_bonus], 1

	mov [bullet_mode_timer], 0
	mov [bonus_active], 0

	mov cx, [bonus_mod]
	mov [bullet_mode], cx

	pop cx
	pop bx
	ret
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

	add cx, [drawing_tile_x_offset]

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

			push ax
			xor ax, ax
			mov ah, 0dh
			int 10h

			cmp [word drawing_main_character], 1
			jne not_drawing_main_character
				cmp al, 0fh
				jne no_collision_detected0
					call CloudCollision

				no_collision_detected0:
				cmp [had_collision_with_enemy], 0
				jne already_cought_collision_with_enemy
					cmp al, 04h
					jne no_collision_detected1
						call EnemyCollision

					no_collision_detected1:
					cmp al, 01h
					jne no_collision_detected2
						call EnemyCollision
				already_cought_collision_with_enemy:

				no_collision_detected2:
				cmp al, 0eh
				jne no_collision_at_all
					cmp [word collected_bonus], 0
					jne already_collected_bonus_this_frame
						call BonusCollision
					already_collected_bonus_this_frame:

			not_drawing_main_character:
			cmp [word drawing_bullet], 1
			jne no_collision_at_all

				no_collision_detected3:
				cmp al, 01h
				jne no_collision_detected4
					call BulletCollision

				no_collision_detected4:
				cmp al, 04h
				jne no_collision_at_all
					call BulletCollision
			
			no_collision_at_all:
			pop ax

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

		mov [collected_bonus], 0
		mov [had_collision_with_enemy], 0

		ret
endp

proc DrawCharacter ; draw a character, input: offset saved in bx, top left pixel position in (cx, dx).
	push dx
	push bx
	push ax
	push cx
	
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
	push es

	push ax
	mov ax, @data
	mov es, ax
	pop ax

	xor ax, ax
	mov ah, 02h
	xor bh, bh
	
	int 10h
	
	xor ax, ax
	mov ah, 13h ; WRITE THE STRING
	mov al, 01h; ATTRIBUTE IN BL, MOVE CURSOR TO THAT POSITION
	mov bh, 0
	;mov bl, 5 ;GREEN
	call GetLength
	;mov cx, 7 ; LENGTH OF THE STRING
	int 10h
	
	pop es
	pop cx
	pop bx
	pop ax

	ret
endp

proc PrintSingle ; Print 
	push ax
	push bx
	push cx

	xor ax, ax
	mov ah, 0ah
	mov bh, 0
	mov bl, 5
	mov cx, 1
	int 10h

	pop cx
	pop bx
	pop ax

	ret
endp

proc MovCrsr
	push ax
	push bx
	
	mov ah, 02h
	xor bh, bh
	int 10h

	pop bx
	pop ax
endp

proc GetCrsr
	push ax
	push bx
	push cx
	
	xor ax, ax
	mov ah, 03h
	xor bh, bh
	int 10h

	pop cx
	pop bx
	pop ax
endp

proc PrintNumber
	push cx
	push dx
	push bx
	push ax

	; cmp ax, 0
	; jne number_is_not_0
	; 	mov [temp_char], '0'
	; 	mov bp, offset temp_char
	; 	mov bx, 035h
	; 	call GetCrsr

	; 	call PrintText

	; 	pop ax
	; 	pop bx
	; 	pop dx
	; 	pop cx
	; 	ret
	; number_is_not_0:

    ; initilize count:
    xor cx, cx
    xor dx, dx

    Label1:
        ; if ax is zero:
        cmp ax, 0
        je Print1
        
        ; initilize bx to 10:
        mov bx, 10
        
		xor dx, dx
        ; extract the last digit:
        div bx
        
        ; push it in the stack:
        push dx
        
        ; increment the count:
        inc cx
        
        jmp Label1

    Print1:
        ; check if count:

        ; is greater than zero:
        cmp cx, 0
        je Endprint
        
        ; pop the top of stack:
        pop dx

        ; add 48 so that it represents the ASCII value of digits:
        add dx, '0' 
        
        ; interuppt to print a character:
		push bx
		push cx
		push dx

		mov [temp_char], dl
		mov bp, offset temp_char
		mov bx, 035h
		call GetCrsr

		call PrintText

		pop dx
		pop cx
		pop bx
        
        ; decrease the count:
        dec cx
        jmp Print1
    
    Endprint:
		pop ax
		pop bx
		pop dx
		pop cx
        ret
endp

proc Random
	push cx
	push ax
	push bx
	push dx
	
	xor ax,ax
	int 1ah     ; int 1ah/ah=0 get timer ticks since midnight in cx:dx.
	sub ax, cx  ; use lower 16 bits (in dx) for random value.
	add ax, dx
	

	xor cx, cx
	random_loop:
		cmp cx, 16
		je end_random_loop

		xor dx,dx
		div bx

		push cx
		push bx
		mov bx, cx
		add bx, offset random_nums
		mov [bx], dx
		pop bx
		pop cx

		inc cx
		inc cx
		jmp random_loop
	end_random_loop:
		pop dx
		pop bx
		pop ax
		pop cx
		ret
endp

proc MoveAllEnemies
	push ax
	push bx
	push cx
	push dx

	mov bx, offset line_ys
	move_all_enemies:
		push bx
		sub bx, offset line_ys
		cmp bx, 16
		pop bx
		jne dont_end_move_all_enemies
			jmp end_move_all_enemies
		dont_end_move_all_enemies:

		push cx
		mov cx, [offset speed]
		add [word bx], cx
		pop cx
		cmp [word bx], win_height
		jle line_not_past_win_height
			push bx
			mov [word bx], 0
			sub bx, offset line_ys
			add bx, offset line_types
			cmp [word bx], 1
			jne not_enemy_no_score_change
				dec [score]
				inc [past_enemies]

				; push ax
				; push bx
				; push cx
				; push dx

				; mov ax, [past_enemies]

				; mov cx, 4
				; mov bx, [speed]
				; mult cx, bx
				; xor dx, dx
				; div cx
				
				; cmp dx, 0
				; jne dont_increase_speed
				; 	inc [speed]
				; 	inc [bonus_mod]
				; 	mov [past_enemies], 0
				; dont_increase_speed:
				; pop dx
				; pop cx
				; pop bx
				; pop ax

				cmp [score], 0
				jg not_dead_yet	
					mov bh, 03h
					call Clear
					mov dh, 11
					mov dl, 55
					mov bp, offset game_over
					mov bl, 0fh
					call PrintText
					mov [word speed], 0
					call WaitKey2
					
				not_dead_yet:
			not_enemy_no_score_change:
			mov [word bx], 2
			pop bx

		line_not_past_win_height:
		inc bx
		inc bx

		jmp move_all_enemies

	end_move_all_enemies:
		pop dx
		pop cx
		pop bx
		pop dx
		ret
endp

proc DrawCloudsAndEnemies
	push ax
	push bx
	push cx
	push dx

	xor bx, bx
	xor cx, cx
	xor dx, dx
	draw_clouds_and_enemies_loop:
		cmp bx, 16
		je end_draw_clouds_and_enemies_loop

		push bx
		add bx, offset line_xs
		mov cx, [bx]
		pop bx

		push bx
		add bx, offset line_ys
		mov dx, [bx]
		pop bx

		xor al, al
		push bx
		add bx, offset line_types
		cmp [word bx], 2
		jl line_not_empty
			pop bx
			inc bx
			inc bx
			jmp draw_clouds_and_enemies_loop
		line_not_empty:
		cmp [word bx], 0
		je draw_cloud
			mov bx, offset enemy
		jmp draw_cloud_or_enemy
		draw_cloud:
			mov bx, offset cloud
		draw_cloud_or_enemy:
		push ax
		push cx
		push dx
		push bx

		xor dx, dx
		mov ax, cx
		mov bx, grid_size
		div bx
		mov cx, ax
		mov [drawing_tile_x_offset], dx

		pop bx
		pop dx
		pop cx
		pop ax

		call DrawCharacter

		mov [drawing_tile_x_offset], 0
		pop bx

		inc bx
		inc bx

		jmp draw_clouds_and_enemies_loop

	end_draw_clouds_and_enemies_loop:
		call MoveAllEnemies
		pop dx
		pop cx
		pop bx
		pop ax
		ret
endp

proc DrawNewEnemies
	push ax
	push bx
	push cx
	push dx

	xor cx, cx
	xor dx, dx
	mov bx, 3
	call Random
	mov bx, offset line_types
	draw_new_clouds_and_enemies_loop:
		push bx
		sub bx, offset line_types
		cmp bx, 16
		pop bx
		je end_new_draw_clouds_and_enemies_loop

		xor al, al
		cmp [word bx], 2
		jl new_line_not_empty
			push dx
			push bx
			sub bx, offset line_types
			add bx, offset random_nums
			mov dx, [bx]

			pop bx
			mov [word bx], dx
			pop dx

			push bx
			sub bx, offset line_types
			add bx, offset line_ys
			mov [word bx], 0
			pop bx

			inc bx
			inc bx
			jmp draw_new_clouds_and_enemies_loop
		new_line_not_empty:

		inc bx
		inc bx

		jmp draw_new_clouds_and_enemies_loop

	end_new_draw_clouds_and_enemies_loop:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
endp

proc MakeBullet
	push bx
    push cx
    push dx

	xor dx, dx
	mov bx, [current_bullet]
	mov cx, 8
	mult bx, cx
	
	mov cx, [pos_x]
	add cx, 7

	add bx, offset bullets

	add bx, 2 ; +1
	mov [bx], cx
	mov dx, [pos_y]
	sub dx, 4

	add bx, 2 ; +2
	mov [bx], dx

	add bx, 2 ; +3
	mov [word bx], 4 ; set speed
	
	mov [current_shooted_bullet], bx
	push bx

	mov [drawing_bullet], 1

	mov bx, offset bullet

	call DrawCharacter
	mov [drawing_bullet], 0

	pop bx

	pop dx
	pop cx
	pop bx
	ret
endp

proc PopBullet; move all bullets one position back, to remove void created by the deactivated bullet.      bx - bullet position in memory
	push ax
	push bx
	push cx
	push dx

	add bx, 8 ; move bx to offset of next bullet

	pop_bullet_loop:
		cmp bx, total_bullets
		jge end_pop_bullet_loop

		mov cx, [bx]
		mov [bx-8], cx
		add bx, 2

		mov cx, [bx]
		mov [bx-8], cx
		add bx, 2

		mov cx, [bx]
		mov [bx-8], cx
		add bx, 2

		mov cx, [bx]
		mov [bx-8], cx
		add bx, 2

		jmp pop_bullet_loop

	end_pop_bullet_loop:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
endp

proc ShootBullet
	push bx
    push cx
    push dx

	xor bx, bx

	shoot_bullet_loop:
		cmp bx, total_bullets
		jge end_shoot_bullet_loop

		push bx
		add bx, offset bullets ; +0

		; push ax
		; mov ax, [bx]
		; call PrintNumber
		; pop ax

		cmp [word bx], 0
		je end_shoot_bullet

		make_bullet_step:
			add bx, 2 ; +1
			mov cx, [bx] ; cx = x
			add bx, 4 ; +3

			push cx
			mov cx, [bx] ; cx = speed

			sub bx, 2 ; +2
			cmp [bx], cx
			jl not_negative
				sub [bx], cx ; y = y - speed
				jmp after_negative
			not_negative:
				mov [word bx], 0
			after_negative:
			mov dx, [bx] ; dx = y (- speed)
			pop cx

			sub bx, 4 ; +0

			mov [drawing_bullet], 1
			mov [current_shooted_bullet], bx
			push bx
			mov bx, offset bullet
			call DrawCharacter
			mov [drawing_bullet], 0
			pop bx
			add bx, 4; +2
			cmp [word bx], 0 ; check if y <= 0
			jg end_shoot_bullet

				; destroy bullet:
				sub bx, 4 ; +0

				mov [word bx], 0 ; deactivate
				cmp [current_bullet], 0
				jg current_bullet_is_not_0
					inc [current_bullet]
				current_bullet_is_not_0:
				dec [current_bullet]

				;call PopBullet

		end_shoot_bullet:
			pop bx
			add bx, 8
			jmp shoot_bullet_loop

	end_shoot_bullet_loop:
        pop dx
        pop cx
        pop bx
        ret
endp

proc GetTimeSeconds ; returns time in seconds in dx
	push cx
	push ax

	xor al, al
	mov ah, 2ch
	int 21h

	mov dl, dh
	xor dh, dh

	mov ax, dx
	call PrintNumber

	pop ax
	pop cx
endp

proc CreateBonus
	push ax
	push bx
	push cx
	push dx

	mov [bonus_active], 1
	mov [bonus_timer], 0

	mov bx, win_width

	xor ax,ax
	int 1ah     ; int 1ah/ah=0 get timer ticks since midnight in cx:dx.
	sub ax, cx  ; use lower 16 bits (in dx) for random value.
	add ax, dx
	xor dx, dx
	div bx
	
	mov [bonus_pos], dx


	mov bx, win_height

	xor ax,ax
	int 1ah     ; int 1ah/ah=0 get timer ticks since midnight in cx:dx.
	sub ax, cx  ; use lower 16 bits (in dx) for random value.
	add ax, dx
	xor dx, dx
	div bx
	
	mov [bonus_pos+2], dx

	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp

proc DrawBonus
	push bx
	push cx
	push dx

	mov bx, [bonus_timer]
	mov cx, [bonus_time_on_screen]
	cmp bx, cx
	jge deactivate_bonus

	cmp [bonus_active], 1
	jne bonus_not_active
		mov bx, offset bonus
		mov cx, [bonus_pos]
		mov dx, [bonus_pos+2]
		call DrawCharacter
		inc [bonus_timer]

	bonus_not_active:
		pop dx
		pop cx
		pop bx
		ret

	deactivate_bonus:
		mov [bonus_active], 0
		mov [bonus_timer], 0
		pop dx
		pop cx
		pop bx
		ret
endp

proc UpdateBulletMode
	push bx
	push cx

	mov bx, [bullet_mode_timer]
	mov cx, [bullet_mode_max_time]
	cmp bx, cx
	jl dont_deactivate_bullet_mod
		mov [bullet_mode], 1

	dont_deactivate_bullet_mod:
		inc [bullet_mode_timer]

		pop cx
		pop bx
		ret

endp

proc MainLoop ; Main loop of the game.
	mov cx, [offset pos_x]
	mov dx, [offset pos_y]
	xor bx, bx
	
	main_loop:
		push bp
		push dx
		push ax

		xor dx, dx
		push bx
		mov bl, 035h
		mov bp, offset score_text
		call PrintText
		pop bx

		mov dl, 6
		mov ax, [offset score]
		call PrintNumber

		add dl, 4

		push bx
		mov bl, 035h
		mov bp, offset hp_text
		call PrintText
		pop bx

		mov dl, 6
		mov ax, [offset hp]
		call PrintNumber

		cmp [bullet_mode], 1
		je bonus_not_active_no_print

			call GetCrsr

			add dl, 4

			push bx
			mov bl, 035h
			mov bp, offset bonus_active_text
			call PrintText
			pop bx

			push ax
			mov ax, [bullet_mode_max_time]
			sub ax, [bullet_mode_timer]
			call PrintNumber
			pop ax

		bonus_not_active_no_print:

		pop ax
		pop dx
		pop bp
		
		push cx
		push ax
		push dx
		mov ax, [tick]
		mov cx, 20
		push bx
		mov bx, [offset speed]
		xor dx, dx
		divi cx, bx
		pop bx
		xor dx, dx
		div cx
		cmp dx, 0
		jne dont_draw_new_enemies
			call DrawNewEnemies
		dont_draw_new_enemies:
		pop dx
		pop ax
		pop cx


		call DrawBonus
		call UpdateBulletMode

		push dx
		push cx
		push ax

		mov ax, [tick]
		inc ax
		mov cx, 300
		xor dx, dx
		div cx
		cmp dx, 0
		jne dont_create_new_bonus
			call CreateBonus
		dont_create_new_bonus:

		pop ax
		pop cx
		pop dx

		; push cx
		; push bx
		; push dx
		; push ax

		; increase speed with time:
		; mov ax, bx
		; inc ax
		; mov cx, 300
		; xor dx, dx
		; div cx
		; cmp dx, 0
		; jne dont_increase_speed
		; 	inc [speed]
		; 	inc [bonus_mod]
		; dont_increase_speed:

		; pop ax
		; pop dx
		; pop bx
		; pop cx

		push cx
		push bx
		push dx
		push ax

		mov ax, [score]

		; update high score:
		mov bx, [high_score]
		cmp ax, bx
		jle no_new_high_score
			mov [high_score], ax

			; increase speed with score:
			; jle dont_increase_speed
			; mov cx, 10
			; xor dx, dx
			; div cx
			; cmp dx, 0
			; jne dont_increase_speed
			; 	inc [speed]
			; 	inc [bonus_mod]
			; dont_increase_speed:

		no_new_high_score:	
		

		pop ax
		pop dx
		pop bx
		pop cx

		call DrawCloudsAndEnemies
		

		call ShootBullet

		push ax
		call GetInput
		pop ax

		xor cx, cx
		xor dx, dx

		mov cx, [offset pos_x]
		mov dx, [offset pos_y]

		push bx
		cmp bx, 0
		je first_frame_skip_collisions
			mov [word drawing_main_character], 1
		first_frame_skip_collisions:
		
		cmp [turn], 0
		je draw_normal_char
		
		cmp [turn], 1
		je draw_left_char
		mov bx, offset char_right
		jmp no_need_to_change_shape
		draw_left_char:
			mov bx, offset char_left
			jmp no_need_to_change_shape
		
		draw_normal_char:
			mov bx, offset character

		no_need_to_change_shape:
		call DrawCharacter
		mov [word drawing_main_character], 0
		pop bx

		inc bx
		inc [tick]
		call ClearAndDelay
		jmp main_loop

	end_main_loop:
		ret
endp

start:
	mov ax, @data
	mov ds, ax

	mov ax, 013h ; set vga mode
	int 10h

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

; -------------------------