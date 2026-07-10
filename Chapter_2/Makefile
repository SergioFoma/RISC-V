CC = riscv64-linux-gnu-gcc
LD = riscv64-linux-gnu-ld

LD_FLAGS = -nostdlib -static
CC_FLAGS = -c

ASM_FILES = code_snippets.s
OBJECTS = $(ASM_FILES:.s=.o)
OUT = result

ifdef DEBUG
DEBUG_FLAG = -g
else
DEBUG_FLAG =
endif

.PHONY: clean

$(OUT): $(OBJECTS)
	$(LD) $(LD_FLAG) $(OBJECTS) -o $(OUT)

%.o: %.s
	$(CC) $(DEBUG_FLAG) $(CC_FLAGS) $< -o $@

clean:
	rm *.o
	rm $(OUT)
