MC = llvm-mc
LD = ld.lld

SOURCE_DIR = src
TARGET_DIR = build

${TARGET_DIR}/r5os.elf: dir ${TARGET_DIR}/boot.o ${SOURCE_DIR}/linker.ld
	${LD} ${TARGET_DIR}/boot.o -T${SOURCE_DIR}/linker.ld -o ${TARGET_DIR}/r5os.elf

${TARGET_DIR}/boot.o: ${SOURCE_DIR}/boot.s
	${MC} ${SOURCE_DIR}/boot.s --arch=riscv64 --filetype=obj -o ${TARGET_DIR}/boot.o

dir:
	mkdir -p build

.PHONY: clean
clean:
	rm -rf build
