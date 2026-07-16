#
# Возведение натурального числа и нуля в степень 
#

#ifndef EXPONENTIATION_S
#define EXPONENTIATION_S

.include "floating_exceptions.S" 

.section .rodata
factor: .double 1.0

#
# pow - возведение в степень
# num - основание степени (регистр для работы с плавающей точкой)
# exp - показатель степени (целочисленный регистр)
# используемые регистры: t0, t1, fa0 и fa1
# результат возведения в степень в fa0
#
.text
.MACRO pow num, exp
       
       fmv.d fa1, \num                                  # загружаем num в регистр fa1
       la t0, factor                                    # загрузить адрес числа с плавающей точкой в t0
       fld fa0, 0(t0)                                   # fa0 = 1.0
       li t1, 0x0                                       # счетчик

       1:
       beq t1, \exp, 2f                                 # если счетчик равен exp - выходим (так как с нуля начинаем)
       fmul.d fa0, fa0, fa1                             # t0 *= num
       addi t1, t1, 0x1                                 # увеличиваем значение счетчика
       j 1b

       2:
.ENDM

#endif
