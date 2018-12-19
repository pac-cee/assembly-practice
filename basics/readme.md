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
