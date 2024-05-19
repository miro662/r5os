#include <stdarg.h>
#include <stdbool.h>

void putc(char ch) {
    asm volatile (
        "li a7, 0x01;"
        "li a6, 0x00;"
        // a0 = ch because of calling convention
        "scall"
    );
}

void printf(const char* format, ...) {
    va_list ap;
    bool format_mode;
    char* str;
    char ch;

    va_start(ap, format);

    while (*format != '\0') {
        if (format_mode) {
            switch (*format) {
                case 'c':
                    ch = va_arg(ap, int);
                    putc(ch);
                    format_mode = false;
                    break;
                case 's':
                    str = va_arg(ap, char*);
                    while (*str != '\0') {
                        putc(*str);
                        str++;
                    }
                    format_mode = false;
                    break;
            }
        } else if (*format == '%') {
            format_mode = true;
        } else {
            putc(*format);
        }
        ++format;
    }

    va_end(ap);
}

void kmain(void) {
    printf("Hell%c, %s!", 'o', "jan paweł 2");

    while (true) {
        asm (
            "wfi;"
        );
    }
}