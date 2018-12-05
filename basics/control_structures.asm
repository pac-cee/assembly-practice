section .data
    ; Menu strings
    menu db 10, "Choose an operation:", 10
         db "1. Count from 1 to N", 10
         db "2. Find factorial of N", 10
         db "3. Check if number is prime", 10
         db "4. Print first N Fibonacci numbers", 10
         db "5. Exit", 10
         db "Enter choice (1-5): ", 0
    
    prompt_n db "Enter N: ", 0
    format_in db "%d", 0
    format_out db "%d ", 0
    newline db 10, 0
    result_msg db "Result: %d", 10, 0
    prime_yes db "Number is prime!", 10, 0
    prime_no db "Number is not prime.", 10, 0

section .bss
    choice resd 1    ; User's menu choice
    number resd 1    ; Input number N
    temp resd 1      ; Temporary storage

section .text
    default rel
    global main
    extern printf
    extern scanf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32        ; Shadow space

menu_loop:
    ; Display menu
    lea     rcx, [menu]
    call    printf
