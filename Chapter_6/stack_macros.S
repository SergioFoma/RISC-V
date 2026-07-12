#
# макросы для добавления данных в стек и извлечения из
#

.MACRO push_1 reg
       addi sp, sp, -16
       sd \reg, 8(sp)
.ENDM

.MACRO push_2 reg_1, reg_2
       addi sp, sp, -16
       sd \reg_1, 8(sp)
       sd \reg_2, 0(sp)
.ENDM

.MACRO pop_1 reg
       ld \reg, 8(sp)
       addi sp, sp, 16
.ENDM

.MACRO pop_2 reg_1, reg_2
       ld \reg_1, 8(sp)
       ld \reg_2, 0(sp)
       addi sp, sp, 16
.ENDM


