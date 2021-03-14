;------------------------------------------
; PURPOSE: Recursive Backtracking Assembly Game.
; DESCRIPTION: Random maze solving game generated with recursive backtracking implemented in Assembly.
; SYSTEM: Turbo Assembler Ideal Mode.
; AUTHOR: Omri Hulaty and Aylon Moyal.
;------------------------------------------
; algorithm details from https://en.wikipedia.org/wiki/Maze_generation_algorithm under randomized depth-first search / Iterative implementation.
; colors from https://www.fountainware.com/EXPL/vga_color_palettes.htm.
; screen size infomation from http://www.wagemakers.be/english/doc/vga.
;------------------------------------------

IDEAL

MODEL small

STACK 200h

DATASEG

    tile equ 16
    maze equ mazeTL
    x_screen equ 640
    y_screen equ 384
    spacing equ 4
    step equ 16

    maze_index dw 0
    screen_blocks_x db 40
    screen_blocks_y db 24
    offset_x dw 0
    offset_y dw 0
    color db 0fh

    pos_x_one dw 0
    pos_y_one dw 0
    pos_x_two dw 0
    pos_y_two dw 0
    player_print db 1
            
    mazeTL      db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
 
    mazeTR      db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'

    mazeBL      db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
    
    mazeBR      db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'
                db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 'n'

    ; 15h = 1111b = all borders.
    ; 1'st - up, 2'nd - right, 3'rd - down, 4'th - left.
    ; for example: 0000 - no borders, 1111 - all borders, 0101 - right & left borders.
    
    playerOne   db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h ,00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h ,00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 34h ,00h, 00h, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 34h ,00h, 00h, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 34h, 34h ,34h, 34h, 34h, 34h, 34h, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 34h, 34h ,34h, 34h, 34h, 34h, 34h, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 34h, 34h, 00h ,00h, 34h, 34h, 00h, 00h, 34h, 34h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 34h, 34h, 00h ,00h, 34h, 34h, 00h, 00h, 34h, 34h, 00h, 00h, 't', 'n'
                db 't', 00h, 34h, 34h, 34h, 34h ,34h, 34h, 34h, 34h, 34h, 34h, 34h, 34h, 00h, 't', 'n'
                db 't', 00h, 34h, 00h, 34h, 34h ,34h, 34h, 34h, 34h, 34h, 34h, 00h, 34h, 00h, 't', 'n'
                db 't', 00h, 34h, 00h, 00h, 34h ,00h, 00h, 00h, 00h, 34h, 00h, 00h, 34h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 34h ,00h, 00h, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 34h, 34h ,00h, 00h, 00h, 00h, 34h, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h ,00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'

    playerTwo   db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 't', 'n'
                db 't', 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 00h, 't', 'n'
                db 't', 00h, 0Dh, 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 00h, 0Dh, 00h, 't', 'n'
                db 't', 00h, 0Dh, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 0Dh, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 0Dh, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'
    
    PlayersColl db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 0Dh, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 34h, 34h, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 34h, 00h, 00h, 34h, 34h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 0Dh, 0Dh, 00h, 00h, 0Dh, 34h, 00h, 00h, 34h, 34h, 00h, 00h, 't', 'n'
                db 't', 00h, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 0Dh, 34h, 34h, 34h, 34h, 34h, 34h, 00h, 't', 'n'
                db 't', 00h, 0Dh, 00h, 0Dh, 0Dh, 34h, 34h, 34h, 34h, 34h, 34h, 00h, 34h, 00h, 't', 'n'
                db 't', 00h, 0Dh, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 34h, 00h, 00h, 34h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 34h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 34h, 34h, 00h, 00h, 00h, 00h, 34h, 34h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'


    finishKey   db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 2Ch, 2Ch, 2Ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 2Ch, 00h, 00h, 00h, 2Ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 2Ch, 00h, 00h, 00h, 2Ch, 2Ch, 2Ch, 2Ch, 2Ch, 2Ch, 2Ch, 2Ch, 00h, 't', 'n'
                db 't', 00h, 2Ch, 00h, 00h, 00h, 2Ch, 00h, 00h, 2Ch, 00h, 00h, 2Ch, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 2Ch, 2Ch, 2Ch, 00h, 00h, 00h, 2Ch, 00h, 00h, 2Ch, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2Ch, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'

    speedBoost  db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 't', 'n'
                db 't', 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 't', 'n'
                db 't', 00h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 't', 'n'
                db 't', 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 't', 'n'
                db 't', 00h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'

    speedBoost2 db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 't', 'n'
                db 't', 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 't', 'n'
                db 't', 00h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 00h, 't', 'n'
                db 't', 00h, 36h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 36h, 't', 'n'
                db 't', 00h, 36h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 36h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'
    
    plusTime    db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 28h, 28h, 28h, 28h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 28h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 28h, 28h, 28h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 28h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 00h, 00h, 00h, 00h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 28h, 00h, 28h, 28h, 28h, 28h, 28h, 28h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'
        
    minusTime   db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 30h, 30h, 30h, 30h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 30h, 30h, 30h, 30h, 00h, 00h, 30h, 30h, 30h, 30h, 30h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 30h, 30h, 30h, 30h, 30h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 't', 'n'
                db 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 't', 'n'
                db '$'

    neighbours db 0
    neighbour_count db 0
    neighbours_indexes db 4 dup(0)

    time db 50
    last_time db 0
    total_first_time dw 0
    total_second_time dw 0
    level db 1
    direction_one db 0
    direction_two db 0

    end_message_one db 'Player 1 score: ', '$'
    end_message_two db 13, 10, 'Player 2 score: ', '$'
    first_time_message db 'player 1: ', '$'
    second_time_message db ' // player 2: ', '$'
    spaces_message db ' ', '$'
    draw_message db 13, 10, 10, 'There is a draw! Both players finished with the same score!', '$'
    player_one_win_message db 13, 10, 10, 'Player 1 won the game!', '$'
    player_two_win_message db 13, 10, 10, 'Player 2 won the game!', '$'

    finish_x_value dw 656
    finish_y_value dw 400
    
    speed_x_value dw 656
    speed_y_value dw 400
    speed_two_x_value dw 656
    speed_two_y_value dw 400
    plus_time_x_value dw 656
    plus_time_y_value dw 400
    minus_time_x_value dw 656
    minus_time_y_value dw 400

    base_sp dw ?
    speed dw 25000
    info_space db 7

    opening_message db 10, ' WELCOME TO OUR A-MAZE-ING GAME!', 13, 10, 10
                    db ' Your goal is to finish all levels as fast as possible', 13,10
                    db ' The rules for this game are the following:', 13, 10, 10
                    db ' 1. Use the arrow keys to mov(e) player no.1 and the a,s,d,w keys to mov(e)', 13, 10
                    db '    palyer no.2', 13, 10, 10
                    db ' 2. Throughout the game you will find 4 special tokens: +10 seconds, -5         '
                    db '    seconds and 2 speed boosts. Notice that the speed boosts apply to both      '
                    db '    players, so think well before you take it!', 13, 10, 10
                    db ' 3. To finish a level, you need to reach the finish-key in the maze. The        '
                    db '    first player to reach the key gets 2 seconds off his time!', 13, 10, 10
                    db ' 4. There is a time limit for each level, so you need to get the key in time    '
                    db '    or you will recieve the maximum time for the level', 13, 10, 10
                    db ' 5. The fastest player is the winner, and can even set a new record for the     '
                    db '    next games!', 13, 10, 10, 10
                    db ' PRESS ANY KEY TO START!', '$'

    file_name db 'testfile.txt', 0
    file_handle dw 0
    best_score_message db 0
    error_message db 'Error', 10, 13, '$'
    best_score_from_file db 0, 0, '$'
    best_score_title db 13, 10, 'Best score of all time: ', '$'


