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
