# 4. Control Flow in x86-64 Assembly

## Understanding Program Flow

Control flow instructions allow your program to make decisions and create loops. In assembly, this is done using conditional and unconditional jumps.

## Basic Jumps

### 1. Unconditional Jumps
```assembly
jmp label   ; Jump to label
```

### 2. Conditional Jumps
```assembly
je  label   ; Jump if equal (ZF=1)
jne label   ; Jump if not equal (ZF=0)
jg  label   ; Jump if greater (signed)
jl  label   ; Jump if less (signed)
ja  label   ; Jump if above (unsigned)
```

## Comparison Instructions

### CMP (Compare)
```assembly
cmp op1, op2    ; Sets flags based on (op1 - op2)
```

### TEST (Bitwise AND)
```assembly
test op1, op2   ; Sets flags based on (op1 & op2)
```

## Conditional Execution Example

```assembly
; File: compare.asm
