#
# просмотр результат деления на нуль
#

.include "floating_exceptions.S"

.global main

.section .rodata
.equ RNE          , 0x0                         # режим округления по умолчанию
.equ INIT_FLAGS   , 0x0                         # обнуление флагов

double_1: .double 1.25
double_2: .double 0.0

.text
main:
    addi sp, sp, -32                            # выделяем в стеке память под 32 байта
    sd ra, 0(sp)                                # загружаем адрес возврата
    sd s0, 8(sp)                                # загружаем s0
    sd s1, 16(sp)                               # загружаем s1
    sd s2, 24(sp)                               # загружаем s2

    frcsr s0                                    # скопировать текущее значение frcsr в s0
    li s1, RNE                                  # s1 = RNE
    fsrm s1, s1                                 # задаем новый режим округления, старый не сохраняем
    li s2, INIT_FLAGS                           # s2 = INIT_FLAGS
    fsflags s2, s2                              # устанавливаем значение флагов
    
    la t0, double_1                             # загружаем адрес double_1 в t0
    fld fa0, 0(t0)                              # загружаем t0 в fa0

    la t0, double_2                             # загружаем адрес double_2 в t0
    fld fa1, 0(t0)                              # загружаем t0 в fa1

    fdiv.d fa2, fa0, fa1                        # fa2 = fa0 / fa1
    frflags t0                                  # считываем флаги
    check_exception t0                          # проверки на исключение
    print_double fa2

    ld ra, 0(sp)                                # загружаем старое значение ra
    ld s0, 8(sp)                                # загружаем старое значение s0
    ld s1, 16(sp)                               # загружаем старое значение s1
    ld s2, 24(sp)                               # загружаем старое значение s2
    addi sp, sp, 32                             # очищаем выделенную память в стеке

    li a0, 0x0                                  # код ошибки
    ret
