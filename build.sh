#!/bin/sh
nasm -f bin main.asm -o boot.bin
qemu-system-x86_64 -hda boot.bin
