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

    ; Get choice
    lea     rcx, [format_in]
    lea     rdx, [choice]
    call    scanf

    ; Switch-like structure using comparisons
    mov     eax, [choice]
    
    cmp     eax, 1
    je      do_counting
    
    cmp     eax, 2
    je      do_factorial
    
    cmp     eax, 3
    je      do_prime_check
    
    cmp     eax, 4
    je      do_fibonacci
    
    cmp     eax, 5
    je      program_exit
    
    jmp     menu_loop     ; Invalid choice, show menu again

do_counting:
    ; Get N
    lea     rcx, [prompt_n]
    call    printf
    
    lea     rcx, [format_in]
    lea     rdx, [number]
    call    scanf

    ; While loop to count from 1 to N
    mov     r12d, 1           ; Counter = 1
count_loop:
