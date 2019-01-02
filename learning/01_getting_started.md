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