CODESEG

proc OpenFile
	mov ah, 3Dh
	mov al, 2
	lea dx, [file_name]
	int 21h
	jc Open_Error
	mov [file_handle], ax
	ret

	Open_Error:
		lea dx, [error_message]
		mov ah, 9h
		int 21h
		ret
endp OpenFile


proc WriteToFile
	mov ah, 40h
	mov bx, [file_handle]
	mov cx, 2

	lea dx, [best_score_message]
	int 21h
	ret
endp WriteToFile


proc ReadFile
	mov ah, 3Fh
	mov bx, [file_handle]
	mov cx, 2

	lea dx, [best_score_from_file]
	int 21h
	ret
endp ReadFile


proc CloseFile
	mov ah, 3Eh
	mov bx, [file_handle]
	int 21h
	ret
endp CloseFile


proc UpdateBestScore
    cmp [word best_score_from_file], ax
    jb No_Change

    mov [word best_score_message], ax
    call OpenFile
    call WriteToFile
    call CloseFile
    ret

    No_Change:
        ret
endp UpdateBestScore


proc CheckCollision
    push cx
    push dx

    mov cx, [pos_x_one]
    cmp cx, [pos_x_two]
    jne Players_Not_Colliding

    mov dx, [pos_y_one]
    cmp dx, [pos_y_two]
    jne Players_Not_Colliding

    lea bx, [PlayersColl]
    call DrawCharacter


    Players_Not_Colliding:
        mov cx, [pos_x_one]
        cmp cx, [finish_x_value]
        jne Player_One_Not_Coll_Fin

        mov cx, [pos_y_one]
        cmp cx, [finish_y_value]
        jne Player_One_Not_Coll_Fin

        mov [finish_x_value], 656
        mov [finish_y_value], 400

        mov cx, 2
    End_Level_Loop:
        sub [total_first_time], 1
        cmp [total_first_time], 0
        je Next_Level
        loop End_Level_Loop
    
    Next_Level:
        mov [time], 1


    Player_One_Not_Coll_Fin:
        mov cx, [pos_x_two]
        cmp cx, [finish_x_value]
        jne No_Coll_With_Fin

        mov cx, [pos_y_two]
        cmp cx, [finish_y_value]
        jne No_Coll_With_Fin

        mov [finish_x_value], 656
        mov [finish_y_value], 400
        
        mov cx, 2
    End_Level_Loop_Two:
        sub [total_second_time], 1
        cmp [total_second_time], 0
        je Next_Level_Two
        loop End_Level_Loop_Two
    
    Next_Level_Two:
        mov [time], 1


    No_Coll_With_Fin:
        mov cx, [pos_x_one]
        cmp cx, [speed_x_value]
        jne No_Coll_With_Fin_Two

        mov cx, [pos_y_one]
        cmp cx, [speed_y_value]
        jne No_Coll_With_Fin_Two

        mov [speed], 1
        mov ah, 03h 
        mov al, 05h
        mov bh, 00h
        mov bl, 06h
        int 16h

        mov [speed_x_value], 656
        mov [speed_y_value], 400


    No_Coll_With_Fin_Two:
        mov cx, [pos_x_two]
        cmp cx, [speed_x_value]
        jne No_Coll_Speed_One

        mov cx, [pos_y_two]
        cmp cx, [speed_y_value]
        jne No_Coll_Speed_One

        mov [speed], 1
        mov ah, 03h 
        mov al, 05h
        mov bh, 00h
        mov bl, 06h
        int 16h

        mov [speed_x_value], 656
        mov [speed_y_value], 400

    
    No_Coll_Speed_One:
        mov cx, [pos_x_one]
        cmp cx, [speed_two_x_value]
        jne No_Coll_Speed_One_Two

        mov cx, [pos_y_one]
        cmp cx, [speed_two_y_value]
        jne No_Coll_Speed_One_Two

        mov [speed], 1
        mov ah, 03h 
        mov al, 05h
        mov bh, 00h
        mov bl, 06h
        int 16h

        mov [speed_two_x_value], 656
        mov [speed_two_y_value], 400


    No_Coll_Speed_One_Two:
        mov cx, [pos_x_two]
        cmp cx, [speed_two_x_value]
        jne Not_Coll_Speed

        mov cx, [pos_y_two]
        cmp cx, [speed_two_y_value]
        jne Not_Coll_Speed

        mov [speed], 1
        mov ah, 03h 
        mov al, 05h
        mov bh, 00h
        mov bl, 06h
        int 16h

        mov [speed_two_x_value], 656
        mov [speed_two_y_value], 400


    Not_Coll_Speed:
        mov cx, [pos_x_one]
        cmp cx, [minus_time_x_value]
        jne Not_Coll_Speed_Two

        mov cx, [pos_y_one]
        cmp cx, [minus_time_y_value]
        jne Not_Coll_Speed_Two
        
        mov cx, 5
    Minus_Time_Loop:
        sub [total_first_time], 1
        cmp [total_first_time], 0
        je Finish_Minus_Time
        loop Minus_Time_Loop
    
    Finish_Minus_Time:
        mov [minus_time_x_value],  656
        mov [minus_time_y_value],  400
    

    Not_Coll_Speed_Two:
        mov cx, [pos_x_two]
        cmp cx, [minus_time_x_value]
        jne Not_Colliding_Minus

        mov cx, [pos_y_two]
        cmp cx, [minus_time_y_value]
        jne Not_Colliding_Minus

        mov cx, 5
    Minus_Time_Loop_Two:
        sub [total_second_time], 1
        cmp [total_second_time], 0
        je Finish_Minus_Time_Two
        loop Minus_Time_Loop_Two
    
    Finish_Minus_Time_Two:
        mov [minus_time_x_value],  656
        mov [minus_time_y_value],  400


    Not_Colliding_Minus:
        mov cx, [pos_x_one]
        cmp cx, [plus_time_x_value]
        jne Not_Colliding_Minus_Two

        mov cx, [pos_y_one]
        cmp cx, [plus_time_y_value]
        jne Not_Colliding_Minus_Two

        add [total_first_time], 10
        mov [plus_time_x_value], 656
        mov [plus_time_y_value], 400


    Not_Colliding_Minus_Two:
        mov cx, [pos_x_two]
        cmp cx, [plus_time_x_value]
        jne Not_Colliding

        mov cx, [pos_y_two]
        cmp cx, [plus_time_y_value]
        jne Not_Colliding

        add [total_second_time], 10
        mov [plus_time_x_value], 656
        mov [plus_time_y_value], 400

    Not_Colliding:
        pop dx
        pop cx
        ret
