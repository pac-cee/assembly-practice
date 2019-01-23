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
