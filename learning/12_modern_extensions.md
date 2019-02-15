# 12. Modern x86 Extensions

## AVX and AVX2 (Advanced Vector Extensions)

### AVX Overview
- 256-bit vector registers (YMM0-YMM15)
- Three-operand non-destructive operations
- New VEX encoding scheme
- Floating-point operations on 256-bit vectors

### Basic AVX Operations
```assembly
; Load 8 single-precision floats
vmovaps ymm0, [rdi]     ; Aligned packed single
vmovups ymm1, [rsi]     ; Unaligned packed single

; Arithmetic operations
vaddps ymm2, ymm0, ymm1  ; Packed single add
vmulps ymm3, ymm0, ymm1  ; Packed single multiply
vsqrtps ymm4, ymm0       ; Packed square root

; Horizontal operations
vhaddps ymm5, ymm0, ymm1  ; Horizontal add

; Fused multiply-add
vfmadd132ps ymm0, ymm1, ymm2  ; ymm0 = ymm0 * ymm2 + ymm1
```

### AVX2 Enhancements
- 256-bit integer operations
- Vector shifts and rotates
- Gather operations
- Fused multiply-add (FMA)

```assembly
; AVX2 integer operations
vpmulld ymm0, ymm1, ymm2    ; 32-bit multiply
vpsllvd ymm1, ymm2, ymm3    ; Variable left shift
