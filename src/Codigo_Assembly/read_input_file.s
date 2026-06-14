.data
    filename:   .asciz "../String.txt"
.text
.globl read_input_file
read_input_file:

    la a0, filename
    li a1, 0
    li a7, 1024
    ecall

    mv t0, a0

    la a1, string
    li a2, 499
    li a7, 63
    ecall
    
    la t1, string
    add t1, t1, a0
    sb zero, 0(t1)

    mv a0, t0
    li a7, 57
    ecall

    ret