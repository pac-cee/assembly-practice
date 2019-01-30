# 8. Macros and Conditional Assembly in NASM

## Introduction to Macros

Macros in NASM allow you to define reusable code blocks that are expanded during assembly. They help reduce code duplication and improve readability.

### Basic Macro Definition

```assembly
%macro mymacro 2    ; Macro with 2 parameters
    mov eax, %1     ; First parameter
    add eax, %2     ; Second parameter
%endmacro

; Usage
mymacro 10, 20      ; Expands to: mov eax, 10; add eax, 20
```

### Multi-line Macros

```assembly
%macro print_string 2
    push rdi
    push rsi
    push rax
    
    mov rdi, %1    ; String address
    mov rsi, %2    ; Length
    mov rax, 0x2000004  ; sys_write
    mov rdi, 1          ; stdout
    syscall
    
    pop rax
    pop rsi
    pop rdi
%endmacro
```

