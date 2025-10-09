section .bss

    buffer resb 128
    len equ 128

section .data

    ; Structure to hold 2 seconds and 0 nanoseconds
    timespec:
        dq 2              ; 2 seconds
        dq 0              ; 0 nanoseconds

section .rodata

    hello db "Hello, world!", 10, 0
    bye db "Bye, world!", 10, 0

section .text

global main

main:
    push rbp
    mov rbp, rsp

    ; TODO: print "Hello, world!"
    ; write(1, hello, 14)
    mov rdi, 1
    mov rsi, hello
    mov rdx, 14
    mov rax, 1
    syscall

    ; TODO: print "Bye, world!"
    ; write(1, bye, 12)
    mov rdi, 1
    mov rsi, bye
    mov rdx, 12
    mov rax, 1
    syscall

    ; TODO: read from buffer
    ; read(0, buffer, len)
    mov rdi, 0
    mov rsi, buffer
    mov rdx, len
    mov rax, 0
    syscall

    ; TODO: print the content of buffer
    ; write(1, buffer, rax)
    mov rdi, 1
    mov rsi, buffer
    mov rdx, rax
    mov rax, 1
    syscall

    ; TODO: sleep for 2 seconds using nanosleep
    ; nanosleep(timespec, NULL)
    mov rdi, timespec
    mov rsi, 0
    mov rax, 35
    syscall

    ; TODO: exit
    ; exit_group(0)
    mov rdi, 0
    mov rax, 231
    syscall

    xor rax, rax
    leave
    ret
