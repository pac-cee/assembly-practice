# 7. Advanced x86-64 Assembly Topics

## SIMD (Single Instruction, Multiple Data)

### SSE/AVX Registers
- XMM0-XMM15 (128-bit)
- YMM0-YMM15 (256-bit with AVX)
- ZMM0-ZMM31 (512-bit with AVX-512)

### Common SIMD Instructions
```assembly
; Packed single-precision floating-point operations
addps xmm0, xmm1       ; Packed add
subps xmm0, xmm1       ; Packed subtract
mulps xmm0, xmm1       ; Packed multiply
divps xmm0, xmm1       ; Packed divide

; Data movement
movaps xmm0, [mem]     ; Aligned move
movups xmm0, [mem]     ; Unaligned move

; Shuffling and blending
shufps xmm0, xmm1, imm8  ; Shuffle packed singles
blendvps xmm0, xmm1, xmm2 ; Blend packed singles

; AVX instructions (VEX-encoded)
vmulps ymm0, ymm1, ymm2  ; 256-bit packed multiply
vfmadd132ps ymm0, ymm1, ymm2 ; Fused multiply-add
```

## Inline Assembly in C

### Basic Syntax
```c
#include <stdio.h>

int main() {
    int a = 10, b = 20, result;
    
    __asm__ volatile (
        "addl %%ebx, %%eax"  // Assembly template
        : "=a" (result)       // Output operands
        : "a" (a), "b" (b)    // Input operands
        :                     // Clobbered registers
    );
    
    printf("Result: %d\n", result);
    return 0;
}
```

### Extended Asm with Memory Operands
```c
void memcpy_asm(void *dest, const void *src, size_t n) {
    __asm__ volatile (
        "rep movsb"
        : "+D" (dest), "+S" (src), "+c" (n)
        : 
        : "memory"
    );
}
```

## Performance Optimization

### 1. Loop Unrolling
```assembly
; Before unrolling
mov rcx, 1000
loop_start:
    ; Loop body
    dec rcx
    jnz loop_start

; After unrolling by 4
mov rcx, 250  ; 1000 / 4
loop_start:
    ; Loop body (x4)
    ; ...
    dec rcx
    jnz loop_start
```

### 2. Data Alignment
```assembly
section .data
    align 16         ; Align to 16-byte boundary
    my_data dd 1.0, 2.0, 3.0, 4.0

section .text
    movaps xmm0, [my_data]  ; Requires 16-byte alignment
```

### 3. Avoiding Pipeline Stalls
```assembly
; Bad - RAW (Read After Write) hazard
mov eax, [mem1]
add eax, [mem2]  ; Stall - waiting for previous mov to complete

; Better - Interleave independent operations
mov eax, [mem1]
mov ebx, [mem3]  ; Independent operation
add eax, [mem2]
add ebx, [mem4]  ; Independent operation
```

## Interfacing with C

### Calling Conventions
- **Linux/macOS**: System V AMD64 ABI
  - Integer args: RDI, RSI, RDX, RCX, R8, R9
  - Floating-point: XMM0-XMM7
  - Return: RAX (and RDX for 128-bit)

- **Windows x64**
  - Integer args: RCX, RDX, R8, R9
  - Floating-point: XMM0-XMM3
  - Return: RAX (and XMM0 for floating-point)

### Example: Calling C from Assembly

```assembly
; File: call_c.asm
; Demonstrates calling C functions from assembly

extern printf

data_section:
    fmt db "The result is: %d", 10, 0
    number dq 42

text_section:
    global main
