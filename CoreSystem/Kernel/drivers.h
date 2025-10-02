#ifndef DRIVERS_H
#define DRIVERS_H

#include <stdint.h>

// USB tablet driver functions
void usb_init();
void usb_read_mouse(int* x, int* y, uint8_t* buttons);

#endif
