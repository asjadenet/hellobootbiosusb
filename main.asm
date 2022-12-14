bits 16

boot:
    jmp main
    TIMES 3-($-$$) DB 0x90   ; Support 2 or 3 byte encoded JMPs before BPB.

    ; Dos 4.0 EBPB 1.44MB floppy
    OEMname:           db    "mkfs.fat"  ; mkfs.fat is what OEMname mkdosfs uses
    bytesPerSector:    dw    512
    sectPerCluster:    db    1
    reservedSectors:   dw    1
    numFAT:            db    2
    numRootDirEntries: dw    224
    numSectors:        dw    2880
    mediaType:         db    0xf0
    numFATsectors:     dw    9
    sectorsPerTrack:   dw    18
    numHeads:          dw    2
    numHiddenSectors:  dd    0
    numSectorsHuge:    dd    0
    driveNum:          db    0
    reserved:          db    0
    signature:         db    0x29
    volumeID:          dd    0x2d7e5a1a
    volumeLabel:       db    "NO NAME    "
    fileSysType:       db    "FAT12   "

main:
    mov ax, 07C0h       ; Set up 4K stack space after this bootloader
    add ax, 288     ; (4096 + 512) / 16 bytes per paragraph
    mov ss, ax
    mov sp, 4096

    mov ax, 07C0h       ; Set data segment to where we're loaded
    mov ds, ax

    mov al, 00h         ; BIOS text mode. 80x25. 16 colors. 8 pages.
    mov ah, 0
    int 10h

    mov ah, 0Eh         ; BIOS teletype output instruction

    mov al, 'H'
    int 10h
    mov al, 'e'
    int 10h
    mov al, 'l'
    int 10h
    mov al, 'l'
    int 10h
    mov al, 'o'
    int 10h

.loop:
    nop
    jmp .loop


times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
dw 0xAA55
