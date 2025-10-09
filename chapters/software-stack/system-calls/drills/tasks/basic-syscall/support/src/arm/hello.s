.section .bss

    .lcomm buffer, 128

    /* 
     * We need to add some padding due to a QEMU bug, present
     * on the 4.2.1 version, that produces a SEGFAULT;
     * the program works perfectly fine otherwise
     */
    .p2align 12

.equ len, 128

.section .rodata

hello:
    .ascii "Hello, world!\n\0"

bye:
    .ascii "Bye, world!\n\0"

.section .text

.global main

main:

    # TODO: print "Hello, world!"
    # write(1, hello, 14)
    mov x0, #1
    ldr x1, =hello
    mov x2, #14
    mov x8, #0x40
    svc #0

    # TODO: exit
    # exit_group(0)
    mov x0, #0
    mov x8, #0x5e
    svc #0
