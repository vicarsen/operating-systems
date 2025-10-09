; SPDX-License-Identifier: BSD-3-Clause

section .text

global read
global write
global getpid
global exit


read:
    push rbp
    mov rbp, rsp

    mov rax, 0
    syscall

    leave
    ret

write:
    push rbp
    mov rbp, rsp

    mov rax, 1
    syscall

    leave
    ret

getpid:
    push rbp
    mov rbp, rsp

    mov rax, 39
    syscall

    leave
    ret

exit:
    push rbp
    mov rbp, rsp

    mov rax, 231
    syscall

    leave
    ret
