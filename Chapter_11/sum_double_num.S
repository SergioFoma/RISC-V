#
# прогрмма для тренировки сложения вещественных чисел
#

.include "debug.S"

.global main

.section .rodata
.equ RNE        , 0x0                           # режим округления по умолчанию (к четному)
.equ INIT_FLAGS , 0x0                           # инициализация флагов значением нуль

double_1:  .double 2.343                        # сохраняем в памяти число с плавающей точкой двойной точности
double_2:  .double 5.3                         
double_3:  .double 3.5343425445
double_4:  .double 1.534443455
double_5:  .double 3.14e12
double_6:  .double 5.55e-10

.text
main:
    addi sp, sp, -32                            # выделеям в стеке 32 байта
    sd ra, 0(sp)                                # сохраняем адрес возврата
    sd s0, 8(sp)                                # сохраняем s0
    sd s1, 16(sp)                               # сохраняем s1
    sd s2, 24(sp)                               # сохраняем s2

    frcsr s0                                    # скопировать текущее значение frcsr в s0
    li s1, RNE                                  # s1 = RNE
    fsrm s1, s1                                 # задаем новый режим округления, старый не сохраняем
    li s2, INIT_FLAGS                           # s2 = INIT_FLAGS
    fsflags s2, s2                              # устанавливаем значение флагов
    
    la t0, double_1                             # загружаем адрес double_1 в регитср t0
    fld ft0, 0(t0)                              # загружаем double в ft0 

    la t1, double_2                             # загружаем адрес double_2 в регистр t1
    fld ft1, 0(t1)                              # загружаем double в ft1

    la t2, double_3                             # загружаем адрес double_3 в регистр t2
    fld ft2, 0(t2)                              # загружаем double в ft2

    la t3, double_4                             # загружаем адрес double_4 в регистр t3
    fld ft3, 0(t3)                              # загружаем double в ft3

    la t4, double_5                             # загружаем адрес double_5 в регистр t4
    fld ft4, 0(t4)                              # загружаем double в ft4

    la t5, double_6                             # загружаем адрес double_6 в регистр t5
    fld ft5, 0(t5)                              # загружаем double в ft5

    fadd.d fa0, ft0, ft1                        # fa0 = ft0 + ft1 (double type)
    print_double fa0                            # выводим значеие регистра fa0

    fadd.d fa1, ft2, ft3                        # fa1 = ft2 + ft3
    print_double fa1                            # выводим значение fa1

    fadd.d fa2, ft4, ft5                        # fa2 = ft4 + ft5
    print_double fa2                            # выводим значение fa2

    ld ra, 0(sp)                                # загружаем старое значение ra
    ld s0, 8(sp)                                # загружаем старое значение s0
    ld s1, 16(sp)                               # загружаем старое значение s1
    ld s2, 24(sp)                               # загружаем старое значение s2
    addi sp, sp, 32                             # очищаем выделенную память в стеке

    li a0, 0x0                                  # код ошибки
    ret
