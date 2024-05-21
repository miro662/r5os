#include <stdbool.h>
#include <stdint.h>

#include "cpu.h"
#include "debug.h"

void k_entry() {
    const int64_t sx = -2137;
    const uint64_t x = 0xdeadbeef;
    k_printf("integer: %i\nunsigned: %b %u %x %X\n", sx, x, x, x, x);

    while (true) {
        k_wfi();
    }
}