endp CheckCollision


; dh - row, dl - column.
proc MovCrsr
	push ax
	push bx
	push cx

	mov ah, 02h
	mov bh, 0
	int 10h
	
	pop cx
	pop bx
	pop ax
	ret
endp MovCrsr


proc RandomXValue
    push bx
    push cx
    mov ah, 00h  ; interrupts to get system time.
   	int 1Ah      ; cx:dx now hold number of clock ticks since midnight.

	mov ax, dx
	xor dx, dx
    xor cx, cx
    mov cl, [screen_blocks_x]
    sub cx, bx
	div cx
    add dx, bx
    shl dx, spacing

    pop cx
    pop bx
    ret
endp RandomXValue


proc RandomYValue
    push cx

    mov ah, 00h  ; interrupts to get system time.
   	int 1Ah      ; cx:dx now hold number of clock ticks since midnight.

	mov ax, dx
	xor dx, dx
    xor cx, cx
    mov cl, [screen_blocks_y]
    sub cx, bx
	div cx
    add dx, bx
    shl dx, spacing

    pop  cx
    ret
endp RandomYValue


; draw a character: offset saved in bx, position in (cx, dx).
proc DrawCharacter
	push dx
	push bx
	push ax
	push cx
    mov bp, cx
    xor ax, ax

	Draw_Line_Loop:
		mov al, [bx]
		cmp al, '$'
		je End_Line_Loop

        cmp al, 't'
		jne New_Line

        inc cx
		inc bx
		jmp Draw_Line_Loop
		
    New_Line:
		cmp al, 'n'
		jne Skip_New_Line

        mov cx, bp
        inc dx
		inc bx
		jmp Draw_Line_Loop

    Skip_New_Line:
        mov [color], al
		call DrawPix
		inc cx
		inc bx
		jmp Draw_Line_Loop
		
	End_Line_Loop:
		pop cx
		pop ax
		pop bx
		pop dx
		ret
endp DrawCharacter


proc Random
    push cx
    push ax
        
    xor ax, ax
    int 1Ah     ; int 1ah/ah=0 get timer ticks since midnight in cx:dx.
    sub ax, cx  ; use lower 16 bits (in dx) for random value.
    add ax, dx
    xor dx, dx
    div bx

    pop ax
    pop cx
    ret
endp Random


proc PrepMazeIndex
    push ax
    xor ax, ax

    mov ah, [byte maze_index]
    mov dx, 252
    mul dx
    mov [maze_index], ax

    pop ax
    ret
endp PrepMazeIndex


