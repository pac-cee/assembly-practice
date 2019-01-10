# 3. Memory Access and Data Movement in x86-64

## Understanding Memory Addressing

In x86-64 assembly, memory is accessed using square brackets `[]`. The basic form is:

```assembly
mov rax, [address]    ; Load from memory
mov [address], rax    ; Store to memory
```

## Addressing Modes

### 1. Direct Addressing
```assembly
mov rax, [my_var]    ; Load value at my_var into RAX
```

### 2. Register Indirect
