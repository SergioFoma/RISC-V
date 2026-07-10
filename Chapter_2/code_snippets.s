.global _start

.text
_start:
    # Load 0x1234567890ABCDEF into register x5
    lui x5, 0x12345                     # x5 = 0x12345000
    slli x5, x5, 32                     # x5 = 0x1234500000000000
    addi x6, x0, 0x679                  # x6 = 0x679
    slli x6, x6, 32                     # x6 = 0x67900000000
    add x5, x5, x6                      # x5 = 0x12345678900000000
    addi x6, x0, 0xFFFFFFFFFFFFF90A     # x6 = 0x90A
    slli x6, x6, 20                     # x6 = 0x90B00000
    add x5, x5, x6                      # x5 = 0x1234567890B00000
    addi x6, x0, 0xFFFFFFFFFFFFFBCD     # x6 = 0xBCD
    slli x6, x6, 8                      # x6 = 0xBCD00
    add x5, x5, x6                      # x5 = 0x1234567890ABCD00
    addi x5, x5, 0xEF                   # x5 = 0x1234567890ABCDEF

    mv a0, x0
    li a7, 93

    ecall