proc GenerateMaze
    call EraseMaze
    push dx
    push [maze_index]
    mov bx, 12
    call Random
    mov al, 21
    mul dx
    mov bx, 20
    call Random
    add ax, dx
    mov bx, ax
    mov [base_sp], sp
    push bx
    add bx, [maze_index]
    or [maze + bx], 10000B

    Generetion_Loop:
        mov cx, 0
        mov dx, 1
	    mov ah, 86h
	    int 15h

        cmp [base_sp], sp
        je End_Generetion_Loop_One
        pop cx
        call GetNeighbours
        cmp [neighbour_count], 0
        jne Has_Neighbours
        jmp Generetion_Loop

    End_Generetion_Loop_One:
        jmp End_Generetion_Loop

    Has_Neighbours:
        push cx
        xor bx, bx
        mov bl, [neighbour_count]
        call Random
        xor ax, ax
        mov al, [neighbours]
        xor bx, bx
        dec bx

    NIUp:
        and ax, 1000B
        cmp ax, 1000B
        jne NIRight
        inc bx
        mov [neighbours_indexes + bx], cl
        sub [neighbours_indexes + bx], 21

    NIRight:
        xor ax, ax
        mov al, [neighbours]
        and ax, 0100B
        cmp ax, 0100B
        jne NIDown
        inc bx
        mov [neighbours_indexes + bx], cl
        inc [neighbours_indexes + bx]
    NIDown:
        xor ax, ax
        mov al, [neighbours]
        and ax, 0010B
        cmp ax, 0010B
        jne NILeft
        inc bx
        mov [neighbours_indexes + bx], cl
        add [neighbours_indexes + bx], 21

    NILeft:
        xor ax, ax
        mov al, [byte neighbours]
        and ax, 0001B       
        cmp ax, 0001B
        jne End_Index_Choosing
        inc bx
        mov [neighbours_indexes + bx], cl
        dec [neighbours_indexes + bx]

    End_Index_Choosing:
        mov bx, dx
        mov dl, [byte neighbours_indexes + bx]

    NBUp:
        mov ax, cx
        sub ax, 21
        cmp dx, ax
        jne NBRight
        mov bx, cx
        add bx, [maze_index]
        and [maze + bx], 10111B
        mov bx, dx
        add bx, [maze_index]
        and [maze + bx], 11101B

    NBRight:
        mov ax, cx
        inc ax
        cmp dx, ax
        jne NBDown
        mov bx, cx
        add bx, [maze_index]
        and [maze + bx], 11011B
        mov bx, dx
        add bx, [maze_index]
        and [maze + bx], 11110B

    NBDown:
        mov ax, cx
        add ax, 21
        cmp dx, ax
        jne NBLeft
        mov bx, cx
        add bx, [maze_index]
        and [maze + bx], 11101B
        mov bx, dx
        add bx, [maze_index]
        and [maze + bx], 10111B

    NBLeft:
        mov ax, cx
        dec ax
        cmp dx, ax
        jne End_Border_Removing
        mov bx, cx
        add bx, [maze_index]
        and [maze + bx], 11110B
        mov bx, dx
        add bx, [maze_index]
        and [maze + bx], 11011B

    End_Border_Removing:
        xor ax, ax
        mov bx, dx
        add bx, [maze_index]
        add [maze + bx], 10000B
        mov bl, [maze + bx]
        push dx
        jmp Generetion_Loop

    End_Generetion_Loop:
        pop [maze_index]
        pop dx
        ret 
endp GenerateMaze


proc GetNeighbours
    push cx
    push dx
    push ax
    push bx

    xor dx, dx
    mov [neighbour_count], 0
    mov [neighbours], 0000B
    mov ax, cx

    NUp:
        cmp ax, 21
        jl NRight
        mov bx, cx
        sub bx, 21
        add bx, offset maze
        add bx, [maze_index]
        mov bx, [bx]
        and bx, 10000B
        cmp bx, 10000B
        je NRight
        inc [neighbour_count]
        or [neighbours], 1000B

    NRight:
        push ax
        mov bx, 21
        div bx
        pop ax
        cmp dx, 19
        je NDown
        mov bx, cx 
        mov bx, cx
        inc bx
        add bx, offset maze
        add bx, [maze_index]
        mov bx, [bx]
        and bx, 10000B
        cmp bx, 10000B
        je NDown
        inc [neighbour_count]
        or [neighbours], 0100B

    NDown:
        cmp ax, 230
        jg NLeft
        mov bx, cx
        add bx, 21
        add bx, offset maze
        add bx, [maze_index]
        mov bx, [bx]
        and bx, 10000B
        cmp bx, 10000B
        je NLeft
        inc [neighbour_count]
        or [neighbours], 0010B

    NLeft:
        push ax
        mov bx, 21
        div bx
        pop ax
        cmp dx, 0
        je End_Neighbour_Search
        mov bx, cx
        dec bx
        add bx, offset maze
        add bx, [maze_index]
        mov bx, [bx]
        and bx, 10000B
        cmp bx, 10000B
        je End_Neighbour_Search
        inc [neighbour_count]
        or [neighbours], 0001B

    End_Neighbour_Search:
        pop bx
        pop ax
        pop dx
        pop cx
    
    ret
endp GetNeighbours


