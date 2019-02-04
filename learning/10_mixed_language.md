# 10. Mixed-Language Programming: Assembly and C

## Calling Conventions

### System V AMD64 ABI (Linux/macOS)
- Integer args: RDI, RSI, RDX, RCX, R8, R9
- Floating-point: XMM0-XMM7
- Return: RAX (and RDX for 128-bit)
- Stack alignment: 16-byte before call

### Microsoft x64 (Windows)
- Integer args: RCX, RDX, R8, R9
- Floating-point: XMM0-XMM3
- Return: RAX (XMM0 for floating-point)
- Caller must allocate 32-byte shadow space

## Calling C from Assembly

### Example: Calling printf

```assembly
; File: call_printf.asm
extern printf

data_section:
    format db "The result is: %d", 10, 0
    number dq 42

text_section:
    global main

main:
    push rbp
    mov rbp, rsp
    
    ; Call printf("The result is: %d\n", number)
    lea rdi, [format]    ; Format string
    mov rsi, [number]     ; First argument
