CC = riscv64-linux-gnu-gcc
LD = riscv64-linux-gnu-ld

LD_FLAGS = -nostdlib -static
CC_FLAGS = -c

OUT = result
ASM_FILE = simple.s
OBJECTS = $(ASM_FILE:.s=.o)

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
%.o: %.s
	 $(CC) $(DEBUG_FLAGS) $(CC_FLAGS) $< -o $@

clean:
	rm *.o
	rm $(OUT)
