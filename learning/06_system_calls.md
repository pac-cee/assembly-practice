# 6. System Calls and I/O in x86-64

## Understanding System Calls

System calls (syscalls) are the interface between user programs and the operating system kernel. They allow programs to request services like file I/O, process management, and memory allocation.

## Syscall Mechanism

### Linux x86-64 Syscall
- Syscall number in RAX
- Arguments in RDI, RSI, RDX, R10, R8, R9
- Use `syscall` instruction
- Return value in RAX

### Windows x64 Syscall
- Different calling convention
- Typically use Windows API instead of direct syscalls
- Arguments in RCX, RDX, R8, R9, then stack
- Use `syscall` instruction (Windows 10+)

## Common Linux System Calls

| Name | RAX | RDI | RSI | RDX | R10 | R8 | R9 |
|------|-----|-----|-----|-----|-----|----|----|
| read | 0 | fd | buf | count | - | - | - |
| write | 1 | fd | buf | count | - | - | - |
| open | 2 | filename | flags | mode | - | - | - |
| close | 3 | fd | - | - | - | - | - |
| exit | 60 | status | - | - | - | - | - |

## File I/O Example (Linux)

```assembly
; File: file_io.asm
; Demonstrates file I/O using system calls (Linux)

section .data
    ; File names and data
    filename db "example.txt", 0
    text db "Hello, File I/O!", 10
    text_len equ $ - text
    
    ; Messages
    success_msg db "File written successfully!", 10
    success_len equ $ - success_msg
    
    error_msg db "Error occurred!", 10
    error_len equ $ - error_msg

section .bss
    fd resq 1    ; File descriptor

section .text
    global _start

_start:
    ; Open file (create if not exists, write-only, truncate)
    mov rax, 2              ; sys_open
    lea rdi, [filename]      ; filename
    mov rsi, 0x241           ; O_WRONLY|O_CREAT|O_TRUNC
    mov rdx, 0o644          ; rw-r--r--
    syscall
    
    ; Check for errors
    cmp rax, 0
    jl error
    mov [fd], rax            ; Save file descriptor
    
    ; Write to file
    mov rax, 1              ; sys_write
    mov rdi, [fd]           ; file descriptor
    lea rsi, [text]         ; buffer
    mov rdx, text_len       ; count
    syscall
    
    ; Check for errors
    cmp rax, 0
    jl error
    
    ; Close file
    mov rax, 3              ; sys_close
    mov rdi, [fd]
    syscall
    
    ; Print success message
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    lea rsi, [success_msg]
    mov rdx, success_len
    syscall
    
    ; Exit successfully
    jmp exit
    
error:
    ; Print error message
    mov rax, 1              ; sys_write
    mov rdi, 2              ; stderr
    lea rsi, [error_msg]
    mov rdx, error_len
    syscall
    
    ; Exit with error
    mov rax, 60             ; sys_exit
    mov rdi, 1              ; status = 1
    syscall

exit:
    ; Exit successfully
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; status = 0
    syscall
```

