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

; Gather operations
; vpgatherdd ymm0, [rdi + ymm1*4], ymm2
; ymm0[i] = [rdi + ymm1[i]*4] if ymm2[i] < 0
```

## AVX-512 (Advanced Vector Extensions 512)

### Key Features
- 512-bit vector registers (ZMM0-ZMM31)
- 8 additional 64-bit mask registers (k0-k7)
- New instructions for complex operations
- Better support for 64-bit integers

### AVX-512 Code Example
```assembly
; Check for AVX-512 support
mov eax, 7
xor ecx, ecx
cpuid
and ebx, 1<<16  ; Check AVX-512F
jz no_avx512

; AVX-512 operations
vmovaps zmm0, [rdi]            ; Load 16 floats
vaddps zmm1, zmm0, [rsi]       ; Add 16 floats
vsqrtps zmm2, zmm1{k1}{z}      ; Conditional sqrt with mask k1
vscatterdps [r8 + zmm3*4]{k2}, zmm2  ; Scatter with mask k2
```

### AVX-512 Mask Registers
```assembly
; Set mask register k1 where elements > 0
vpcmpgtd k1, zmm0, [zero_vector]

; Zero elements where k1 is not set
vmovaps zmm1{k1}{z}, zmm0

