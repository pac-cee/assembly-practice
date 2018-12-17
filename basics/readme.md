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

