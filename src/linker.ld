SECTIONS {
    /* 
        default loadAddr env of visionfive 2 u-boot
    */
    . = 0x60000000;

    .text.boot ALIGN(4096): {  
        *(.text.boot)
    }
} 

ENTRY(_entrypoint)