proc GetInput
    mov cx, [pos_x_one]
    mov dx, [pos_y_one]
    shr cx, spacing
    shr dx, spacing

    call GetAllMazesIndex
    mov bx, ax

    xor ax, ax
    mov ah, 1
    int 16h
    jz Next_K
    
    ; get value:
    mov ah, 0
    int 16h
    
    ; parse the input:
    cmp ah, 1h ; esc
	je Esc_Pressed
	
    cmp ah, 1bh ; esc
	je Esc_Pressed
	
    cmp ah, 48h ; up arrow
	je Up_Pressed_Middle_Label
	
    cmp ah, 50h ; down arrow
	je Down_Pressed_Middle_Label
	
    cmp ah, 4bh ; left arrow
	je Left_Pressed_Middle_Label
	
    cmp ah, 4dh ; right arrow
	je Right_Pressed_Middle_Label

    cmp ah, 11h ; 'w'
    je W_Pressed_Middle_Label

    cmp ah, 1Fh ; 's'
    je S_Pressed_Middle_Label

    cmp ah, 1Eh ; 'a'
    je A_Pressed_Middle_Label

    cmp ah, 20h ; 'd'
    je D_Pressed_Middle_Label
	
    ret

    ; load the command codes:
    Esc_Pressed:
        jmp Exit
        ret

    Next_K:
        jmp Check_Direction

    Up_Pressed_Middle_Label:
        mov [direction_one], 0
        jmp Check_Direction
    
    Down_Pressed_Middle_Label:
        mov [direction_one], 1
        jmp Check_Direction

    Left_Pressed_Middle_Label:
        mov [direction_one], 2
        jmp Check_Direction

    Right_Pressed_Middle_Label:
        mov [direction_one], 3
        jmp Check_Direction

    W_Pressed_Middle_Label:
        mov [direction_two], 0
        jmp Check_Direction
    
    S_Pressed_Middle_Label:
        mov [direction_two], 1
        jmp Check_Direction

    A_Pressed_Middle_Label:
        mov [direction_two], 2
        jmp Check_Direction

    D_Pressed_Middle_Label:
        mov [direction_two], 3
        jmp Check_Direction


    Check_Direction:
        cmp [direction_one], 0
        je Up_Pressed

        cmp [direction_one], 1
        je Down_Pressed

        cmp [direction_one], 2
        je Left_Pressed

        cmp [direction_one], 3
        je Right_Pressed


    Up_Pressed:
        mov bx, [bx]
        and bx, 1000B
        cmp bx, 1000B
        je Check_Direction_Two

        cmp [pos_y_one], 10
        jl Check_Direction_Two
        call EraseWData

	    sub [word pos_y_one], step
        jmp Check_Direction_Two

    Down_Pressed:
        mov bx, [bx]
        and bx, 0010B
        cmp bx, 0010B
        je Check_Direction_Two

        cmp [pos_y_one], y_screen - step - tile ; 320(x) * 200(y) but 200 / 16 = 12.5.
        jg Check_Direction_Two
        call EraseWData

	    add [word pos_y_one], step
        jmp Check_Direction_Two

    Left_Pressed:
        mov bx, [bx]
        and bx, 0001B
        cmp bx, 0001B
        je Check_Direction_Two

        cmp [pos_x_one], 2
        jl Check_Direction_Two
        call EraseWData

	    sub [word pos_x_one], step
        jmp Check_Direction_Two

    Right_Pressed:
        mov bx, [bx]
        and bx, 0100B
        cmp bx, 0100B
        je Check_Direction_Two

        cmp [pos_x_one], x_screen - step - tile
        jg Check_Direction_Two
        call EraseWData

	    add [word pos_x_one], step
        jmp Check_Direction_Two

    Border:
        ret

    Check_Direction_Two:
        cmp [direction_two], 0
        je W_Pressed

        cmp [direction_two], 1
        je S_Pressed

        cmp [direction_two], 2
        je A_Pressed

        cmp [direction_two], 3
        je D_Pressed_Middle_Middle_Label
    

    W_Pressed:
        mov cx, [pos_x_two]
        mov dx, [pos_y_two]
        shr cx, spacing
        shr dx, spacing

        call GetAllMazesIndex
        mov bx, ax

        mov bx, [bx]
        and bx, 1000B
        cmp bx, 1000B
        je Border
        cmp [pos_y_two], 10
        jl Border   ; Next_k_Two
        call EraseWData_Two
	    sub [word pos_y_two], step
            ret

    S_Pressed:
        mov cx, [pos_x_two]
        mov dx, [pos_y_two]
        shr cx, spacing
        shr dx, spacing
    
        call GetAllMazesIndex
        mov bx, ax

        mov bx, [bx]
        and bx, 0010B
        cmp bx, 0010B
        je Border
        cmp [pos_y_two], y_screen - step - tile ; 320(x) * 200(y) but 200 / 16 = 12.5.
        jg Next_K_Two
        call EraseWData_Two
	    add [word pos_y_two], step
            ret

    D_Pressed_Middle_Middle_Label:
        jmp D_Pressed

    A_Pressed:
        mov cx, [pos_x_two]
        mov dx, [pos_y_two]
        shr cx, spacing
        shr dx, spacing
    
        call GetAllMazesIndex
        mov bx, ax

        mov bx, [bx]
        and bx, 0001B
        cmp bx, 0001B
        je Border_Two
        cmp [pos_x_two], 2
        jl Next_K_Two
        call EraseWData_Two
	    sub [word pos_x_two], step
            ret

    D_Pressed:
        mov cx, [pos_x_two]
        mov dx, [pos_y_two]
        shr cx, spacing
        shr dx, spacing
    
        call GetAllMazesIndex
        mov bx, ax
        
        mov bx, [bx]
        and bx, 0100B
        cmp bx, 0100B
        je Border_Two
        cmp [pos_x_two], x_screen - step - tile
        jg Next_K_Two
        call EraseWData_Two
	    add [word pos_x_two], step
            ret
    
    Next_K_Two:
        ret
    
    Border_Two:
        ret
endp GetInput


proc MovePlayers
    mov cx, [word pos_x_two]
    mov dx, [word pos_y_two]
    mov bx, offset playerTwo
    call DrawCharacter

    mov cx, [word pos_x_one]
    mov dx, [word pos_y_one]
    mov bx, offset playerOne
    call DrawCharacter

    ret
endp MovePlayers


proc EraseWData
    push dx
    push cx

    mov [color], 0h
    mov ax, [word pos_x_one]
    mov dx, [word pos_y_one]
    call EraseChar

    pop cx
    pop dx
    ret
endp EraseWData


proc EraseWData_Two
    push dx
    push cx

    mov [color], 0h
    mov ax, [word pos_x_two]
    mov dx, [word pos_y_two]
    call EraseChar

    pop cx
    pop dx
    ret
endp EraseWData_Two


; get x cord in cx and y cord in dx.
proc DrawPix
    push ax

    mov ah, 0ch
    add cx, [offset_x]
    add dx, [offset_y]
    mov al, [color]
    int 10h
    sub cx, [offset_x]
    sub dx, [offset_y]

    pop ax
    ret
endp DrawPix


