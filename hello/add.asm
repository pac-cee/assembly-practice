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
