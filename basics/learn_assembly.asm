section .data
    ; Menu strings
    menu db 10, "Assembly Learning Program", 10
         db "----------------------", 10
         db "1. Registers & Basic Operations", 10
         db "2. Memory & Addressing Modes", 10
         db "3. Arithmetic Operations", 10
         db "4. Control Flow & Comparisons", 10
         db "5. Stack Operations", 10
         db "6. Arrays & Loops", 10
         db "7. Function Calls", 10
         db "8. Bit Operations", 10
         db "9. Exit", 10
         db "Choose a lesson (1-9): ", 0
    
    ; Lesson headers
    reg_header db "Lesson 1: Registers & Basic Operations", 10, 0
    mem_header db "Lesson 2: Memory & Addressing Modes", 10, 0
    arith_header db "Lesson 3: Arithmetic Operations", 10, 0
    flow_header db "Lesson 4: Control Flow & Comparisons", 10, 0
    stack_header db "Lesson 5: Stack Operations", 10, 0
    array_header db "Lesson 6: Arrays & Loops", 10, 0
    func_header db "Lesson 7: Function Calls", 10, 0
    bit_header db "Lesson 8: Bit Operations", 10, 0

    ; Common formats
    format_in db "%d", 0
    format_out db "%d", 10, 0
    format_hex db "Hex: 0x%x", 10, 0
    press_key db "Press Enter to continue...", 10, 0
    
    ; Demo values
    demo_array dd 1, 2, 3, 4, 5
    demo_size dd 5

section .bss
    choice resd 1
    input resd 1
