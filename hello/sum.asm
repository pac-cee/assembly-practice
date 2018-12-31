section .data
    prompt_count db "How many numbers do you want to add? ", 0
    prompt_num db "Enter number %d: ", 0
    result_msg db "Sum is: %d", 0ah, 0
    format_in db "%d", 0

section .bss
    count resd 1    ; Space for count of numbers
    number resd 1   ; Space for each input number
    sum resd 1      ; Space for running sum

section .text
    default rel
    global main
    extern printf
    extern scanf

main:
    push    rbp
