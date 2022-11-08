nasm -f bin main.asm -o boot.bin
"C:\Program Files\qemu\qemu-system-x86_64.exe" -hda boot.bin 
