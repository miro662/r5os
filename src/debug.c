#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>

#include "debug.h"

static inline void print_uint(uint64_t num, uint8_t radix, char ten);

typedef union {
    char* str;
    char ch;
    uint64_t u_int;
    int64_t s_int;
} printf_data__t;

void k_printf(const char* format, ...) {
    va_list ap;
    bool format_mode;
    printf_data__t arg;

    va_start(ap, format);

    while (*format != '\0') {
        if (format_mode) {
            switch (*format) {
                // signed integer formats
                case 'i':
                case 'd':
                    arg.s_int = va_arg(ap, int64_t);
                    break;

                // unsigned integer formats
                case 'b':
                case 'o':
                case 'u':
                case 'x':
                case 'X':
                    arg.u_int = va_arg(ap, uint64_t);
                    break;

                // other formats
                case 'c':
                    arg.ch = va_arg(ap, int);
                    break;
                case 's':
                    arg.str = va_arg(ap, char*);
                    break;

                default:
                    k_putc(*format);
                    continue;
            }

            switch (*format) {
                // binary
                case 'b':
                    k_printf("0b");
                    print_uint(arg.u_int, 2, '?');
                    break;

                // octal
                case 'o':
                    k_putc('0');
                    print_uint(arg.u_int, 10, '?');
                    break;

                // decimal
                case 'i':
                case 'd':
                    if (arg.s_int < 0) {
                        k_putc('-');
                        arg.s_int = -arg.s_int;
                    }
                    arg.s_int = arg.u_int;
                case 'u':
                    print_uint(arg.u_int, 10, '?');
                    break;

                // hexadecimal
                case 'x':
                    k_printf("0x");
                    print_uint(arg.u_int, 16, 'a');
                    break;
                case 'X':
                    k_printf("0x");
                    print_uint(arg.u_int, 16, 'A');
                    break;

                // other formats
                case 'c':
                    k_putc(arg.ch);
                    break;
                case 's':
                    while (*arg.str != '\0') {
                        k_putc(*arg.str);
                        arg.str++;
                    }
                    break;
            }
            format_mode = false;
        } else if (*format == '%') {
            format_mode = true;
        } else {
            k_putc(*format);
        }
        ++format;
    }

    va_end(ap);
}

static inline void print_uint(uint64_t num, uint8_t radix, char ten) {
    char digit_buf[64];
    char* last_digit;
    last_digit = digit_buf;

    if (num == 0) {
        k_putc('0');
        return;
    }

    while (num != 0) {
        uint8_t digit = num % radix;
        if (digit < 10) {
            *last_digit = (char) digit + '0';
        } else {
            *last_digit = ((char) digit - 10) + ten;
        }
        num /= radix;
        ++last_digit;
    }

    do {
        k_putc(*--last_digit);
    } while (last_digit > digit_buf);
}