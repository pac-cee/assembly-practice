# Comprehensive Assembly Programming Guide (NASM on Windows)

## Table of Contents
1. [What is Assembly Language?](#what-is-assembly-language)
2. [NASM Basics and Setup](#nasm-basics-and-setup)
3. [Program Structure](#program-structure)
4. [Registers](#registers)
5. [Memory Management](#memory-management)
6. [Data Types and Storage](#data-types-and-storage)
7. [Instructions and Opcodes](#instructions-and-opcodes)
8. [Addressing Modes](#addressing-modes)
9. [Control Flow](#control-flow)
10. [Arithmetic Operations](#arithmetic-operations)
11. [Logical Operations](#logical-operations)
12. [String Operations](#string-operations)
13. [System Calls and C Library Functions](#system-calls-and-c-library-functions)
14. [Stack Management](#stack-management)
15. [Advanced Topics](#advanced-topics)
16. [Debugging and Best Practices](#debugging-and-best-practices)
17. [Common Patterns and Examples](#common-patterns-and-examples)

---

## What is Assembly Language?

Assembly language is a low-level programming language that provides direct control over the computer's hardware. Each assembly instruction typically corresponds to one machine code instruction that the processor executes.

**Why learn Assembly?**
- Understanding how computers work at the lowest level
- Performance optimization
- System programming
- Reverse engineering
- Embedded systems programming
- Better understanding of higher-level languages

---

## NASM Basics and Setup

### Installation (Windows)
```bash
# You already have NASM installed since you're using it
# To check version:
nasm -v
```

### Basic Compilation Process
```bash
# 1. Assemble (.asm → .obj)
nasm -f win64 filename.asm

# 2. Link (.obj → .exe)
# Using Microsoft's linker:
link filename.obj /subsystem:console /entry:main /defaultlib:kernel32.lib /defaultlib:msvcrt.lib

# Or using GCC linker:
gcc filename.obj -o filename.exe
```

---

## Program Structure

### Basic NASM Program Structure
```assembly
section .data
    ; Initialized data goes here
    message db 'Hello World', 0
    number dd 42

section .bss
    ; Uninitialized data goes here
    buffer resb 100    ; Reserve 100 bytes
    counter resd 1     ; Reserve 1 dword (4 bytes)

section .text
    default rel        ; Use relative addressing (Windows 64-bit)
    global main        ; Entry point for C runtime
    extern printf      ; External C library function

main:
    ; Your code goes here
    ; Function prologue
    push rbp
    mov rbp, rsp
    sub rsp, 32        ; Shadow space for Windows x64 calling convention
    
    ; Your actual code
    
    ; Function epilogue and return
    xor eax, eax       ; Return 0
    leave              ; Equivalent to: mov rsp, rbp; pop rbp
    ret
```

### Section Types
- **`.data`**: Initialized data (read-write)
- **`.rodata`**: Read-only data (constants)
- **`.bss`**: Uninitialized data (filled with zeros)
- **`.text`**: Executable code

---

## Registers

### x86-64 General Purpose Registers

#### 64-bit Registers (R prefix)
```
RAX, RBX, RCX, RDX    ; Primary registers
RSI, RDI              ; Source/Destination index
RSP, RBP              ; Stack/Base pointer
R8, R9, R10, R11      ; Additional registers
R12, R13, R14, R15    ; Additional registers
```

#### 32-bit Registers (E prefix)
```
EAX, EBX, ECX, EDX    ; Lower 32 bits of RAX, RBX, RCX, RDX
ESI, EDI, ESP, EBP    ; Lower 32 bits of RSI, RDI, RSP, RBP
R8D, R9D, R10D, R11D  ; Lower 32 bits of R8-R11
R12D, R13D, R14D, R15D ; Lower 32 bits of R12-R15
```

#### 16-bit Registers
```
AX, BX, CX, DX        ; Lower 16 bits
SI, DI, SP, BP        ; Lower 16 bits
R8W, R9W, R10W, R11W  ; Lower 16 bits of R8-R11
```

#### 8-bit Registers
```
AL, AH, BL, BH, CL, CH, DL, DH  ; Low/High bytes of AX, BX, CX, DX
SIL, DIL, SPL, BPL              ; Low bytes of SI, DI, SP, BP
R8B, R9B, R10B, R11B            ; Low bytes of R8-R11
```

### Special Purpose Registers
- **RIP**: Instruction Pointer (Program Counter)
- **RFLAGS**: Status flags register
- **Segment Registers**: CS, DS, ES, FS, GS, SS

### Register Usage Convention (Windows x64)
- **RAX**: Return value, accumulator
- **RCX**: First argument
- **RDX**: Second argument
- **R8**: Third argument
- **R9**: Fourth argument
- **RSP**: Stack pointer (never use directly for data)
- **RBP**: Base pointer (frame pointer)
- **RBX, RSI, RDI, R12-R15**: Callee-saved (preserve across function calls)

---

## Memory Management

### Memory Hierarchy
1. **Registers** (fastest, smallest)
2. **Cache** (L1, L2, L3)
3. **RAM** (main memory)
4. **Storage** (slowest, largest)

### Memory Layout (Windows)
```
High Addresses
+------------------+
|      Stack       | ← RSP points here
|        ↓         |
|                  |
|        ↑         |
|       Heap       |
+------------------+
|   .bss section   | (uninitialized data)
+------------------+
|   .data section  | (initialized data)
+------------------+
|   .text section  | (code)
+------------------+
Low Addresses
```

### Memory Sizes
- **Byte**: 8 bits (1 byte)
- **Word**: 16 bits (2 bytes)
- **Dword**: 32 bits (4 bytes) - "Double Word"
- **Qword**: 64 bits (8 bytes) - "Quad Word"

---

## Data Types and Storage

### Data Declaration Directives
```assembly
section .data
    ; Initialized data
    char_val    db 'A'           ; Define byte (8-bit)
    string_val  db 'Hello', 0    ; Null-terminated string
    word_val    dw 1234          ; Define word (16-bit)
    dword_val   dd 12345678      ; Define dword (32-bit)
    qword_val   dq 123456789012  ; Define qword (64-bit)
    float_val   dd 3.14159       ; 32-bit float
    double_val  dq 2.71828       ; 64-bit double
    
    ; Arrays
    byte_array  db 1, 2, 3, 4, 5
    word_array  dw 100, 200, 300
    
    ; Multiple of same value
    zeros       times 100 db 0   ; 100 zero bytes

section .bss
    ; Uninitialized data (reserves space)
    buffer      resb 256         ; Reserve 256 bytes
    int_var     resd 1           ; Reserve 1 dword
    long_var    resq 1           ; Reserve 1 qword
    array       resd 10          ; Reserve space for 10 dwords
```

### Constants and Equates
```assembly
; Define constants
BUFFER_SIZE equ 1024
MAX_COUNT   equ 100

; Use in code
mov eax, BUFFER_SIZE
```

---

## Instructions and Opcodes

### Data Movement Instructions
```assembly
; MOV - Move data
mov rax, rbx        ; Copy rbx to rax
mov eax, 42         ; Load immediate value
mov rax, [rbx]      ; Load from memory address in rbx
mov [rax], rbx      ; Store rbx to memory address in rax

; LEA - Load Effective Address
lea rax, [rbx + 8]  ; Load address (rbx + 8) into rax

; MOVSX/MOVZX - Move with sign/zero extension
movsx rax, bl       ; Sign-extend byte to qword
movzx eax, bl       ; Zero-extend byte to dword

; XCHG - Exchange
xchg rax, rbx       ; Swap contents of rax and rbx
```

### Stack Operations
```assembly
push rax            ; Push rax onto stack (RSP -= 8)
pop rbx             ; Pop from stack into rbx (RSP += 8)
pushf               ; Push flags register
popf                ; Pop flags register
```

---

## Addressing Modes

### Immediate Addressing
```assembly
mov eax, 42         ; Load immediate value 42
```

### Register Addressing
```assembly
mov eax, ebx        ; Copy register to register
```

### Direct Memory Addressing
```assembly
mov eax, [variable] ; Load from memory variable
mov [variable], eax ; Store to memory variable
```

### Indirect Addressing
```assembly
mov eax, [rbx]      ; Load from address stored in rbx
mov [rax], ebx      ; Store to address stored in rax
```

### Indexed Addressing
```assembly
mov eax, [rbx + 4]           ; Base + displacement
mov eax, [rbx + rsi]         ; Base + index
mov eax, [rbx + rsi * 2]     ; Base + (index * scale)
mov eax, [rbx + rsi * 4 + 8] ; Base + (index * scale) + displacement
```

### Scale Factors
Valid scale factors: 1, 2, 4, 8 (for byte, word, dword, qword)

---

## Control Flow

### Unconditional Jumps
```assembly
jmp label           ; Jump to label
jmp rax             ; Jump to address in rax
jmp [rax]           ; Jump to address stored at address in rax
```

### Conditional Jumps (after CMP instruction)
```assembly
cmp eax, ebx        ; Compare eax with ebx
je equal            ; Jump if equal (ZF = 1)
jne not_equal       ; Jump if not equal (ZF = 0)
jg greater          ; Jump if greater (signed)
jl less             ; Jump if less (signed)
jge greater_equal   ; Jump if greater or equal (signed)
jle less_equal      ; Jump if less or equal (signed)
ja above            ; Jump if above (unsigned)
jb below            ; Jump if below (unsigned)
jae above_equal     ; Jump if above or equal (unsigned)
jbe below_equal     ; Jump if below or equal (unsigned)

; Other condition jumps
jz zero             ; Jump if zero (same as je)
jnz not_zero        ; Jump if not zero (same as jne)
jc carry            ; Jump if carry flag set
jnc no_carry        ; Jump if carry flag clear
js sign             ; Jump if sign flag set (negative)
jns no_sign         ; Jump if sign flag clear (positive)
jo overflow         ; Jump if overflow flag set
jno no_overflow     ; Jump if overflow flag clear
```

### Loops
```assembly
; LOOP instruction (uses RCX as counter)
mov rcx, 10
loop_start:
    ; Loop body
    loop loop_start     ; Decrement RCX, jump if RCX != 0

; Manual loop
mov eax, 0
mov ebx, 10
manual_loop:
    ; Loop body
    inc eax
    cmp eax, ebx
    jl manual_loop
```

### Function Calls
```assembly
call function_name  ; Call function (pushes return address)
ret                 ; Return from function (pops return address)
ret 16              ; Return and clean up 16 bytes from stack
```

---

## Arithmetic Operations

### Addition and Subtraction
```assembly
add eax, ebx        ; eax = eax + ebx
add eax, 10         ; eax = eax + 10
sub eax, ebx        ; eax = eax - ebx
inc eax             ; eax = eax + 1 (faster than add eax, 1)
dec eax             ; eax = eax - 1 (faster than sub eax, 1)

; With carry
adc eax, ebx        ; eax = eax + ebx + carry_flag
sbb eax, ebx        ; eax = eax - ebx - carry_flag
```

### Multiplication
```assembly
; Unsigned multiplication
mul ebx             ; EDX:EAX = EAX * EBX (64-bit result)
imul ebx            ; EAX = EAX * EBX (32-bit result, signed)
imul eax, ebx       ; EAX = EAX * EBX (two operand form)
imul eax, ebx, 10   ; EAX = EBX * 10 (three operand form)

; Examples:
mov eax, 5
mov ebx, 3
imul eax, ebx       ; EAX = 15
```

### Division
```assembly
; Unsigned division
mov eax, 15         ; Dividend low
mov edx, 0          ; Dividend high (must be 0 for 32-bit)
mov ebx, 3          ; Divisor
div ebx             ; EAX = quotient, EDX = remainder

; Signed division
mov eax, -15
cdq                 ; Sign-extend EAX into EDX
mov ebx, 3
idiv ebx            ; EAX = quotient, EDX = remainder
```

**IMPORTANT**: Always clear/set EDX before division!

---

## Logical Operations

### Bitwise Operations
```assembly
and eax, ebx        ; Bitwise AND
or eax, ebx         ; Bitwise OR
xor eax, ebx        ; Bitwise XOR
not eax             ; Bitwise NOT (one's complement)

; Common uses:
xor eax, eax        ; Clear register (eax = 0)
and eax, 0x0F       ; Mask lower 4 bits
or eax, 0x80        ; Set bit 7
```

### Bit Shifting
```assembly
shl eax, 1          ; Shift left (multiply by 2)
shr eax, 1          ; Shift right (unsigned divide by 2)
sar eax, 1          ; Shift arithmetic right (signed divide by 2)
rol eax, 1          ; Rotate left
ror eax, 1          ; Rotate right

; Shift by register
mov cl, 3
shl eax, cl         ; Shift left by 3 (multiply by 8)
```

### Bit Testing
```assembly
test eax, eax       ; Test if eax is zero (sets flags)
test eax, 0x01      ; Test if bit 0 is set
bt eax, 5           ; Test bit 5 (sets carry flag)
bts eax, 5          ; Test and set bit 5
btr eax, 5          ; Test and reset bit 5
btc eax, 5          ; Test and complement bit 5
```

---

## String Operations

String operations work with RSI (source) and RDI (destination) registers.

```assembly
; Direction flag
cld                 ; Clear direction flag (forward)
std                 ; Set direction flag (backward)

; String move
movsb               ; Move byte from [RSI] to [RDI]
movsw               ; Move word
movsd               ; Move dword
movsq               ; Move qword

; With repeat prefix
rep movsb           ; Repeat RCX times

; String compare
cmpsb               ; Compare bytes at [RSI] and [RDI]
repe cmpsb          ; Repeat while equal
repne cmpsb         ; Repeat while not equal

; String scan
scasb               ; Compare AL with [RDI]
repne scasb         ; Find character in string

