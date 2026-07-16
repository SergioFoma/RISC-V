#
# Функция для вычисления синуса угла
#

.include "calculating_factorial.S"
.include "exponentiation.S"

.global sin


.section .rodata
.equ THIRD_DEGREE   , 0x3                                         # третья степень                                                
.equ FIFTH_DEGREE   , 0x5                                         # пятая степень
.equ SEVENTH_DEGREE , 0x7                                         # седьмая степень
init_sum: .double 0.0                                             # значение для инииализации регистра

#
# sin x - вычисляет синус числа x
# x - угол в радианах (передается в fa0 - регистр для работы с плавающей точкой)
# используемые регисры: fa0, fa1, fa2, fa3, t0, t2 и t3 
#
.text
sin:
    addi sp, sp, -16                                              # выделяем место в стеке
    sd ra, 0(sp)                                                  # сохраняем адрес возврата в стек
    
    fmv.d fa4, fa0                                                # сохраняем параметр функции (x)
    la t0, init_sum                                               # загружаем адрес init_sum
    fld fa2, 0(t0)                                                # загружаем в fa2 дробное число двойно точности (sum = fa2)
    fadd.d fa2, fa2, fa4                                          # sum += x
    
    li t2, THIRD_DEGREE                                           # t2 = THIRD_DEGREE
    pow fa0, t2                                                   # вычислить x ^ 3
    li t2, THIRD_DEGREE                                           # t2 = THIRD_DEGREE
    factorial t3, t2                                              # вычислить 3!
    fcvt.d.l fa3, t3                                              # сохранить факториал в регистр fa3
    fdiv.d fa3, fa0, fa3                                          # x^3 / 3!
    fsub.d fa2, fa2, fa3                                          # sum = x - x3/3!
    
    fmv.d fa0, fa4                                                # снова fa0 = x

    li t2, FIFTH_DEGREE                                           # t2 = FIFTH_DEGREE
    pow fa0, t2                                                   # вычислить x ^ 5
    li t2, FIFTH_DEGREE                                           # t2 = FIFTH_DEGREE
    factorial t3, t2                                              # вычислить 5!
    fcvt.d.l fa3, t3                                              # сохранить факториал в регистр fa3
    fdiv.d fa3, fa0, fa3                                          # x^5 / 5!
    fadd.d fa2, fa2, fa3                                          # sum = x - x3/3! + x^5/5!
    
    fmv.d fa0, fa4                                                # снова fa0 = x

    li t2, SEVENTH_DEGREE                                         # t2 = THIRD_DEGREE
    pow fa0, t2                                                   # вычислить x ^ 3
    li t2, SEVENTH_DEGREE                                         # t2 = THIRD_DEGREE
    factorial t3, t2                                              # вычислить 7!
    fcvt.d.l fa3, t3                                              # сохранить факториал в регистр fa3
    fdiv.d fa3, fa0, fa3                                          # x^7 / 7!
    fsub.d fa2, fa2, fa3                                          # sum = x - x3/3! + x^5/5! - x^7/7!

    fmv.d fa0, fa2                                                # сохранить результат в fa0

    ld  ra, 0(sp)                                                 # загружаем ra из стека
    addi sp, sp, 16                                               # освобождаем стек

    ret


