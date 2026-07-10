.global app_main

.text
app_main:

# загрузить регистр x5 значением 12345678
    lui x5, 0x12345
    addi x5, x5, 0x678
    
    li x6, 10                   # загрузка x6 = 10

    add x7, x5, x6              # прибавить 10 к x5
    sub x8, x7, x6              # вычесть 10 из x7

    j app_main
