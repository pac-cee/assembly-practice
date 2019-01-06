# 2. Registers and Basic Arithmetic in x86-64

## Understanding Registers

Registers are small storage locations directly on the CPU. In x86-64, we have:

### General-Purpose Registers (64-bit)
```
RAX, RBX, RCX, RDX, RSI, RDI, RBP, RSP, R8-R15
```

### 32-bit, 16-bit, and 8-bit Views
```
64-bit      32-bit    16-bit   8-bit (high)  8-bit (low)
--------------------------------------------------------
RAX         EAX       AX       AH            AL
RBX         EBX       BX       BH            BL
RCX         ECX       CX       CH            CL
RDX         EDX       DX       DH            DL
