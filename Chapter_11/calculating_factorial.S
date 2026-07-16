#
# вычисление факториала натруального числа (и числа 0)
#

#ifndef CALCULATING_FACTORIAL_S
#define CALCULATING_FACTORIAL_S

#
# factotial - макрос вычисления факториала
# result - регистр, в которой необходимо сохранить результат (регистр)
# reg - натуральное число и 0 (регистр)
# используемые регистры: t0 и t1
# значение факториала в регистре result (целочисленный)
#
.text
.MACRO factorial result, reg
       li t0, 0x0                                       # t0 = 0x0
       beq t0, \reg, 2f                                 # если число == 0 - возвращаем 1
       
       li \result, 0x1                                  # result = 0x1
       li t1, 0x2                                       # множитель 

       1:
       bgt t1, \reg, 3f                                 # если множитеь больше \reg - заканчиваем вычисление
       mul \result, \result, t1                         # \result = \result * t1
       addi t1, t1, 0x1                                 # t1 += 0x1
       j 1b 

       2:
       li \result, 0x1

       3:

.ENDM

#endif
