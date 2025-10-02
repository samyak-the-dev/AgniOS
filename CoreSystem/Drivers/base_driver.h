#ifndef BASE_DRIVER_H
#define BASE_DRIVER_H

#include <stdint.h>

void framebuffer_init();
void draw_pixel(int x, int y, uint8_t color);

#endif
