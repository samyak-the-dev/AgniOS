#include <stdint.h>
#include "../Drivers/base_driver.h"
#include "drivers.h"

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200

extern mouse_state mouse;

void fill_screen(uint8_t color) {
    for(int y=0;y<SCREEN_HEIGHT;y++)
        for(int x=0;x<SCREEN_WIDTH;x++)
            draw_pixel(x,y,color);
}

void draw_rect(int x,int y,int w,int h,uint8_t color){
    for(int iy=0;iy<h;iy++)
        for(int ix=0;ix<w;ix++)
            draw_pixel(x+ix,y+iy,color);
}

void draw_shutdown_button() {
    draw_rect(5, SCREEN_HEIGHT-25, 60, 20, 0x0F); // white button
}

void kernel_main_c() {
    framebuffer_init();
    fill_screen(0x1F);               // light blue background
    draw_rect(0, SCREEN_HEIGHT-20, SCREEN_WIDTH, 20, 0x0F); // taskbar
    draw_shutdown_button();

    usb_init();

    while(1){
        update_mouse();
        if(mouse.buttons & 1){
            if(mouse.x>=5 && mouse.x<=65 && mouse.y>=SCREEN_HEIGHT-25 && mouse.y<=SCREEN_HEIGHT-5){
                asm volatile("cli; hlt"); // shutdown
            }
        }
    }
}
