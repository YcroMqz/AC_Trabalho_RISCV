.data
    string:     .space 200
    new_string: .space 200
.text
.global main

main:
    jal ra, utf8_map

    li a7, 8
    la a0, string
    li a1, 200
    ecall

    la s0, string
    la s1, new_string
    li t1, 0xC3

    loop_remove_pontuacao:
        la t0, 0(s0)
        beq t0, t1, 
        blt

    incrementa_ponteiro:

    print:




