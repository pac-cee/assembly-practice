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

