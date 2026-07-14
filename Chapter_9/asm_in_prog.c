#include <stdio.h>

const size_t MAX_INPUT_LEN = 255;

int main() {
    char* input = "AsM iN C pRoGrAm";
    char output[MAX_INPUT_LEN];
    int len;

   // volatile - команда компилятору, что блок не нужно оптимизировать, перемещать ...
   asm volatile (
        "mv t0, %2\n"                                           
        "# Перевод в нижний регистр\n"
        "do_while_start:\n"
        "lb t2, 0(%1)\n"                                        
        "addi %1, %1, 1\n"                                      
        "li t3, 'A'\n"                                          
        "blt t2, t3, do_while_else\n"                           
        "li t3, 'Z'\n"                                          
        "blt t3, t2, do_while_else\n"                           
        "main_cycle:\n"
        "addi t2, t2, ('a' - 'A')\n"                            
        "do_while_else:\n"
        "sb t2, 0(%2)\n"                                   
        "addi %2, %2, 1\n"                                      
        "li t3, 0x0\n"                                          
        "bne t2, t3, do_while_start\n"                          
        "addi %2, %2, -1\n"                                     
        "sub %0, %2, t0\n"                                      
        : "=r" (len)                                    // выходные операнды (%0)
        : "r" (input), "r" (output)                     // входные параметры (%1, %2)
        : "t0", "t2", "t3", "a1", "a2"                  // список регистров которые будут заблокированы во время использования
   );

   printf("input = %s\n", input);
   printf("output = %s\n", output);
}
