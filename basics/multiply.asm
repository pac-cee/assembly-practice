section .data
    prompt  db "Enter a number for multiplication table: ", 0
    format  db "%d x %2d = %2d", 0ah, 0
    scanfmt db "%d", 0
    
section .bss
    number resd 1     ; Reserve space for user's number

section .text
    default rel
    global main
    extern printf
    extern scanf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32            ; Shadow space

