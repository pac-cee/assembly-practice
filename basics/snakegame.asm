section .data
    ; Screen dimensions
    SCREEN_WIDTH    equ 80
    SCREEN_HEIGHT   equ 25
    
    ; Characters for drawing
    SNAKE_CHAR      db "*"
    FOOD_CHAR       db "+"
    EMPTY_CHAR      db " "
    
    ; Game states
    RUNNING         equ 0
    GAMEOVER        equ 1
    
    ; Direction values
    UP              equ 0
    RIGHT           equ 1
    DOWN            equ 2
    LEFT            equ 3
    
    ; Messages
    game_over_msg   db "Game Over! Score: %d", 10, 0
    score_msg       db "Score: %d", 0
    clear_screen    db 27,"[2J",27,"[H",0  ; ANSI escape codes

section .bss
    ; Game state
    game_state      resd 1
    score           resd 1
    direction       resd 1
    
    ; Snake data
    snake_x         resd 100  ; X coordinates of snake segments
    snake_y         resd 100  ; Y coordinates of snake segments
    snake_length    resd 1
    
    ; Food position
    food_x          resd 1
    food_y          resd 1
    
    ; Screen buffer
    screen_buffer   resb SCREEN_WIDTH * SCREEN_HEIGHT

section .text
    default rel
    global main
    extern printf
    extern _kbhit
    extern _getch
    extern Sleep
    extern time
    extern srand
    extern rand

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    call    initialize_game
    call    game_loop
    
    xor     eax, eax
    leave
    ret

initialize_game:
    ; Initialize random seed
    xor     rcx, rcx
    call    time
    mov     rcx, rax
    call    srand
    
    ; Set initial game state
    mov     dword [game_state], RUNNING
    mov     dword [score], 0
