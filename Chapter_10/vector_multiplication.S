#
# программа для перемножения векторов размерности N
#

.include "debug.S"

.global main

.section .rodata
.equ N         , 6                                                     # размерность векторов
.equ CAPACITY , 32                                                    # размер блока памяти в битах
.equ CAPACITY  , 4                                                     # размер одного блока памяти
.equ COUNT     , 6                                                     # количесто выделенных блоков
.equ VALUE     , 0                                                     # значение по умолчанию
first_vector:  .word 0x1 , 0x12, 0x123, 0x1234, 0x12345, 0x12345678    # первый вектор
second_vector: .word 0x12, 0x12, 0x12 , 0x12  , 0x12   , 0x12          # второй вектор
print_vector:  .asciz "%ld "                                           # форматная строка

.section .data
result:        .fill CAPACITY, COUNT, VALUE                            # выделяем блок памяти под умножение

.text
main:
    li t0, 0x0                                                         # t0 = 0 (счетчик)
    li t1, N                                                           # t1 = N

    la s2, first_vector                                                # загружаем адрес первого вектора
    la s3, second_vector                                               # загружаем адрес второго вектора
    la s4, result                                                      # загружаем адрес результирующего вектора

    start_while:
    beq t0, t1, end_while                                              # если t0 == N - завершаем перемножение.
    lw t4, 0(s2)                                                       # загружаем первое слово по адресу s2
    lw t5, 0(s3)                                                       # загружаем первое слово по адресу s3
    
    mul t6, t4, t5                                                     # t6 = t4 * t5 (младшие 64 бит)
    sw t6, 0(s4)                                                       # загружаем слово по адресу s4
    
    addi s2, s2, CAPACITY                                             # увеличиваем адрес на размер элемента
    addi s3, s3, CAPACITY                                             # увеличиваем адрес памяти на размер элемента
    addi s4, s4, CAPACITY                                             # увеличиваем адрес памяти на размер элемента
    addi t0, t0, 0x1                                                   # увеличиваем счетчик
    j start_while                                                      # возвращаемся к циклу

    end_while:
    
    li t0, 0x0                                                         # t0 = 0x0 (счетчик)
    la s5, result                                                      # загружем адрес результат умножения

    start_print:
    beq t0, t1, end_print                                              # если счетчик равен N - выходим
    lw s6, 0(s5)                                                       # загружаем первое слово по адресу s5
    print_format print_vector, s6                                      # выводим значение
    addi t0, t0, 0x1                                                   # увеличиваем счетчик
    addi s5, s5, CAPACITY                                             # увеличиваем значение адреса на слово
    j start_print                                                      # возвращаемся к печати

    end_print:

    li a0, 0x0                                                         # a0 = 0x0 (код ошибки)
    ret
