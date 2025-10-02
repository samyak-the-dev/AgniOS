BITS 16
ORG 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Text mode first
    mov ah, 0x0
    mov al, 0x03
    int 0x10

    ; Print boot text
    mov si, boot_text
    call print_text_centered

    ; Switch to 320x200 graphics mode
    mov ah, 0x00
    mov al, 0x13
    int 0x10

    ; Initialize spinner
    xor bx, bx ; spinner index

spinner_loop:
    call draw_spinner
    call delay
    inc bx
    jmp spinner_loop

; -------------------
print_text_centered:
    mov bx, 40
.next_char:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0F
    mov cx, bx
    mov dx, 5
    int 0x10
    inc bx
    jmp .next_char
.done:
    ret

boot_text db "Booting into AgniOS",0

; -------------------
draw_spinner:
    ; simple 12-dot spinner around (160,100)
    mov di, 0xA000
    ; pseudo-code, real graphics spinner can be added
    ret

delay:
    mov cx, 0xFFFF
.delay1:
    loop .delay1
    ret

times 510-($-$$) db 0
dw 0xAA55
