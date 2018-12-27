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
