#include "drivers.h"
#include "../Drivers/base_driver.h"

void usb_init() {
    // initialize USB tablet (stub)
}

void usb_read_mouse(int* x,int* y,uint8_t* buttons) {
    *x = 160; // center placeholder
    *y = 100;
    *buttons = 0;
}
