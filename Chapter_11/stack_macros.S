#
# макросы для добавления данных в стек и извлечения из
#

#ifndef STACK_MACROS_S
#define STACK_MACROS_S

#
# загружает одно значение из регистра в стек
# используемые регистры: sp
#
.text
.MACRO push_1 reg
       addi sp, sp, -16
       sd \reg, 8(sp)
.ENDM

#
# загружает два значения из регистра в стек
# используемые регистры: sp
#
.MACRO push_2 reg_1, reg_2
       addi sp, sp, -16
       sd \reg_1, 8(sp)
       sd \reg_2, 0(sp)
.ENDM

#
# загружает одно значение с плавающей точкой в стек
# используемые регистры: sp
#
.MACRO push_double f_reg
       addi sp, sp, -16
       fsd \f_reg, 8(sp)
.ENDM

#
# загружает одно значение с плавающей точкой в стек
# используемые регистры: sp
#
.MACRO pop_double f_reg
       fld \f_reg, 8(sp)
       addi sp, sp, 16
.ENDM

#
# берет одно значение co стека и сохраняет в регистр
# используемые регистры: sp
#
.MACRO pop_1 reg
       ld \reg, 8(sp)
       addi sp, sp, 16
.ENDM

#
# берет два значения со стека и сохраняет в регистр
# используемые регистры: sp
#
.MACRO pop_2 reg_1, reg_2
       ld \reg_1, 8(sp)
       ld \reg_2, 0(sp)
       addi sp, sp, 16
.ENDM

#endif
