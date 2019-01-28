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
