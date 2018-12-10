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
