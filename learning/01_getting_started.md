# 1. Getting Started with x86-64 Assembly

## What is Assembly Language?

Assembly language is a low-level programming language that has a strong correspondence with the machine code instructions of a specific computer architecture. Unlike high-level languages, assembly is much closer to the hardware.

## Basic Structure of an Assembly Program

Here's a simple "Hello, World!" program in x86-64 assembly for Windows:

```assembly
; File: hello.asm
; Description: A simple "Hello, World!" program in x86-64 assembly
; Build: nasm -f win64 hello.asm -o hello.obj
; Link: gcc hello.obj -o hello.exe

section .data
    message db 'Hello, World!', 0   ; Define null-terminated string
    message_length equ $ - message   ; Calculate string length

section .text
    global main
    extern WriteFile
    extern GetStdHandle
    
    ; Windows constants
    STD_OUTPUT_HANDLE equ -11

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32                     ; Shadow space
    
    ; Get standard output handle
    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle
    
    ; Write to console
    mov rcx, rax                    ; Handle
    lea rdx, [message]              ; Buffer
    mov r8d, message_length         ; Length
    lea r9, [rsp + 40]              ; lpNumberOfBytesWritten
    mov qword [rsp + 32], 0         ; lpOverlapped (NULL)
    call WriteFile
    
    ; Exit
    xor eax, eax
    leave
    ret
```

## Key Concepts

### 1. Sections
- `.data`: Contains initialized data
- `.bss`: Contains uninitialized data
- `.text`: Contains executable code

### 2. Registers
x86-64 has 16 general-purpose 64-bit registers:
- `RAX`, `RBX`, `RCX`, `RDX`: General purpose
- `RSI`, `RDI`: Source/Destination index
- `RBP`: Base pointer
- `RSP`: Stack pointer
- `R8`-`R15`: Additional general purpose registers

### 3. Instructions
Basic instruction format:
```
operation destination, source
```

Common instructions:
- `mov`: Move data
- `add`/`sub`: Arithmetic
- `push`/`pop`: Stack operations
