; hook: 09A5AE14
; ins:
;    seb a0,a2
;    addiu v1,v1,a0
; reg:
    ; v0  config byte address
    ; v1  config value
    ; a0  ???
    ; a1  config option ID (5 is background loading)
    ; a2  ???
    ; a3  ??? (0x3?)
    ; t0  ???
    ; t1  ???
    ; backup s0, s1, s3
nativePSPToggle:
    addiu   sp,sp,-0x30
    sw      s3,0x2C(sp)
    sw      s1,0x28(sp)
    sw      s0,0x24(sp)
    sw      t1,0x20(sp)
    sw      t0,0x1C(sp)
    sw      a3,0x18(sp)
    sw      a2,0x14(sp)
    sw      a1,0x10(sp)
    sw      v1,0xC(sp)
    sw      v0,0x8(sp)
    li      a0,0x5
    bne     a0,a1,nativePSPToggleEND
    nop
    la      v0,MLConfigBin
    bne     v1,zero,nativePSPOFF
    nop

nativePSPON:
    ; Since v1 = 0 we turn on nativePSP
    li      v1,0x1
    sb      v1,0x10(v0)
    b       nativePSPConfigWrite
    nop

nativePSPOFF:
    ; Since v1 = 1 we turn off nativePSP
    li      v1,0x0
    sb      v1,0x10(v0)

nativePSPConfigWrite:
    la      a0,ConfigPathWriteBack
    li      a1,0x202
    li      a2,0x1B6
    jal     sceIoOpen
    li      a3,0x0
    move    s0,v0
    move    a0,v0
    la      a1,MLConfigBin
    li      a2,64
    jal     sceIoWrite
    li      a3,0x0
    jal     sceIoClose
    move    a0,s0    

nativePSPToggleEND:
    lw      s3,0x2C(sp)
    lw      s1,0x28(sp)
    lw      s0,0x24(sp)
    lw      t1,0x20(sp)
    lw      t0,0x1C(sp)
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      v1,0xC(sp)
    lw      v0,0x8(sp)
    addiu   sp,sp,0x30
    seb     a0,a2
    addu    v1,v1,a0
    j       0x09A5AE1C
    nop

ConfigPathWriteBack:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/CONFIG.BIN",0x0
    .align  0x4