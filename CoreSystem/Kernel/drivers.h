#ifndef DRIVERS_H
#define DRIVERS_H

#include <stdint.h>

typedef struct {
    int x,y;
    uint8_t buttons;
} mouse_state;

extern mouse_state mouse;

void usb_init();
void usb_read_mouse(int* x,int* y,uint8_t* buttons);
void update_mouse();

#endif
