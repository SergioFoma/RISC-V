#include <stdio.h>

//
// a0 = empty
// a1 = input
// a2 = output
//
extern int lowercase_conversion(int empty, char* input, char* output); 

const size_t MAX_INPUT_LEN = 255;

int main() {
    char* input = "Test Asm FuNcTiOn In C\n";
    char output[MAX_INPUT_LEN];

    int len = lowercase_conversion(0, input, output);

    printf("input = %s", input);
    printf("output = %s", output);

    return 0;
}