; get x cord in ax and dx in y cord.
proc DrawTile
    push bp
    mov bp, sp 
    push dx ; bp - 2.
    push ax ; bp - 4.
    push cx ; bp - 6.
    push bx ; bp - 8.

    cmp [player_print], 1 ; temp.
    je Tile_Print ; temp.
    shl dx, spacing
    shl ax, spacing

    Tile_Print:
        add dx, tile ; y.
        add ax, tile ; x.
        mov cx, tile

        Y:
            push cx ; bp - 10.
            mov cx, tile

            X:
                push cx ; bp - 12.
                mov cx, ax
                dec cx
                dec dx ; turn 1 - 16 to 0 - 15.

                Down_Border:
                    and bx, 0010b
                    cmp bx, 0010b
                    jne Left_Border
                    cmp [word bp - 10], tile
                    je Print_Pix

                Left_Border:
                    mov bx, [bp - 8]
                    and bx, 0001b
                    cmp bx, 0001b
                    jne Up_Border
                    cmp [word bp - 12], 1
                    je Print_Pix

                Up_Border:
                    mov bx, [bp - 8]
                    and bx, 1000b
                    cmp bx, 1000b
                    jne Right_Border
                    cmp [word bp - 10], 1
                    je Print_Pix

                Right_Border:
                    mov bx, [bp - 8]
                    and bx, 0100b
                    cmp bx, 0100b
                    jne No_Printing_Area
                    cmp [word bp - 12], tile
                    je Print_Pix
                    jmp No_Printing_Area

                Print_Pix:
                    call DrawPix

                No_Printing_Area:
                    inc dx
                    pop cx
                    dec ax

                loop X

            dec dx
            add ax, tile
            pop cx
            loop Y

        pop bx
        pop cx
        pop ax
        pop dx
        pop bp
        ret
endp DrawTile


; get x cord in ax and dx in y cord.
proc EraseChar
    push dx
    push ax
    push cx
    push bx
    mov [color], 0h

    Erase:
        add dx, tile ; y.
        add ax, tile ; x.
        mov cx, tile
        sub dx, 2
        sub ax, 2
        sub cx, 2

        EY:
            push cx
            mov cx, tile
            sub cx, 2
             
            EX:
                push cx 
                mov cx, ax
                call DrawPix
                pop cx
                dec ax
                loop EX

            add ax, tile
            dec dx
            sub ax, 2
            pop cx
            loop EY

        pop bx
        pop cx
        pop ax
        pop dx
        ret
endp EraseChar


proc EraseMaze 
    push bx
    push cx
    mov bx, offset maze
    add bx, [maze_index]
    add bx, 251

    Erase_Maze_Loop:
        cmp [byte bx], 'n'
        je Move
        mov [byte bx], 15

    Move:
        dec bx
        mov cx, offset maze - 1
        add cx, [maze_index]
        cmp bx, cx 
        jne Erase_Maze_Loop
        
    pop cx
    pop bx
    ret
endp EraseMaze


; get x in cx and y in dx and returns the index for this cell in maze.
proc GetIndex
    xor ax, ax
    mov al, 21
    push dx
    mul dx
    pop dx
    add ax, cx
    add ax, [maze_index]
    add ax, offset maze
    ret
endp GetIndex


proc GetAllMazesIndex
    push [maze_index]
    
    TLC:
        cmp dx, 11
        jg RTC
        cmp cx, 19
        jg RTC
        mov [maze_index], 0
        push dx
        call PrepMazeIndex
        pop dx
        call GetIndex

    RTC:
        cmp dx, 11
        jg LBC
        cmp cx, 20
        jl LBC
        sub cx, 20
        mov [maze_index], 1
        push dx
        call PrepMazeIndex
        pop dx
        call GetIndex
        jmp Ret_Get_All_Mazes_Index

    LBC:
        cmp dx, 12
        jl RBC
        cmp cx, 19
        jg RBC
        sub dx, 12
        mov [maze_index], 2
        push dx
        call PrepMazeIndex
        pop dx
        call GetIndex
    
    RBC:
        cmp dx, 12
        jl Ret_Get_All_Mazes_Index
        cmp cx, 20
        jl Ret_Get_All_Mazes_Index
        sub dx, 12
        sub cx, 20
        mov [maze_index], 3
        push dx
        call PrepMazeIndex
        pop dx
        call GetIndex
    
    Ret_Get_All_Mazes_Index:
        pop [maze_index]
        ret
endp GetAllMazesIndex


proc DrawMaze
    push cx
    push dx
    push ax 
    xor ax, ax
    xor dx, dx
    mov cx, 12

    MazeY:
        push cx
        mov dx, cx
        dec dx
        mov cx, 20

    MazeX:
        push cx
        dec cx
        call GetIndex
        mov bx, ax
        mov ax, cx
        cmp [byte bx], 0
        je Dont_Fill_Space
        mov [player_print], 0
        push bx
        mov bx, [word bx]
        call DrawTile
        pop bx
        mov [player_print], 1
        jmp Dont_Fill_Space

    Dont_Fill_Space:
        pop cx
        loop mazeX
        pop cx
        loop MazeY
    
    pop cx
    pop ax
    pop dx
    ret 
endp DrawMaze


proc Print_Numeric_Var
    mov cx, 0
    mov dx, 0

    Printing_Label:
        cmp ax, 0
        je Print
        
        mov bx, 10
        div bx
        push dx
        inc cx
        
        xor dx, dx
        jmp Printing_Label

    Print:
        cmp cx, 0
        je End_Print
        
        pop dx
        add dx, '0' 
        mov ah,02h
        int 21h
        
        dec cx
        jmp Print
    
    End_Print:
        ret
endp Print_Numeric_Var


proc PrintInfo
    push bx
    mov dl, [info_space]
    mov dh, 24
    call MovCrsr

    lea dx, [first_time_message]
    mov ah,09h
    int 21h

    xor ax, ax
    mov ax, [total_first_time]
    call Print_Numeric_Var

    lea dx, [second_time_message]
    mov ah, 09h
    int 21h

    xor ax, ax
    mov ax, [total_second_time]
    call Print_Numeric_Var

    lea dx, [spaces_message]
    mov ah, 09h
    int 21h
    
    pop bx
    ret
