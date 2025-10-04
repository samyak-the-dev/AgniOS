BITS 16
ORG 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; --- Boot screen text ---
    mov si, msg
.print:
    lodsb
    cmp al, 0
    je .boot_done
    mov ah, 0x0E
    mov bx, 0x07
    int 0x10
    jmp .print

.boot_done:
    call load_kernel
    jmp 0x100000

load_kernel:
    ; stub for kernel loading
    ret

msg db "  AgniOS  ",0

times 510-($-$$) db 0
dw 0xAA55
