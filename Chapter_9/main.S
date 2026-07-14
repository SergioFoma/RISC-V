.global main

.include "debug.S"

.section .rodata
string: .asciz "Hello world!\n"
ptr:    .asciz "Hello Asm!\n"

.text
main:
    li t0, 0x10                         # t0 = 0x10
    li t1, 'A'                          # t1 = 'A'
    la t2, string                       # загружаем в t2 адрес метки string
    
    print_reg_v t0                      # вывести значение в регистр
    print_reg_s t2                      # вывести стркоовый литерал в регистре
    print_str ptr                       # вывести строковый литерал
    print_reg_a t1                      # вывести ascii символ в регистре


    li a0, 0                            # код ошибки
    ret                                 # вернуть управление из функции