endp PrintInfo


proc GenerateTokens
    push bx
    xor bx, bx
    mov bx, 1

    cmp [time], 41
    je SBS
    cmp [time], 30
    je SBS
    cmp [time], 19
    jne Check_SpeedB2

    SBS:
        mov ax, [speed_x_value]
        mov dx, [speed_y_value]
        cmp ax, 656
        je Dont_ES
        call EraseChar
    
    Dont_ES:
        call RandomXValue
        mov cx, dx
        mov [speed_x_value], cx
        call RandomYValue
        mov [speed_y_value], dx
        mov bx, offset speedBoost
        call DrawCharacter

        mov cx, [finish_x_value]
        mov dx, [finish_y_value]
        mov bx, offset finishKey
        call DrawCharacter

    Check_SpeedB2:
        cmp [time], 37
        je SBS_Two
        cmp [time], 26
        je SBS_Two
        cmp [time], 16
        jne MT

    SBS_Two:
        mov ax, [speed_two_x_value]
        mov dx, [speed_two_y_value]
        cmp ax, 656
        je Dont_ES_Two
        call EraseChar
    
    Dont_ES_Two:
        call RandomXValue
        mov cx, dx
        mov [speed_two_x_value], cx
        call RandomYValue
        mov [speed_two_y_value], dx
        mov bx, offset speedBoost2
        call DrawCharacter

        mov cx, [finish_x_value]
        mov dx, [finish_y_value]
        mov bx, offset finishKey
        call DrawCharacter

    MT:
        cmp [time], 41
        je MTS
        cmp [time], 37
        je MTS
        cmp [time], 20
        jne PT
    
    MTS:
        mov ax, [minus_time_x_value]
        mov dx, [minus_time_y_value]
        cmp ax, 656
        je Dont_EMT
        call EraseChar
    
    Dont_EMT:
        call RandomXValue
        mov cx, dx
        mov [minus_time_x_value], cx
        call RandomYValue
        mov [minus_time_y_value], dx
        mov bx, offset minusTime
        call DrawCharacter

        mov cx, [finish_x_value]
        mov dx, [finish_y_value]
        mov bx, offset finishKey
        call DrawCharacter

    PT:
        xor ax, ax
        mov ah, [time]
        xor dx, dx
        mov cx, 3
        div cx
        cmp dx, 0
        jne FG
    
    PTS:
        mov ax, [plus_time_x_value]
        mov dx, [plus_time_y_value]
        cmp ax, 656
        je Dont_EPT
        call EraseChar
    
    Dont_EPT:
        call RandomXValue
        mov cx, dx
        mov [plus_time_x_value], cx
        call RandomYValue
        mov [plus_time_y_value], dx
        mov bx, offset plusTime
        call DrawCharacter

        mov cx, [finish_x_value]
        mov dx, [finish_y_value]
        mov bx, offset finishKey
        call DrawCharacter
    
    FG:
        pop bx
        ret
endp GenerateTokens


proc ResetMaze1
    mov [direction_one], 0
    mov [direction_two], 0

    mov [time], 22
    mov [byte screen_blocks_x], 20
    mov [byte screen_blocks_y], 12

    mov ax, 3h
    int 10h

    mov ah, 00h ; Set video mode.
    mov al, 13h ; Mode 13h.

    int 10h  

    mov [finish_x_value], 656
    mov [finish_y_value], 400
 
    mov [speed_x_value], 656
    mov [speed_y_value], 400
 
    mov [plus_time_x_value], 656
    mov [plus_time_y_value], 400
 
    mov [minus_time_x_value],  656
    mov [minus_time_y_value],  400

    mov [pos_x_one], 0
    mov [pos_y_one], 0

    mov [pos_x_two], 0
    mov [pos_y_two], 0

    ; change keyboard refresh rate to match delay between frames.
    mov ah, 03h 
    mov al, 05h
    mov bh, 00h
    mov bl, 08h
    int 16h

    mov [color], 0fh
    xor ax, ax
    call PrepMazeIndex
    call GenerateMaze
    call DrawMaze

    xor bx, bx
    push bx
    mov bl, [level]
    add bx, 3
    call RandomXValue
    mov cx, dx
    mov [finish_x_value], dx
    call RandomYValue
    mov [finish_y_value], dx
    mov bx, offset finishKey
    call DrawCharacter
    pop bx

    mov [speed], 25000
    ret
endp ResetMaze1


proc ResetMaze2
    mov [direction_one], 0
    mov [direction_two], 0

    mov [offset_x], 0
    mov [offset_y], 0
    mov [time], 33
    mov [screen_blocks_x], 40
    mov [screen_blocks_y], 12

    mov ax, 3h
    int 10h

    mov ax, 4F02h
    mov bx, 100h
    int 10h

    mov [finish_x_value], 656
    mov [finish_y_value], 400
 
    mov [speed_x_value], 656
    mov [speed_y_value], 400
 
    mov [plus_time_x_value], 656
    mov [plus_time_y_value], 400
 
    mov [minus_time_x_value],  656
    mov [minus_time_y_value],  400

    mov [pos_x_one], 0
    mov [pos_y_one], 0

    mov [pos_x_two], 0
    mov [pos_y_two], 0

    ; change keyboard refresh rate to match delay between frames.
    mov ah, 03h 
    mov al, 05h
    mov bh, 00h
    mov bl, 08h
    int 16h

    mov [color], 0fh
    xor ax, ax
    call PrepMazeIndex
    call GenerateMaze
    and [maze + 19], 11011b
    call DrawMaze

    mov [maze_index], 1
    call PrepMazeIndex
    call GenerateMaze
    mov [offset_x], 320
    mov bx, [maze_index]
    and [maze + bx], 1110b
    call DrawMaze
     
    mov [offset_x], 0
    mov [maze_index], 0

    xor bx, bx
    push bx
    mov bl, [level]
    add bx, 8
    call RandomXValue
    mov cx, dx
    mov [finish_x_value], dx
    call RandomYValue
    mov [finish_y_value], dx
    mov bx, offset finishKey
    call DrawCharacter
    pop bx

    mov [speed], 25000
    ret
