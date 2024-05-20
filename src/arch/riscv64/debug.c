#include "../../debug.h"

void k_putc(char ch) {
    // use SBI call 0x01 = Console Putchar
    asm volatile (
        "li a7, 0x01;"
        "li a6, 0x00;"
        // a0 = ch because of calling convention
        "scall"
    );
}