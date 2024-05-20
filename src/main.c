#include <stdbool.h>
#include <stdint.h>

#include "debug.h"


void k_entry() {
    const int64_t sx = -2137;
    const uint64_t x = 0xdeadbeef;
    k_printf("integer: %i\nunsigned: %u %x %X\n", sx, x, x, x);

    while (true) {
        asm (
            "wfi;"
        );
    }
}