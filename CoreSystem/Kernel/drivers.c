#include "drivers.h"

mouse_state mouse;

void usb_init() {
    // stub: USB tablet initialization
}

void usb_read_mouse(int* x,int* y,uint8_t* buttons) {
    *x = 160; // center
    *y = 100;
    *buttons = 0;
}

void update_mouse() {
    usb_read_mouse(&mouse.x,&mouse.y,&mouse.buttons);
}
