.global _start

# шаблон цикла DO - WHILE

.section .rodata
.equ UPPER_BOUND, 10

str:
1:
    .ascii "In do-while cycle\n"
2:
    .equ len, 2b - 1b

.text
_start:
    li t1, UPPER_BOUND                             # t1 = UPPER_BOUND (верхняя граница счетчика)
    li t2, 0                                       # t2 = 0 (начально значение счетчика)

    do_while_start:
    li a0, 1                                       # файловый дескриптор для вывода
    la a1, str
    li a2, len
    li a7, 64                                      # номер системного вызова
    ecall

    add t2, t2, 1
    bltu t2, t1, do_while_start                    # переход пока счетчик не достиг верхней границы
    do_while_end:
    
    li a0, 0                                       # код возврата 0
    li a7, 93                                      # код 93 службы завершает работу

    ecall                                          # вызвать linux для завершения программы    
