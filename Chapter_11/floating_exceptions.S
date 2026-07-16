#
# макрос для генерации исключений при работе с плавающей точкой
#

#ifndef FLOATING_EXCEPTIONS_S
#define FLOATING_EXCEPTIONS_S

.include "debug.S"

.section .rodata
.equ NX , 0b00001                                           # неточный результат
.equ UF , 0b00010                                           # потеря значимости
.equ OF , 0b00100                                           # переполнение
.equ DZ , 0b01000                                           # деление на нуль
.equ NV , 0b10000                                           # недопустимая операция

nx_log: .asciz "Inaccurate result. The rounding resulted in a change in the value!\n"
uf_log: .asciz "Loss of importance. The result is too small in modulus!\n"
of_log: .asciz "Overflow. The result modulo exceeds the maximum representable number!\n"
dz_log: .asciz "Division by zero!\n"
nv_log: .asciz "Invalid operation!\n"

# check_exception - макрос
# \flags - флаги исключений (целочисленный регист)
# используемые регистры: t1 и t2
#
.text
.MACRO check_exception flags
       
       li t2, 0x0                                       # счетчик исключений

       1:
       andi t1, \flags, NX                              # смотрим на младший бит в младшем байте
       beq x0, t1, 2f                                   # если бит нулевой - переходим к следующему исключения
       print_str nx_log                                 # выводим сообщение об ошибке
       addi t2, t2, 1                                   # увеличиваем счетчик

       2:
       andi t1, \flags, UF                              # смотрим на второй бит в младшем байте
       beq x0, t1, 3f                                   # если бит нулевой - переходим к следующей ошибке
       print_str uf_log                                 # выводим сообщение об ошибке
       addi t2, t2, 1                                   # увеличиваем счетчик

       3:
       andi t1, \flags, OF                              # смотрим на третий бит в младшем байте
       beq x0, t1, 4f                                   # если бит нулевой - переходим к следующей ошибке
       print_str of_log                                 # выводим сообщение об ошибке
       addi t2, t2 ,1                                   # увеличиваем счетчик

       4:
       andi t1, \flags, DZ                              # смотрим на четвертый бит в младшем байте
       beq x0, t1, 5f                                   # если бит нулевой - переходим к следующей ошибке
       print_str dz_log                                 # выводим сообщение об ошибке
       addi t2, t2 ,1                                   # увеличиваем счетчик


       5:
       andi t1, \flags, NV                              # смотрим на третий бит в младшем байте
       beq x0, t1, 6f                                   # если бит нулевой - проверяем счетчик
       print_str nv_log                                 # выводим сообщение об ошибке
       addi t2, t2 ,1                                   # увеличиваем счетчик

       6:
       beq x0, t2, 8f

       7:

       li a7, 93                                        # системный вызов о завершении программы
       li a0, 0                                         # код ошибки
       ecall                                            # вызов Linux

       8:
.ENDM

#endif
