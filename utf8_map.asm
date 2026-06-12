.data
utf8_map: .space 256

.text
.globl init_map

init_map:
    la t0, utf8_map

    # ===== minúsculas =====

    # a
    li t1, 'a'
    sb t1, 0xA0(t0)    # à
    sb t1, 0xA1(t0)    # á
    sb t1, 0xA2(t0)    # â
    sb t1, 0xA3(t0)    # ã

    # c
    li t1, 'c'
    sb t1, 0xA7(t0)    # ç

    # e
    li t1, 'e'
    sb t1, 0xA9(t0)    # é
    sb t1, 0xAA(t0)    # ê

    # i
    li t1, 'i'
    sb t1, 0xAD(t0)    # í

    # o
    li t1, 'o'
    sb t1, 0xB3(t0)    # ó
    sb t1, 0xB4(t0)    # ô
    sb t1, 0xB5(t0)    # õ

    # u
    li t1, 'u'
    sb t1, 0xBA(t0)    # ú

    # ===== maiúsculas =====

    # A
    li t1, 'A'
    sb t1, 0x80(t0)    # À
    sb t1, 0x81(t0)    # Á
    sb t1, 0x82(t0)    # Â
    sb t1, 0x83(t0)    # Ã

    # C
    li t1, 'C'
    sb t1, 0x87(t0)    # Ç

    # E
    li t1, 'E'
    sb t1, 0x89(t0)    # É
    sb t1, 0x8A(t0)    # Ê

    # I
    li t1, 'I'
    sb t1, 0x8D(t0)    # Í

    # O
    li t1, 'O'
    sb t1, 0x93(t0)    # Ó
    sb t1, 0x94(t0)    # Ô
    sb t1, 0x95(t0)    # Õ

    # U
    li t1, 'U'
    sb t1, 0x9A(t0)    # Ú

    ret
