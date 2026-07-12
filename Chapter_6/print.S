#
# макрос для вывода строкого литерала в стандартный поток вывода
#


.MACRO  print address_reg, len_reg 
        mv a1, \address_reg                               # a1 = адреса выходной строки (address_reg - регистр)
        mv a2, \len_reg                                   # a2 = длина выходной строки (len_reg - регистр)
        li a0, 1                                          # a0 = 1 - стандартный поток вывода
        li a7, 64                                         # a7 = 64 - системный вызов
        ecall                                             # вызов Linux
.ENDM
