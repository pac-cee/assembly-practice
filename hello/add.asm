section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "The sum is: %d", 0ah, 0
    format_in db "%d", 0

section .bss
    num1 resd 1    ; Reserve space for first number
    num2 resd 1    ; Reserve space for second number
    sum resd 1     ; Reserve space for the sum

section .text
    default rel
    global main
    extern printf
    extern scanf

main:
    ; Set up stack frame
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32        ; Reserve shadow space

    ; Print first prompt
    lea     rcx, [prompt1] ; Load address of prompt1 into rcx
    call    printf         ; Call printf to display the prompt

    ; Get first number
    lea     rcx, [format_in] ; Load address of format_in into rcx
    lea     rdx, [num1]      ; Load address of num1 into rdx
    call    scanf            ; Call scanf to read the first number

    ; Print second prompt
    lea     rcx, [prompt2] ; Load address of prompt2 into rcx
    call    printf         ; Call printf to display the prompt

    ; Get second number
    lea     rcx, [format_in] ; Load address of format_in into rcx
