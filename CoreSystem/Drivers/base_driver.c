#include "base_driver.h"

void framebuffer_init() {
    
}

void draw_pixel(int x, int y, uint32_t color) {
    volatile uint32_t* framebuffer = (volatile uint32_t*)0xA0000;
    framebuffer[y*320 + x] = color;
}

