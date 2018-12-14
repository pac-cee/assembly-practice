section .data
    format db "5 x %2d = %2d", 0ah, 0
    
section .text
    default rel
    global main
    extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32            ; Shadow space
    
    mov     r12d, 1           ; Counter (1 to 10)
    
print_loop:
    ; Calculate 5 * counter
    mov     eax, 5
    imul    eax, r12d
