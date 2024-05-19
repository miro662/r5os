.section .text.boot

// Main entrypoint to R5OS
.global _entrypoint
_entrypoint:
    // reset memory management
    csrw satp, zero

    // set stack pointer to zero
    la sp, _stack_end
    
    tail kmain
