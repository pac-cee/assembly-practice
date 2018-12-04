section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter operation (+, -, *, /): ", 0
    prompt3 db "Enter second number: ", 0
    result_msg db "Result: %d", 0ah, 0
    format_in_num db "%d", 0
    format_in_op db " %c", 0

section .bss
    num1 resd 1
    num2 resd 1
    operator resb 1

section .text
    default rel
    global main
    extern printf
    extern scanf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    ; Get first number
    lea     rcx, [prompt1]
    call    printf
    
    lea     rcx, [format_in_num]
    lea     rdx, [num1]
    call    scanf

    ; Get operator
    lea     rcx, [prompt2]
    call    printf
    
    lea     rcx, [format_in_op]
    lea     rdx, [operator]
    call    scanf

    ; Get second number
    lea     rcx, [prompt3]
    call    printf
    
    lea     rcx, [format_in_num]
    lea     rdx, [num2]
    call    scanf

    ; Perform calculation
    mov     eax, [num1]
    mov     ebx, [num2]
    movzx   ecx, byte [operator]

    cmp     cl, '+'
    je      add_nums
    cmp     cl, '-'
    je      sub_nums
