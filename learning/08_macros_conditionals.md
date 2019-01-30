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

## Advanced Macro Features

### Default Parameters

```assembly
%macro mymacro 1-3 10, 20  ; 1 required, 2 optional parameters
    mov eax, %1
    add eax, %2
    add eax, %3
%endmacro

mymacro 5        ; Uses 5, 10, 20
mymacro 1, 2, 3   ; Uses 1, 2, 3
```

### Variable Number of Parameters

```assembly
%macro varmacro 1-*  ; 1+ parameters
    %rep %0          ; Number of parameters
        push %1       ; Push each parameter
        %rotate 1     ; Move to next parameter
    %endrep
%endmacro
```

## Conditional Assembly

### %ifdef, %ifndef, %else, %endif

```assembly
%define DEBUG 1

%ifdef DEBUG
    %define LOG(msg) write_log msg
    %macro write_log 1
        ; Implementation for debug logging
    %endmacro
