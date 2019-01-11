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

## Data Movement Instructions

### 1. Basic Move
```assembly
mov dest, src    ; Copy src to dest
```

### 2. Load Effective Address (LEA)
```assembly
lea rdi, [rsi + rdx*4 + 10]  ; Calculate address without memory access
```

### 3. Exchange
```assembly
xchg rax, rbx  ; Swap RAX and RBX
```

## Example: Working with Arrays

```assembly
; File: arrays.asm
; Demonstrates array access and string operations

section .data
    numbers dq 10, 20, 30, 40, 50  ; Array of quad-words
    len     equ ($ - numbers) / 8   ; Length of array
    
    str1    db "Hello, ", 0
    str2    db "Assembly!", 0
    result  times 32 db 0           ; Buffer for concatenated string

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    ; Example 1: Sum elements in array
    mov rcx, len            ; Counter
    xor rax, rax            ; Sum = 0
    lea rsi, [numbers]      ; Pointer to array
    
sum_loop:
    add rax, [rsi]         ; Add current element to sum
    add rsi, 8              ; Move to next element (8 bytes)
    loop sum_loop           ; Decrement RCX and loop if not zero
    
    ; Now RAX contains the sum
    
    ; Example 2: String concatenation
    lea rdi, [result]       ; Destination buffer
    lea rsi, [str1]         ; First string
    call str_copy           ; Copy first string
    
    lea rsi, [str2]         ; Second string
    call str_copy           ; Concatenate second string
    
    ; Print result
    lea rcx, [result]
    call printf
    
    ; Exit
    xor eax, eax
    leave
    ret

; String copy function
; RDI: destination
; RSI: source
str_copy:
    push rcx
    push rdi
    push rsi
    
    ; Find end of destination string
    mov rcx, -1
    xor al, al
    cld
    repne scasb
    dec rdi                 ; Back up over null terminator
    
    ; Copy source to destination
    mov rcx, -1
    rep movsb               ; Copy until null terminator
    
    pop rsi
    pop rdi
    pop rcx
    ret
```

## Data Types and Sizes
