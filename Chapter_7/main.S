#
# программа перевода файлового текста в нижний регистр
# и сохранение измененного текста в выходной файл
#

.include "memory_lib.S"
.include "file_lib.S"
.include "stack_macros.S"

.global _start

.section .rodata
.equ STAT_BUF_CAP, 128                                  # размер буффера под методанные fstat
.equ COUNT       , 1                                    # количество итераций
.equ VALUE       , 0                                    # значение по умолчанию
.equ PAGE_CAP    , 4096                                 # размер страницы
input_file:  .asciz "input.txt"                         # файл с исходным текстом          (исходный файл)
output_file: .asciz "output.txt"                        # файл с текстом в нижнем регистре (выходной файл)
1:
log_open:    .asciz "\nOpen file error\n"               # лог ошибки открытия файла
2:
.equ LOG_OPEN_LEN, 2b - 1b                              # длина лога ошибки открытия файла
1:
log_fstat:    .asciz "\nFile stat error\n"              # лог с ошибкой fstat
2:
.equ LOG_FSTAT_ERR, 2b - 1b

.section .data
input_fd:  .dword 0x0                                   # файловый дескриптор взодящего файла
output_fd: .dword 0x0                                   # файловый дескриптор выходящего файла
file_size: .dword 0x0                                   # размер входного и, соответственно, выходного файла

.align 3                                                # выравнивание по границе 8 байт
stat_buf:  .fill STAT_BUF_CAP, COUNT, VALUE             # выделяем память под методанные (fstat)

read_buf:  .dword 0x0                                   # буффер для чтения из файла
lower_case_buf: .dword 0x0                              # буфер, переведенный в нижний регистр

.text
_start:
    file_open input_file, O_RDONLY, STANDARD_MODE       # открываем исходный файл (a0 - файловый дескриптор)
    li t0, 0x0                                          # t0 = 0x0
    blt a0, t0, open_err                                # a0 < t0 (0x0) - завершение программы с ошибкой
    sd a0, input_fd, t6                                 # сохраняем файловый дескриптор
    
    file_stat a0, stat_buf                              # макрос для получения методанных файла (a0 - файловый дескриптор)
    li t0, 0x0                                          # t0 = 0x0
    blt a0, t0, fstat_err                               # a0 < t0 (0x0) - завершение программы с ошибкой
    get_file_size t1, stat_buf                          # макрос для получения размера файла (t1 = size)
    sd t1, file_size, t6                                # сохраняем размер файла в память 

    malloc PAGE_CAP                                     # выделяем PAGE_CAP байт
    la t6, read_buf                                     # загружаем адрес read_buf в t6
    sd s0, 0(t6)                                        # по адресу read_buf (0(t6)) сохраняем выделенную память
    ld a0, input_fd                                     # загружаем файловый дескприптор
    ld t1, file_size                                    # загружаем размер файла
    file_read a0, read_buf, t1                          # считываем данные из файла в read_buf

    la t6, read_buf                                     # загружаем адрес метки, в которой адрес буффера
    ld t0, 0(t6)                                        # загружаем адрес буффера
    add t0, t0, t1                                      # смещаемся в конец буффера
    sb x0, 0(t0)                                        # гарантируем '\0' в конце

    malloc PAGE_CAP                                     # выделяем память под буффер в нижнем регистре
    la t6, lower_case_buf                               # загружаем адрес метки lower_case_buf
    sd s0, 0(t6)                                        # загружаем по адресу lower_case_buf выделенную память
    
    ld a1, read_buf                                     # загружаем исходный буффер из файла
    ld a2, lower_case_buf                               # загружаем буфер в нижнем регистре
    push_2 a1, a2                                       # сохраняем в стек
    call lowercase_conversion                           # вызываем функцию перевода строки в нижний регистр
    pop_2 a1, a2                                        # возращаем адреса из стека

    file_open output_file, O_RDWR + O_CREAT, STANDARD_MODE  # открывам и при необходимости создаем выходящий файл
    li t0, 0x0                                          # t0 = 0x0
    blt a0, t0, open_err                                # a0 < t0 (0x0) - завершение программы с ошибкой
    sd a0, output_fd, t6                                # сохраняем файловый дескриптор
    
    ld t1, file_size                                    # загружаем размер файла
    ld a0, output_fd                                    # загружаем файловый дескриптор
    file_write a0, lower_case_buf, t1                   # сохраняем данные в файл
    
    ld a0, input_fd                                     # загружаем файловый дескриптор
    file_close a0                                       # закрываем файл
    ld a0, output_fd                                    # загружаем файловый дескриптор
    file_close a0                                       # закрываем файл
    j exit                                              # завершаем программу

open_err:
    la t0, log_open                                     # загружаем адрес по которому находиться лог
    li t1, LOG_OPEN_LEN                                 # загружаем длину лога
    print t0, t1                                        # печатаем лог
    j exit                                              # завершаем программу

fstat_err:
    la t0, log_fstat                                    # загружаем адрес по которому находится лог
    li t1, LOG_FSTAT_ERR                                # загружаем длину лога
    print t0, t1                                        # печатаем лог
    j exit

exit:
    li a7, 93                                           # системный вызов завершения программы
    li a0, 0                                            # код ошибки
    ecall                                               # вызов Linux
