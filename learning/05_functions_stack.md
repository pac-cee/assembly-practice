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
