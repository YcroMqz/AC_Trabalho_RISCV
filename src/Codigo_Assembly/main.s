.data
.globl string
.globl new_string
    string:     .space 500      # string original lida do teclado
    new_string: .space 500      # string resultante sem acentos/pontuação

.text
.global main

main:
    # inicializa a tabela usada para converter
    # caracteres acentuados UTF-8 em letras simples
    jal ra, init_map

    # lê a string
    li a7, 8
    la a0, string
    li a1, 500
    ecall

    # s0 -> percorre a string original
    # s1 -> escreve na nova string
    # t1 -> limite entre ASCII e UTF-8
    # t4 -> caractere espaço
    la s0, string
    la s1, new_string
    li t1, 0x80
    li t4, 0x20

loop_remove_pontuacao:

    # lê o próximo byte da string
    lbu t0, 0(s0)

    # condição de parada
    beq t0, zero, end

    # mantém espaço
    beq t0, t4, write_ascii

    # caracteres ASCII possuem valor menor que 0x80
    blt t0, t1, ascii_case

    # letras acentuadas em UTF-8 começam com 0xC3
    li t2, 0xC3
    beq t0, t2, utf8_case

    # qlqr outro símbolo UTF-8 é ignorado
    addi s0, s0, 1
    j loop_remove_pontuacao

ascii_case:
    # verifica se é letra minúscula
    li t2, 'a'
    blt t0, t2, check_upper

    li t2, 'z'
    ble t0, t2, write_ascii

check_upper:
    # verifica se é letra maiúscula
    li t2, 'Z'
    blt t2, t0, check_digit

    li t2, 'A'
    ble t2, t0, write_ascii

check_digit:
    # verifica se é um dígito
    li t2, '9'
    blt t2, t0, skip_ascii

    li t2, '0'
    ble t2, t0, write_ascii

skip_ascii:
    # descarta pontuações e símbolos ASCII
    addi s0, s0, 1
    j loop_remove_pontuacao

skip_utf8:
    # descarta caracteres UTF-8 de que não possuem mapeamento
    addi s0, s0, 2
    j loop_remove_pontuacao

utf8_case:
    # obtém o segundo byte do caractere UTF-8
    lbu t3, 1(s0)

    # consulta a tabela de conversão
    la t2, utf8_map
    add t2, t2, t3
    lbu t2, 0(t2)

    # se não existir no map, ignora
    beqz t2, skip_utf8

    # screve a letra sem acento
    sb t2, 0(s1)

    # avança dois bytes na entrada e um na saída
    addi s0, s0, 2
    addi s1, s1, 1
    j loop_remove_pontuacao

write_ascii:
    # copia o caractere para a nova string
    sb t0, 0(s1)

    addi s0, s0, 1
    addi s1, s1, 1
    j loop_remove_pontuacao

end:
    sb zero, 0(s1)

    # imprime o resultado
    la a0, new_string
    li a7, 4
    ecall

    # Encerra o programa.
    li a7, 10
    ecall