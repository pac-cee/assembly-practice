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