endp ResetMaze2


proc ResetMaze3
    mov [direction_one], 0
    mov [direction_two], 0

    mov [offset_x], 0
    mov [offset_y], 0
    mov [time], 44
    mov [screen_blocks_x], 40
    mov [screen_blocks_y], 24

    mov ax, 3h
    int 10h

    mov ax, 4F02h
    mov bx, 100h
    int 10h  

    mov [finish_x_value], 656
    mov [finish_y_value], 400
 
    mov [speed_x_value], 656
    mov [speed_y_value], 400
 
    mov [plus_time_x_value], 656
    mov [plus_time_y_value], 400
 
    mov [minus_time_x_value],  656
    mov [minus_time_y_value],  400

    mov [pos_x_one], 0
    mov [pos_y_one], 0

    mov [pos_x_two], 0
    mov [pos_y_two], 0

    ; change keyboard refresh rate to match delay between frames.
    mov ah, 03h 
    mov al, 05h
    mov bh, 00h
    mov bl, 08h
    int 16h

    mov [color], 0fh
    xor ax, ax
    call PrepMazeIndex
    call GenerateMaze
    and [maze + 19], 11011b
    and [maze + 231], 11101b
    and [maze + 250], 1001b
    call DrawMaze

    mov [maze_index], 1
    call PrepMazeIndex
    call GenerateMaze
    mov [offset_x], 320
    mov bx, [maze_index]
    and [maze + bx], 1110b
    and [maze + bx + 231], 11100b
    and [maze + bx + 250], 11101b
    call DrawMaze
     
    mov [offset_x], 0
    mov [maze_index], 0

    mov [maze_index], 2
    call PrepMazeIndex
    call GenerateMaze
    mov [offset_y], 192
    mov bx, [maze_index]
    and [maze + bx], 10111b
    and [maze + bx + 19], 0011b
    and [maze + bx + 250], 11011b
    call DrawMaze
    
    mov [offset_y], 0
    mov [maze_index], 0

    mov [maze_index], 3
    call PrepMazeIndex
    call GenerateMaze
    mov [offset_y], 192
    mov [offset_x], 320
    mov bx, [maze_index]
    and [maze + bx], 10110b
    and [maze + bx + 19], 0111b
    and [maze + bx + 231], 1110b
    call DrawMaze

    mov [offset_x], 0
    mov [offset_y], 0
    mov [maze_index], 0

    call PrepMazeIndex
    call GenerateTokens

    xor bx, bx
    push bx
    mov bl, [level]
    add bx, 8
    call RandomXValue
    mov cx, dx
    mov [finish_x_value], dx
    call RandomYValue
    mov [finish_y_value], dx
    mov bx, offset finishKey
    call DrawCharacter
    pop bx

    mov [speed], 25000
    ret
endp ResetMaze3


Start:
    mov ax, @data
    mov ds, ax
		
    mov ax, 0a000h
    mov es, ax  ; ES - Extra Segment now points to the VGA location.
                ; Don't forget to view memory map to recollect that address.
                ; We are now in 320x200x256.

    mov ax, 3h
    int 10h

    lea dx, [opening_message]
    mov ah, 09h
    int 21h

    ; wait for key press
	mov ah, 00h
	int 16h

    call ResetMaze1

MainLoop:
    mov ah,2ch
	int 21h
    cmp dh, [last_time]
    je Run

    mov [last_time], dh
    dec [time]
    inc [total_first_time]
    inc [total_second_time]
        
    call PrintInfo
    call GenerateTokens
    cmp [time], 0
    jne Run

    mov [info_space], 27
    inc [level]
    cmp [level], 4
    je Exit
    
    cmp [level], 2
    jne PrintMaze3
    call ResetMaze2
    jmp Run
    
    PrintMaze3:
        call ResetMaze3

    Run:
        mov cx, [finish_x_value]
        mov dx, [finish_y_value]

        call GetInput
        call MovePlayers
        call CheckCollision

        xor cx, cx
        mov cl, 1
        mov dx, [speed]
	    mov ah, 86h
	    int 15h

        jmp MainLoop

Exit:
    mov ax, 3h
    int 10h

    lea dx, [end_message_one]
    mov ah, 09h 
    int 21h

    xor ax, ax
    mov ax, [total_first_time]
    call Print_Numeric_Var

    lea dx, [end_message_two]
    mov ah, 09h 
    int 21h

    xor ax, ax
    mov ax, [total_second_time]
    call Print_Numeric_Var

    mov cx, [total_first_time]
    cmp cx, [total_second_time]
    je Draw
    cmp cx, [total_second_time]
    jb Player_One_Wins
    jmp Player_Two_Wins

    Draw:
        lea dx, [draw_message]
        mov ah, 09h 
        int 21h
        jmp End_Of_Game
    
    Player_One_Wins:
        lea dx, [player_one_win_message]
        mov ah, 09h 
        int 21h
        jmp End_Of_Game

    Player_Two_Wins:
        lea dx, [player_two_win_message]
        mov ah, 09h 
        int 21h


    End_Of_Game:
        xor ax, ax
        call OpenFile
	    call ReadFile
        call CloseFile

        xor ax, ax
        mov ax, [total_first_time]
        call UpdateBestScore
        xor ax, ax
        mov ax, [total_second_time]
        call UpdateBestScore

        lea dx, [best_score_title]
        mov ah, 09h 
        int 21h

        call OpenFile
        call ReadFile
        call CloseFile
        mov ax, [word best_score_from_file]
        call Print_Numeric_Var

        mov cx, 1000h
        mov dx, 1000h
	    mov ah, 86h
	    int 15h
        mov ax, 4C00h
        int 21h

	END start