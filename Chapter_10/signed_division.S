#
# Деление знаковых 64 - битных целых чисел
#

.include "debug.S"

.global main

.section .rodata
.equ NUMERATOR_64   , 0x5                           # первое 64 - битное число
.equ DENOMINATOR_64 , 0x2                           # второе 64 - битное число
whole_part_str: .asciz "whole_part = %d\n"          # форматная строка для вывода целой части
remainder_str:  .asciz "remainder = %d\n"           # форматная строка для вывода остатка 
log_error:      .asciz "Error: division by zero!\n" # лог о сообщении об ошибке
reg_print:      .asciz "reg = %b\n"                 # форматная строка для вывода значения регистра

.text
main:
    li t0, NUMERATOR_64                         # t0 = NUMERATOR_64
    li t1, DENOMINATOR_64                       # t1 = DENOMINATOR_64

    print_format reg_print, t0                  # вывод содержимого t0
    print_format reg_print, t1                  # вывод содержимого t0

    li t3, 0x0                                  # t3 = 0x0
    beq t1, t3, print_err                       # если знаменатель равен нулю - переходим в ветку для обработки ошибки

    div t4, t0, t1                              # знаковое деление t0 на t1 (res = t4)
    rem t5, t0, t1                              # знаковый остаток (знак остатка совпадает со знаком делимого)
    print_format whole_part_str, t4             # вывод целой части от деления
    print_format remainder_str, t5              # вывод остатка

    j exit                                      # переходим к выходу из main функции

print_err:
    print_str log_error                         # выводим сообщение о делении на нуль
    j exit                                      # переходим к выходу из main функции


exit:
    li a0, 0x0                                  # код ошибки
    ret
