#!/bin/bash
mkdir -p bin

nasm -f bin ../CoreSystem/Boot/loader.asm -o bin/boot.bin
gcc -m64 -ffreestanding -c ../CoreSystem/Kernel/*.c -o bin/kernel.o
gcc -m64 -ffreestanding -c ../CoreSystem/Drivers/*.c -o bin/driver.o
gcc -m64 -ffreestanding -c ../Applications/*/*.c -o bin/apps.o

ld -T ../CoreSystem/Kernel/linker.ld -o bin/kernel.bin --oformat binary bin/*.o
cat bin/boot.bin bin/kernel.bin > bin/AgniOS.bin

echo "Build complete!"
