.section .bss
    .lcomm buffer, 128

.equ len, 128

.section .rodata

hello:
    .ascii "Hello, world!\n\0"

bye:
    .ascii "Bye, world!\n\0"

.section .data

    # Structure to hold 2 seconds and 0 nanoseconds
    timespec:
        .quad 2              # 2 seconds
        .quad 0              # 0 nanoseconds

.section .text

.global main

main:
    push %rbp
    mov %rsp, %rbp


    # TODO: print "Hello, world!"
    # write(1, hello, 14)
    mov 1, %rdi
    mov hello, %rsi
    mov 14, %rdx
    mov 1, %rax
    syscall

    # TODO: print "Bye, world!"
    # write(1, bye, 12)
    mov 1, %rdi
    mov bye, %rsi
    mov 12, %rdx
    mov 1, %rax
    syscall

    # TODO: read from buffer
    # read(0, buffer, len)
    mov 0, %rdi
    mov buffer, %rsi
    mov len, %rdx
    mov 0, %rax
    syscall

    # TODO: print the content of buffer
    # write(1, buffer, rax)
    mov 1, %rdi
    mov buffer, %rsi
    mov %rax, %rdx
    mov 1, %rax
    syscall

    # TODO: sleep for 2 seconds using nanosleep
    # nanosleep(timespec, NULL)
    mov timespec, %rdi
    mov 0, %rsi
    mov 35, %rax
    syscall

    # TODO: exit
    # exit_group(0)
    mov 0, %rdi
    mov 231, %rax
    syscall

    leave
    ret
