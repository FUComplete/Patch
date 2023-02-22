FileLoader:
    ; Backup registers...
    lw      v1,0x4(s0)
    addiu   sp,sp,-0x30
    sw      s3,0x2C(sp)
    sw      s1,0x28(sp)
    sw      s0,0x24(sp)
    sw      a3,0x20(sp)
    sw      a2,0x1C(sp)
    sw      a1,0x18(sp)
    sw      a0,0x14(sp)
    sw      v1,0x10(sp)
    sw      v0,0xC(sp)

@@FileCheckChunk:
    ; Check if str_tbl.pac is being loaded (0xF)
    vla     v1,ValStore
    lh      v1,0x0(v1)
    li      a1,0xF  ; Branch if strings file... can't alter once loaded
    beq     v1,a1,@@StringsPatch
    nop
    ; Check if a2 = 0x20000, if it does skip 
    lui     a0,0x2
    beq     a0,a2,@@PrepFilePatchNRN
    nop

@@FileBinCheck:
    ; Check if the current file being loaded is flagged in file.bin for replace
    vla     v0,filewlAddr
    vla     v1,ValStore
    lh      a0,0x0(v1)
    li      a1,0x8
    div     a0,a1
    nop
    nop
    mflo    a1
    add     v0,a1,v0
    mfhi    a1
    lb      a0,0x0(v0)
    srlv    a1,a0,a1
    andi    v0,a1,0x1
    beq     v0,zero,@@PrepFilePatchNR
    nop

@@FileReplace:
    ; Calculate size based on v0+a2, store the result in ValStore @ 0x4
    lw      v0,0xC(sp)
    addu    a1,a2,v0
    sw      a1,0x4(v1)
    ; Check which path to load from (ms0/disc0)
    la      a0,configAddr
    lb      v0,0x4(a0)
    beq     v0,zero,. + 0x18
    nop
    la      a0,FileReplacerPathEx
    vj      . + 0x10
    nop
    la      a0,FileReplacerPathIn    
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; if file doesnt exist, bypass and continue
    la      v1,0x80010002
    beq     v0,v1,. + 0x3C
    ; write it
    move    s0,v0
    move    a0,v0
    vla     v1,ValStore
    lw      a1,0x10(sp)
    lw      a2,0x4(v1)
    jal     sceIoRead
    nop
    jal     sceIoClose
    move    a0,s0
    vj      @@PrepFilePatchRF
    nop    
    jal     sceIoClose
    move    a0,s0
    vj      @@PrepFilePatchNR
    nop    

; We have to patch strings here because patching *after* its written to its final location
; causes crashing on real hardware for some stupid reason...
@@StringsPatch:
    ; True ele/status string fix
    lui     v1,0x0
    bne     v0,v1,@@LoaderVerStringReplace
    nop
    vla     a0,configAddr
    lb      a1,0x6(a0)
    beq     a1,zero,@@PrepFilePatchNRN
    nop
    li      a1,0x20
    vla     a0,0x08B28445
    sb      a1,0x0(a0)
    sb      a1,0x17(a0)
    b       @@PrepFilePatchNRN
    nop

@@LoaderVerStringReplace:
    lui     v1,0x6
    bne     v0,v1,@@PrepFilePatchNRN
    nop
    vla     a0,0x08B2E194
    vla     a1,configAddr + 0x10
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    lw      a2,0x4(a1)
    sw      a2,0x4(a0)
    b       @@PrepFilePatchNRN
    nop

@@PrepFilePatchRF:
    ; File has been replaced at this point... 
    lw      s3,0x2C(sp)
    lw      s1,0x28(sp)
    lw      s0,0x24(sp)
    lw      a3,0x20(sp)
    lw      a2,0x1C(sp)
    lw      a1,0x18(sp)
    lw      a0,0x14(sp)
    lw      v1,0x10(sp)
    lw      v0,0xC(sp)
    addiu   a1,s1,0x1208
    lw      a2,0x8(s0)
    addiu   a1,a1,0x7FF8
    addu    a0,v1,v0
    move    v0,a0
    j       FilePatcher
    addiu   sp,sp,0x30

@@PrepFilePatchNR:
    ; Since file not replaced, we execute the original code to load the last
    ; chunk before jumping to FilePatcher
    lw      s3,0x2C(sp)
    lw      s1,0x28(sp)
    lw      s0,0x24(sp)
    lw      a3,0x20(sp)
    lw      a2,0x1C(sp)
    lw      a1,0x18(sp)
    lw      a0,0x14(sp)
    lw      v1,0x10(sp)
    lw      v0,0xC(sp)
    addiu   a1,s1,0x1208
    lw      a2,0x8(s0)
    addiu   a1,a1,0x7FF8
    jal     memcpy
    addu    a0,v1,v0
    j       FilePatcher
    addiu   sp,sp,0x30

@@PrepFilePatchNRN:
    ; Chunk size = 0x20000, thus we continue the original function and skip
    ; file patcher until chunk size is less than 0x20000
    lw      s3,0x2C(sp)
    lw      s1,0x28(sp)
    lw      s0,0x24(sp)
    lw      a3,0x20(sp)
    lw      a2,0x1C(sp)
    lw      a1,0x18(sp)
    lw      a0,0x14(sp)
    lw      v1,0x10(sp)
    lw      v0,0xC(sp)
    addiu   a1,s1,0x1208
    lw      a2,0x8(s0)
    addiu   a1,a1,0x7FF8
    jal     memcpy
    addu    a0,v1,v0
    j       0x0884E708
    addiu   sp,sp,0x30