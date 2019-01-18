# 4. Control Flow in x86-64 Assembly

## Understanding Program Flow

Control flow instructions allow your program to make decisions and create loops. In assembly, this is done using conditional and unconditional jumps.

## Basic Jumps

### 1. Unconditional Jumps
```assembly
jmp label   ; Jump to label
```

### 2. Conditional Jumps
```assembly
je  label   ; Jump if equal (ZF=1)
jne label   ; Jump if not equal (ZF=0)
jg  label   ; Jump if greater (signed)
jl  label   ; Jump if less (signed)
ja  label   ; Jump if above (unsigned)
```

## Comparison Instructions

### CMP (Compare)
```assembly
cmp op1, op2    ; Sets flags based on (op1 - op2)
```

### TEST (Bitwise AND)
```assembly
test op1, op2   ; Sets flags based on (op1 & op2)
```

## Conditional Execution Example

```assembly
; File: compare.asm
; Compares two numbers and prints the larger one

section .data
    a dq 42
    b dq 24
    fmt db "The larger number is: %ld", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    mov rax, [a]
    mov rbx, [b]
    
    cmp rax, rbx
    jg a_is_larger
    
    ; b is larger or equal
    mov rdx, rbx
    jmp print_result
    
a_is_larger:
    mov rdx, rax
    
print_result:
    lea rcx, [fmt]
    call printf
    
    xor eax, eax
    leave
    ret
```

## Loops

### 1. Simple Loop
```assembly
    mov rcx, 10    ; Counter
loop_start:
    ; Loop body
    dec rcx
    jnz loop_start
```

### 2. LOOP Instruction
```assembly
    mov rcx, 10    ; Counter
loop_start:
    ; Loop body
    loop loop_start
```

## Switch-Case Implementation

```assembly
; File: switch.asm
; Implements a simple switch-case structure

section .data
    x dd 2          ; Input value
    
    ; Jump table
    jumptable:
        dq case0, case1, case2, case_default
    
    ; Messages
    msg0 db "Case 0", 10, 0
    msg1 db "Case 1", 10, 0
    msg2 db "Case 2", 10, 0
    msg_default db "Default case", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    mov eax, [x]    ; Get the value to switch on
    
    ; Bounds check
    cmp eax, 2
    ja default_case
    
    ; Jump to the appropriate case
    lea rbx, [rel jumptable]
    jmp [rbx + rax*8]
    
case0:
    lea rcx, [rel msg0]
    jmp print_msg
    
case1:
    lea rcx, [rel msg1]
    jmp print_msg
    
case2:
    lea rcx, [rel msg2]
    jmp print_msg
    
default_case:
    lea rcx, [rel msg_default]
    
print_msg:
    call printf
    
    xor eax, eax
    leave
    ret
