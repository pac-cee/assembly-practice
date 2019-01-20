# 5. Functions and the Stack in x86-64

## Understanding the Stack

The stack is a Last-In-First-Out (LIFO) data structure that grows downward in memory. Key registers:
- `RSP`: Stack Pointer (points to the top of the stack)
- `RBP`: Base Pointer (points to the base of the current stack frame)

## Stack Operations

### Basic Stack Instructions
```assembly
push rax    ; Equivalent to: sub rsp, 8; mov [rsp], rax
pop rax     ; Equivalent to: mov rax, [rsp]; add rsp, 8
```

### Function Prologue and Epilogue
```assembly
my_function:
    ; Prologue
    push rbp            ; Save old base pointer
    mov rbp, rsp        ; Set new base pointer
    sub rsp, N          ; Allocate space for local variables
    
    ; Function body
    
    ; Epilogue
    mov rsp, rbp        ; Deallocate locals
    pop rbp             ; Restore old base pointer
    ret                 ; Return to caller
```

## Calling Conventions

### Windows x64 Calling Convention
- First 4 integer/pointer args: RCX, RDX, R8, R9
- First 4 floating-point args: XMM0, XMM1, XMM2, XMM3
- Additional args: Right to left on the stack
- Caller must allocate 32 bytes of "shadow space"
- RAX, RCX, RDX, R8, R9, R10, R11 are volatile
- RBX, RBP, RDI, RSI, R12-R15 are non-volatile

### System V AMD64 ABI (Linux/macOS)
- First 6 integer/pointer args: RDI, RSI, RDX, RCX, R8, R9
- First 8 floating-point args: XMM0-XMM7
- Additional args: Right to left on the stack
- No shadow space required
- RAX, RCX, RDX, RSI, RDI, R8-R11 are volatile
- RBX, RBP, R12-R15 are non-volatile

## Function Example

```assembly
; File: functions.asm
; Demonstrates function calls and stack usage

section .data
    msg db "Result: %d", 10, 0

section .text
    global main
    extern printf

; int add(int a, int b)
; Input: a = RCX, b = RDX (Windows)
;        a = RDI, b = RSI (System V)
; Output: RAX = a + b
add_numbers:
    push rbp
    mov rbp, rsp
    
    ; Windows: a=RCX, b=RDX
    ; System V: a=RDI, b=RSI
    
    ; For Windows, move to System V registers
    %ifidn __OUTPUT_FORMAT__, win64
    mov rdi, rcx
    mov rsi, rdx
    %endif
    
    ; Add the numbers
    mov rax, rdi
    add rax, rsi
    
    leave
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32        ; Shadow space (Windows) or alignment (System V)
    
    ; Call add_numbers(5, 3)
    %ifidn __OUTPUT_FORMAT__, win64
    mov rcx, 5         ; First argument
