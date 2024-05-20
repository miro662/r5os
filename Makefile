AS = clang
LD = ld.lld
CC = clang

SOURCE_DIR = src
TARGET_DIR = build

ARCH = riscv64
ARCH_DIR = arch/${ARCH}
SOURCE_ARCH_DIR = ${SOURCE_DIR}/${ARCH_DIR}
TARGET_ARCH_DIR = ${TARGET_DIR}/${ARCH_DIR}

TRIPLE = riscv64-none-elf

CC_ARGS = -target ${TRIPLE} -ffreestanding -Wall
ASM_ARGS = -target ${TRIPLE} -Wall

${TARGET_DIR}/r5os.elf: ${TARGET_ARCH_DIR}/boot.o ${TARGET_DIR}/main.o ${TARGET_DIR}/debug.o ${TARGET_ARCH_DIR}/debug.o ${SOURCE_DIR}/linker.ld
	mkdir -p $(dir $@)
	${LD} ${TARGET_DIR}/arch/riscv64/debug.o ${TARGET_DIR}/debug.o ${TARGET_ARCH_DIR}/boot.o ${TARGET_DIR}/main.o -T${SOURCE_DIR}/linker.ld -o ${TARGET_DIR}/r5os.elf

${TARGET_ARCH_DIR}/boot.o: ${SOURCE_ARCH_DIR}/boot.s
	mkdir -p $(dir $@)
	${AS} -c $^ ${ASM_ARGS} -o $@

${TARGET_DIR}/main.o: ${SOURCE_DIR}/main.c
	mkdir -p $(dir $@)
	${CC} -c $^ ${CC_ARGS} -ffreestanding -o $@

${TARGET_DIR}/debug.o: ${SOURCE_DIR}/debug.c
	mkdir -p $(dir $@)
	${CC} -c $^ ${CC_ARGS} -ffreestanding -o $@

${TARGET_ARCH_DIR}/debug.o: ${SOURCE_ARCH_DIR}/debug.c
	mkdir -p $(dir $@)
	${CC} -c $^ ${CC_ARGS} -ffreestanding -o $@

.PHONY: clean
clean:
	rm -rf build/*
