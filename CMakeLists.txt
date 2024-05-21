cmake_minimum_required (VERSION 3.29)

set(CMAKE_SYSTEM_NAME Generic)
project (r5os C ASM)
set(SUPPORTED_ARCH riscv64)

set(CMAKE_C_COMPILER "clang")
set(CMAKE_ASM_COMPILER "clang")
set(CMAKE_LINKER "ld.lld")

set(ASM_FILES)
set(C_FILES src/debug.c src/entry.c)

if(${ARCH} IN_LIST SUPPORTED_ARCH) 
    include(src/arch/${ARCH}/${ARCH}.cmake)
else()
    message( 
        FATAL_ERROR 
        "Unsupported architecture: ${ARCH}\n" 
        "Supported architectures: ${SUPPORTED_ARCH}" 
    )
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -target ${TARGET_TRIPLE} -ffreestanding -nostdlib -Wall")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -target ${TARGET_TRIPLE} -Wall")
set(CMAKE_EXE_LINKER_FLAGS "-T src/arch/riscv64/linker.ld")

add_executable(
    r5os
    ${ASM_FILES} ${C_FILES}
)
set_target_properties(r5os PROPERTIES OUTPUT_NAME r5os.elf)

set(VF2_YMODEM_FILE /dev/ttyUSB0)

add_custom_target(
    vf2_ymodem 
    COMMAND sudo ./scripts/start_ymodem.py /dev/ttyUSB0 r5os.elf
    DEPENDS r5os 
)
