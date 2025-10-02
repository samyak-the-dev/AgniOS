AS = nasm
CC = gcc
LD = ld

CFLAGS = -m32 -ffreestanding -fno-pic -O2 -Wall -Wextra
LDFLAGS = -m elf_i386 -Ttext 0x1000 --oformat binary

BIN_DIR = bin
ISO_DIR = isodir

LOADER_SRC = CoreSystem/Boot/loader.asm
LOADER = $(BIN_DIR)/loader.bin

KERNEL_SRC = CoreSystem/Kernel/kernel.c
KERNEL_OBJ = $(BIN_DIR)/kernel.o
DRIVERS_KERNEL_OBJ = $(BIN_DIR)/drivers.o
DRIVERS_BASE_OBJ = $(BIN_DIR)/base_driver.o
KERNEL_BIN = $(BIN_DIR)/kernel.bin

OS_IMG = AgniOS.iso

# Default target
all: $(OS_IMG)

# Bootloader
$(LOADER): $(LOADER_SRC) | $(BIN_DIR)
	$(AS) -f bin $< -o $@

# Kernel
$(KERNEL_OBJ): $(KERNEL_SRC) | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Drivers
$(DRIVERS_KERNEL_OBJ): CoreSystem/Kernel/drivers.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(DRIVERS_BASE_OBJ): CoreSystem/Drivers/base_driver.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link kernel + drivers
$(KERNEL_BIN): $(KERNEL_OBJ) $(DRIVERS_KERNEL_OBJ) $(DRIVERS_BASE_OBJ)
	$(LD) $(LDFLAGS) $^ -o $@

# Concatenate loader + kernel into flat image + make ISO
$(OS_IMG): $(LOADER) $(KERNEL_BIN)
	cat $(LOADER) $(KERNEL_BIN) > $(BIN_DIR)/agnios.img
	mkdir -p $(ISO_DIR)
	cp $(BIN_DIR)/agnios.img $(ISO_DIR)/
	genisoimage -R -b agnios.img -no-emul-boot -boot-load-size 4 -o $(OS_IMG) $(ISO_DIR)

# Create bin dir
$(BIN_DIR):
	mkdir -p $@

# Clean
clean:
	rm -rf $(BIN_DIR) $(ISO_DIR) $(OS_IMG)