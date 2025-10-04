// kernel.c
#include <stdint.h>
#include "../Libs/Graphics.dll"
#include "../Libs/Input.dll"
#include "../Libs/WindowManager.dll"
#include "../Libs/Taskbar.dll"

void kmain() {
    clear_screen(0x00C0C0); // retro background
    init_input();
    init_window_manager();
    init_taskbar();

    // Open demo windows
    open_window("QuickPad", 10,10,60,20);
    open_window("Navigator", 20,15,60,20);

    while(1) {
        process_input();
        draw_windows();
        draw_taskbar();
    }
}
