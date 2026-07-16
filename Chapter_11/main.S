#
# в данной программе происходит тестирование функции я sin
#

.include "debug.S"
.include "stack_macros.S"

.global main

.section .rodata
.equ RNE        , 0x0                        # режим округления по умолчанию
.equ INIT_FLAGS , 0x0                        # задание начального значения флагам
x: .double 2.0                               # аргумент синуса
.text
main:
    addi sp, sp, -48                         # выделяем место в стеке
    sd ra   , 0(sp)                          # сохраняем адрес возврата в стек
    sd s1   , 8(sp)                          # сохраняем s1 в стек
    fsd fa0 , 16(sp)                         # сохраняем fa0 в стек
    fsd fa1 , 24(sp)                         # сохраняем fa1 в стек
    fsd fa2 , 32(sp)                         # сохраняем fa2 в стек
    fsd fa3 , 40(sp)                         # сохраняем fa3 в стек
    fsd fa4 , 48(sp)                         # сохраняем fa4 в стек

    frcsr t0                                 # копируем текущее значение fcsr в t0
    li s1, RNE                               # s1 = RNE
    fsrm s1, s1                              # задание режим округления
    li s1, INIT_FLAGS                        # s1 = INIT_FLAGS
    fsflags s1, s1                           # задание значения флагов
    
    la t0, x                                 # сохраняем адрес x
    fld fa0, 0(t0)                           # fa0 = x
    push_double fa0                          # сохраняем fa0 в стек
    call sin                                 # считаем синус(x)
    
    print_double fa0                         # печатаем значение регистра
    pop_double fa0                           # загружаем fa0 из стека

    ld ra   , 0(sp)                          # загружаем адрес возврата из стека
    ld s1   , 8(sp)                          # загружаем s1 из стека
    fld fa0 , 16(sp)                         # загружаем fa0 из стека
    fld fa1 , 24(sp)                         # загруажем fa1 из стека
    fld fa2 , 32(sp)                         # загружаем fa2 из стека
    fld fa3 , 40(sp)                         # загружаем fa3 из стека
    fld fa4 , 48(sp)                         # загружаем fa4 из стека
    addi sp, sp, 48                          # очищаем стек

    li a0, 0x0                               # код ошибки
    ret

