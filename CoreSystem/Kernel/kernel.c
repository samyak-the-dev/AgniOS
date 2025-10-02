#include <stdint.h>
#include "../Drivers/base_driver.h"
#include "drivers.h"

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200

typedef struct {
    int x, y;
    uint8_t buttons;
} mouse_state;

mouse_state mouse;

void fill_screen(uint32_t color) {
    for(int y=0;y<SCREEN_HEIGHT;y++)
        for(int x=0;x<SCREEN_WIDTH;x++)
            draw_pixel(x,y,color);
}

void draw_rect(int x,int y,int w,int h,uint32_t color){
    for(int iy=0;iy<h;iy++)
        for(int ix=0;ix<w;ix++)
            draw_pixel(x+ix,y+iy,color);
}

void draw_shutdown_button() {
    draw_rect(5, SCREEN_HEIGHT-25, 60, 20, 0xFFFFFF);
}

void update_mouse() {
    
}

// Kernel main
void kernel_main_c() {
    framebuffer_init();
    fill_screen(0x0000FF);
    draw_rect(0, SCREEN_HEIGHT-20, SCREEN_WIDTH, 20, 0xFFFFFF);
    draw_shutdown_button();

    while(1){
        update_mouse();
        if(mouse.buttons & 1){
            if(mouse.x>=5 && mouse.x<=65 && mouse.y>=SCREEN_HEIGHT-25 && mouse.y<=SCREEN_HEIGHT-5){
                asm volatile("cli; hlt");
            }
        }
    }
}
