section .data
    prompt_size db "Enter array size (max 10): ", 0
    prompt_num db "Enter number %d: ", 0
    sum_msg db "Sum: %d", 0ah, 0
    avg_msg db "Average: %d", 0ah, 0
    max_msg db "Maximum: %d", 0ah, 0
    format_in db "%d", 0
    array_max equ 10

section .bss
    array resd array_max
    size resd 1

section .text
    default rel
    global main
    extern printf
    extern scanf

