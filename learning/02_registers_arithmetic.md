# 2. Registers and Basic Arithmetic in x86-64

## Understanding Registers

Registers are small storage locations directly on the CPU. In x86-64, we have:

### General-Purpose Registers (64-bit)
```
RAX, RBX, RCX, RDX, RSI, RDI, RBP, RSP, R8-R15
```

### 32-bit, 16-bit, and 8-bit Views
```
64-bit      32-bit    16-bit   8-bit (high)  8-bit (low)
--------------------------------------------------------
RAX         EAX       AX       AH            AL
RBX         EBX       BX       BH            BL
RCX         ECX       CX       CH            CL
RDX         EDX       DX       DH            DL
RSI         ESI       SI       -             SIL
RDI         EDI       DI       -             DIL
RBP         EBP       BP       -             BPL
RSP         ESP       SP       -             SPL
R8          R8D       R8W      -             R8B
...         ...       ...      ...           ...
R15         R15D      R15W     -             R15B
```

## Basic Arithmetic Instructions

### 1. Addition and Subtraction
```assembly
add  dest, src     ; dest = dest + src
sub  dest, src     ; dest = dest - src
inc  dest          ; dest = dest + 1
dec  dest          ; dest = dest - 1
neg  dest          ; dest = -dest (two's complement)
```

### 2. Multiplication and Division
```assembly
; Signed multiplication
imul dest, src     ; dest = dest * src (signed)

; Unsigned multiplication
mul  src           ; RAX = RAX * src (unsigned)

; Division
idiv divisor       ; Signed division: RDX:RAX / divisor → RAX (quotient), RDX (remainder)
div  divisor       ; Unsigned division
```

## Example: Simple Calculator

```assembly
; File: calculator.asm
; A simple calculator that adds, subtracts, multiplies, and divides

section .data
    num1    dq 30
    num2    dq 7
    result  dq 0
    
    ; Format strings for printf
    fmt_add db "%ld + %ld = %ld", 10, 0
    fmt_sub db "%ld - %ld = %ld", 10, 0
    fmt_mul db "%ld * %ld = %ld", 10, 0
    fmt_div db "%ld / %ld = %ld, remainder %ld", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
