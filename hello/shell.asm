; Minimal shell in NASM (Linux x86 32-bit)
; Save as shell.asm, assemble with: nasm -f elf32 shell.asm && ld -m elf_i386 -o shell shell.o

section .data
    prompt      db  '$ ', 0
    prompt_len  equ $-prompt
    buffer      times 128 db 0

section .bss
    input resb 128

section .text
    global _start

_start:
main_loop:
    ; Print prompt
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
