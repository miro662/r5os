#include "../../cpu.h"

inline void k_wfi() {
    asm (
        "wfi;"
    );
}