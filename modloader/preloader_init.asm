.org 0x0884D7E4
PreloaderInitHook:
    jal     PreloaderInit
    move    a0,s0

.org 0x089970C8
.area 192,0
PreloaderInit:
    ; Backup the registers v1, a1, and s0
    ; v0 - 0x00000000 
    ; v1 - 0x08B4C600
    ; a1 - DEADBEEF (a1-t7 should be this)
    ; s0 - 0x08B1C600 (once preloader/modloader is done copy s0 -> a0)
    ; Remaining regstore space used to store some variables during preload_init
    addiu   sp,sp,-0x20
    sw      s0,0x1C(sp)
    sw      a1,0x18(sp)
    sw      v1,0x14(sp)
    sw      zero,0x10(sp)
    ; Add preloader exec to FD
    la      a0,PreloaderExecPathEx
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; Check if present
    la      v1,0x80010002
    bne     v0,v1,PreloadWRMem
    nop
    ; Since it failed we store the error so itll write it to external in preload exec...
    sw      v0,0x10(sp)
    li      v0,0x0
    li      v1,0x0
    lw      v1,0x14(sp)
    la      a0,PreloaderExecPathIn     
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; Load preloader size into memory

PreloadWRMem:
    move    s0,v0
    move    a0,v0
    li      v1,0x0
    la      a1,PreloadDataStore
    jal     sceIoRead
    li      a2,0x4
    ; Read remaining file
    move    v0,s0
    move    a0,v0
    la      a1,PreloaderExec
    lw      a2,-0x20(a1)
    jal     sceIoRead
    nop
    ; Close preloader exec in FD
    jal     sceIoClose
    move    a0,s0
    jal     sceKernelDcacheWritebackInvalidateAll
    nop
    j       PreloaderExec
    nop
.endarea

.org 0x08997188
.area 64,0
PreloaderExecPathIn: 
    .ascii  "disc0:/FUC/PRELOAD.BIN"
    .align  0x4
PreloaderExecPathEx: 
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/PRELOAD.BIN"
    .align  0x4
.endarea