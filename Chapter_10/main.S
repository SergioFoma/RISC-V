#
# перемножение дву 4 - битных чисел и вывод в знаковом и беззнаковом формате
#
.global main

.include "debug.S"

.section .rodata
first_task:  .asciz "first task = %b\n"
second_task: .asciz "second task = %b\n"
signed_print:.asciz "signed = %d\n"
unsigned_prt:.asciz "unsigned = %d\n"

.text
main:
    li t0, 0x5                                # t0 = 0x5
    li t1, 0x7                                # t1 = 0x7

    mul t2, t0, t1                            # t2 = t0 * t1 = 0x5 * 0x3 = 0x23
    print_format first_task, t2               # выводим значение регистр в 16 - ом и 10 - ом формате

    li t3, 0xf                                # t3 = 0xf
    li t4, 0x2                                # t4 = 0x2
    print_format second_task t3               # выводим значение регистра t3
    print_format second_task t4               # выводим значение регистра t4

    mul t5, t4, t3                            # t5 = t4 * t3
    print_format second_task t5               # выводим значение регистра t5 (младшие 64 бит)

    mul t5, t4, t3                            # t5 = t4 * t3 (беззнаковое умножение)
    print_format signed_print t5              # выводим значение регистр t5 (старшие 64 бит)

    mul t5, t4, t3                            # t5 = t4 * t3 (беззнаковое умножение = 11110)
    slli t5, t5, 59                           # сдвигаем наши 5 значащих бит влево, справа клеются нули
    srai t5, t5, 59                           # возвращаем наши 5 бит назад, но теперь расширяемся нулями
    print_format unsigned_prt t5              # выводим значение регстра t5 (старшие 64 бит)
    print_format second_task t5               # выводим значение регистра в двух цифриной системе

    li a0, 0                                  # a0 = 0 (код ошибки)
    ret
                       
