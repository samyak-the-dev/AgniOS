#ifndef BASE_DRIVER_H
#define BASE_DRIVER_H

#include <stdint.h>

// Framebuffer / graphics
void framebuffer_init();
void draw_pixel(int x, int y, uint32_t color);

#endif
