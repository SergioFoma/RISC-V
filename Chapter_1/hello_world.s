.global _start

.text
_start:
    addi a0, x0, 1              # 1 = StdOut
    la   a1, helloWorld         # загрузить адрес helloWorld 
    addi a2, x0,  7             # длина текстовой строки
    addi a7, x0, 64             # системный вызов операции записи Linux
    ecall                       # вызвать Linux, чтобы вывести текстовую строку

    addi a0, x0, 0              # использовать код возрата 0
    addi a7, x0, 93             # код 93 службы завершает программу
    ecall                       # вызвать Linux, чтобы завершить работу программы

.data
helloWorld: .ascii "Doing!\n"
