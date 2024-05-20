cmake_minimum_required (VERSION 3.29)

set(
    ASM_FILES ${ASM_FILES}
    src/arch/riscv64/boot.s
)

set(
    C_FILES ${C_FILES} 
    src/arch/riscv64/debug.c
)

file(GLOB LINKER_SCRIPT src/arch/riscv64/linker.ld)
set(TARGET_TRIPLE riscv64-none-elf)