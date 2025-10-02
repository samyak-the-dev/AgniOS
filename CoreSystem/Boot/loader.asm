BITS 16
ORG 0x7C00

; -------------------
; Bootloader entry
; -------------------
start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Clear screen (text mode first for text)
    mov ah, 0x0
    mov al, 0x03
    int 0x10

    ; Print "Booting into AgniOS"
    mov si, boot_text
    call print_text_centered

    ; Switch to 320x200 graphics mode
    mov ah, 0x00
    mov al, 0x13
    int 0x10

    ; Draw triangle logo in the center
    call draw_triangle

spinner_loop:
    call draw_spinner
    call delay
    jmp spinner_loop

; -------------------
; Text routines
; -------------------
print_text_centered:
    ; Centered text at row 5
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
; Triangle logo (placeholder)
; -------------------
draw_triangle:
    ; Draw a simple filled triangle in the middle of screen
    ; framebuffer starts at 0xA0000 in mode 0x13
    mov di, 0xA000
    ; pseudo-code: loop over rows & columns
    ret

; -------------------
; Dotted circle spinner
; -------------------
spinner_chars db 12 dup(0)  ; will hold precomputed points
spinner_index db 0

draw_spinner:
    ; Clear previous points
    ; Draw 12 points around circle center (160,100)
    ; For simplicity: each point = 1 pixel (white)
    ; Rotate points by updating spinner_index
    ret

; -------------------
delay
; simple busy loop
mov cx, 0xFFFF
.delay1:
loop .delay1
ret

times 510-($-$$) db 0
dw 0xAA55
