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
```assembly
mov rsi, my_array    ; RSI points to the start of array
mov rax, [rsi]      ; Load first element
```

### 3. Base + Displacement
```assembly
mov rax, [rsi + 8]   ; Load from address RSI + 8
```

### 4. Indexed Addressing
```assembly
mov rax, [rsi + rdi]  ; RAX = *(RSI + RDI)
```

### 5. Scaled Indexed
```assembly
mov rax, [rsi + rdi*8]  ; RAX = *(RSI + RDI*8) - useful for arrays
```
