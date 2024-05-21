#########
Debugging
#########

********
Printing
********

r5os provides basic facilities for printing in kernel mode, built on k_putc platform-specific function:

.. c:function:: void k_putc(char ch)

   :param ch: A character to be printed.
   :header: debug.h

   Prints `ch`. The way it is printed is architecture-specific - it can be written to serial port, shown as a
   next character in a text mode, or even ignored.


.. c:function:: void k_printf(const char* format, ...)

   :param format: Format null-terminated string, in a format described below
   :param ...: Values to be inserted in format string
   :header: debug.h

   Provides basic `printf`-like functionality. Uses :c:func:`k_putc` to print characters.

   It prints characters in :c:var:`format` parameter until `%` is spotted. If `%` is spotted, the behaviour
   depends on the next character:

   * `d` or `i` - assumes that next param to be formatted is an :c:type:`int64_t` and shows it in decimal format.
   * `b` - assumes that next param to be formatted is an :c:type:`uint64_t` and shows it in binary format, prepended by `0b`.
   * `o` - assumes that next param to be formatted is an :c:type:`uint64_t` and shows it in octal format, prepended by `0`.
   * `u` - assumes that next param to be formatted is an :c:type:`uint64_t` and shows it in decimal format.
   * `x` or `X` - assumes that next param to be formatted is an :c:type:`uint64_t` and shows it in hexadecimal format, prepended by `0x`.
   * `c` - assumes that next param to be formatted is an ASCII character and shows it.
   * `s` - assumes that next param to be formatted is a null-terminated string and shows it.
   *  other character - it is printed.

   After printing that character, it returns to printing characters in :c:var:`format` parameter until next `%` is spotted.