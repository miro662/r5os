SECTIONS {
    /* 
        default loadAddr env of visionfive 2 u-boot
    */
    . = 0x60000000;

    .text.boot ALIGN(4096): {  
        *(.text.boot)
    }

    .text ALIGN(4096): {
        *(.text)
        *(.text.*)
    }

    .data ALIGN(4096): {
        *(.data)
        *(.data.*)
    }

    .rodata ALIGN(4096): {
        *(.rodata)
        *(.rodata.*)
    }

    .bss ALIGN(4096): {
        _bss_start = .;
        *(.bss)
        *(.bss.*)
        _stack_end = .;
        . = . + 0x10000;
        _bss_end = .;
    }
} 

ENTRY(_entrypoint)