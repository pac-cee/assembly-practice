# 11. Advanced Optimization Techniques in x86-64 Assembly

## Understanding CPU Pipelines

### Pipeline Stages in Modern CPUs
1. Fetch
2. Decode
3. Rename (Register renaming)
4. Schedule
5. Execute
6. Retire

### Instruction-Level Parallelism (ILP)
- Superscalar execution
- Out-of-order execution
- Speculative execution

## Microarchitecture-Specific Optimization

### Identifying CPU Features
```assembly
; Check for CPU features using CPUID
check_avx2:
    mov eax, 7
    xor ecx, ecx
    cpuid
    test ebx, (1 << 5)  ; AVX2
    jz no_avx2
    ; AVX2 available
    
; Check for AVX-512
check_avx512:
    mov eax, 7
    xor ecx, ecx
    cpuid
    test ebx, (1 << 16)  ; AVX-512F
    jz no_avx512
    ; AVX-512 available
```

## Data Alignment

### Cache Line Alignment
```assembly
section .data
    align 64      ; Align to cache line (64 bytes)
    my_data: 
        times 64 db 0

section .bss
    align 64
    buffer: resb 4096
```

### Structure Packing
```c
// Before optimization
struct unoptimized {
    char a;     // 1 byte + 7 padding
    double b;   // 8 bytes
    int c;      // 4 bytes + 4 padding
};              // Total: 24 bytes

// After optimization
struct optimized {
    double b;   // 8 bytes
    int c;      // 4 bytes
    char a;     // 1 byte + 3 padding
};              // Total: 16 bytes
```

## Branch Optimization

### Branch Prediction Hints
```assembly
; Unlikely branch (hint to CPU)
cmp rax, rbx
jne .unlikely_branch  ; 2C (not taken) 1D (taken)

; Likely path

.unlikely_branch:
; Less frequent code
```

### Branchless Programming
```c
// Branch version
int max(int a, int b) {
    return (a > b) ? a : b;
}

// Branchless version
int max_branchless(int a, int b) {
    int diff = a - b;
    int mask = diff >> 31;
    return a + (diff & mask);
}
```

## SIMD Optimization

### AVX2 Example: Vector Addition
```assembly
; void vector_add(double *a, double *b, double *c, size_t n)
vector_add:
    test rcx, rcx
    jz .done
    
    vxorpd ymm0, ymm0, ymm0
    
.loop:
    vmovapd ymm1, [rdi]      ; Load a[0:3]
    vaddpd ymm1, ymm1, [rsi]  ; Add b[0:3]
