.data
    string:     .space 500
    new_string: .space 500
.text
.global main

main:
    jal ra, init_map    #mapeando letras acentuadas

    # Input da String 
    li a7, 8
    la a0, string
    li a1, 500
    ecall

    # Valores importantes
    la s0, string
    la s1, new_string
    li t1, 0x80
    li t4, ' '

    loop_remove_pontuacao:
        
        lbu t0, 0(s0)
        #li t2, '\n'
        beq t0, zero, end

        beq t0, t4, write_ascii

        blt t0, t1, ascii_case
        
        li t2, 0xC3
        beq t0, t2, utf8_case

        addi s0, s0, 1
        j loop_remove_pontuacao

    ascii_case:
        # minusculas
        li t2, 'a'
        blt t0, t2, check_upper

        li t2, 'z'
        ble t0, t2, write_ascii

    check_upper:
        # maiusculas
        li t2, 'Z'
        blt t2, t0, skip_ascii

        li t2, 'A'
        ble t2, t0, write_ascii

    check_digit:
        # digitos
        li t2, '9'
        blt t2, t0, skip_ascii

        li t2, '0'
        ble t2, t0, write_ascii

    skip_ascii:
        # skippa pontuações
        addi s0, s0, 1
        j loop_remove_pontuacao

    skip_utf8:
        # skippa simbolos utf8 não mapeados
        addi s0, s0, 2
        j loop_remove_pontuacao

    utf8_case:
        # trata letras acentuadas (usados no portugues)
        lbu t3, 1(s0)

        la t2, utf8_map
        add t2, t2, t3
        lbu t2, 0(t2)

        beqz t2, skip_utf8

        sb t2, 0(s1)

        addi s0, s0, 2
        addi s1, s1, 1
        j loop_remove_pontuacao

    write_ascii:
        # escreve em new_string o caractere não acentuado
        sb t0, 0(s1)

        addi s0, s0, 1
        addi s1, s1, 1
        j loop_remove_pontuacao
        
end:
    # printa a string nova
    sb zero, 0(s1)
    la a0, new_string
    li a7, 4
    ecall
    
    # encerra programa
    li a7, 10
    ecall
