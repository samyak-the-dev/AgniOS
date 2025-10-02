#include "base_driver.h"

volatile uint8_t* VGA = (volatile uint8_t*)0xA0000;

void framebuffer_init() {
    for(int i=0;i<320*200;i++)
        VGA[i] = 0; // clear screen
}

void draw_pixel(int x,int y,uint8_t color){
    if(x<0||x>=320||y<0||y>=200) return;
    VGA[y*320 + x] = color;
}
