CC = riscv64-linux-gnu-gcc
LD = riscv64-linux-gnu-ld

# -nostdlib  - отключает стандартную библиотеку Си
# -static    - собираем статический файл
# --no-relax - запрещаем линковщику оптимизировать переходы и адреса
LD_FLAGS = -nostdlib -static --no-relax
CC_FLAGS = -c

OUT = result
ASM_FILE = main.S lowercase_conversion.S
OBJECTS = $(ASM_FILE:.S=.o)

# GDB DEBUG
ifdef DEBUG
DEBUG_FLAGS = -g
else
DEBUG_FLAGS =
endif

.PHONY: clean

$(OUT): $(OBJECTS)
	$(LD) $(LD_FLAGS) $(OBJECTS) -o $(OUT)

# flag '-c' - dont't use linker
%.o: %.S
	 $(CC) $(DEBUG_FLAGS) $(CC_FLAGS) $< -o $@

clean:
	rm *.o
	rm $(OUT)
