.section .text.boot

.global _entrypoint
_entrypoint:
    li a7, 0x01
    li a6, 0x00
    li a0, 0x68
    scall

    j .text.boot
