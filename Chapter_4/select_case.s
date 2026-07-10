.global _start

# Реализация шаблона select-case
# На каждый case будет выводиться своя уникальная строка
# Каждый case_data является глобальной меткой, внутри него есть своя соответствующая строка и ее длина

.section .rodata

.equ FIRST_CASE , 1                               # константа = номер case
.equ SECOND_CASE, 2
.equ THIRD_CASE , 3

case_1_data:                                       # глобальная метка
    1:                                             # локальная метка
        .ascii "Case 1 was called!\n"              # не создаем '\0' в конце
    2:                                             # локальная метка
        .equ FIRST_STR_LEN, 2b - 1b                # создаем константу STR_LEN, и присваиваем ей длину строки str_one
case_2_data:
    1:
        .ascii "Case 2 was called!\n"
    2:
        .equ SECOND_STR_LEN, 2b - 1b
case_3_data:
    1:
        .ascii "Case 3 was called!\n"
    2:
        .equ THIRD_STR_LEN, 2b - 1b
case_else_data:
    1:
        .ascii "Case else was called!\n"
    2:
        .equ THOUR_STR_LEN, 2b - 1b

.text
_start:
    li x5, 0xA2                                     # x5 = 0x1

    start_select:
    li t3, FIRST_CASE                              # t3 = FIRST_CASE (1)
    bne x5, t3, case_2                             # Если x5 != 1 - проверяем следующий case (case 2)

    case_1:
    la a1, case_1_data                             # загрузить адрес строки в регистр x6
    li a2, FIRST_STR_LEN                           # положить длину строки в регистр x7
    call print_str
    j end_select                                   # перейти к окончанию end_select
    
    case_2:
    li t3, SECOND_CASE
    bne x5, t3, case_3
    la a1, case_2_data
    li a2, SECOND_STR_LEN
    call print_str
    j end_select
    
    case_3:
    li t3, THIRD_CASE
    bne x5, t3, case_else
    la a1, case_3_data
    li a2, THIRD_STR_LEN
    call print_str
    j end_select

    case_else:
    la a1, case_else_data
    li a2, THOUR_STR_LEN
    call print_str

    end_select:
    
    li a0, 0                                       # код возврата 0
    li a7, 93                                      # код 93 службы завершает работу

    ecall                                          # вызвать linux для завершения программы


print_str:
    li a0, 1                                       # файловый дескриптор для вывода
    li a7, 64                                      # номер системного вызова
    
    ecall
    ret
    
