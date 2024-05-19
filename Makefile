MC = llvm-mc
LD = ld.lld
CC = clang

SOURCE_DIR = src
TARGET_DIR = build

TRIPLE = riscv64-none-elf

${TARGET_DIR}/r5os.elf: ${TARGET_DIR}/boot.o ${TARGET_DIR}/main.o ${SOURCE_DIR}/linker.ld
	${LD} ${TARGET_DIR}/boot.o ${TARGET_DIR}/main.o -T${SOURCE_DIR}/linker.ld -o ${TARGET_DIR}/r5os.elf

${TARGET_DIR}/boot.o: ${SOURCE_DIR}/boot.s
	${MC} ${SOURCE_DIR}/boot.s --triple=${TRIPLE} --filetype=obj -o ${TARGET_DIR}/boot.o

${TARGET_DIR}/main.o: ${SOURCE_DIR}/main.c
	${CC} -c ${SOURCE_DIR}/main.c -target ${TRIPLE} -ffreestanding -o ${TARGET_DIR}/main.o

.PHONY: clean
clean:
	rm -rf build/*
