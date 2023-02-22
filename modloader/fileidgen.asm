CheckFileID:
    ; First backup registers v0-a3, use a2 to store RegStore
    addiu   sp,sp,-0x20
    sw      t4,0x1C(sp)
    sw      a3,0x18(sp)
    sw      a2,0x14(sp)
    sw      a1,0x10(sp)
    sw      a0,0xC(sp)
    sw      v1,0x8(sp)
    sw      v0,0x4(sp)
    ; Figure  what the fileID is...
    subu    v0,v1,s3
    srl     v1,v0,0x2
    vla     v0,ValStore
    sh      v1,0x0(v0)

@@AppendIDtoPATH:
    ; Write the fileID to PATH
    vla     v0,FileReplacerPathEx + 0x15
    li      a2,0x30
    sb      a2,0x0(v0)
    li      a0,0x3E8
    div     v1,a0
    nop
    nop
    mflo    a3 
    beq     a3,zero,. + 0x14
    mfhi    v1
    add     a3,a2,a3
    sb      a3,0x0(v0)
    nop
    li      a2,0x30
    sb      a2,0x1(v0)
    li      a0,0x64
    div     v1,a0
    nop
    nop
    mflo    a3
    beq     a3,zero,. + 0x14
    mfhi    v1
    add     a3,a2,a3
    sb      a3,0x1(v0)
    nop
    li      a2,0x30
    sb      a2,0x2(v0)
    li      a0,0xA
    div     v1,a0
    nop
    nop
    mflo    a3
    add     a3,a2,a3 
    sb      a3,0x2(v0)
    mfhi    v1
    add     v1,a2,v1
    sb      v1,0x3(v0)
    ; write to internal path
    lb      a2,0x0(v0)
    sb      a2,0x20(v0)
    lb      a2,0x1(v0)
    sb      a2,0x21(v0)
    lb      a2,0x2(v0)
    sb      a2,0x22(v0)
    lb      a2,0x3(v0)
    sb      a2,0x23(v0)
    ; Restore the Regs
    lw      t4,0x1C(sp)
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      a0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)
    ; Finish the original instruction before returning
    lw      v1,0x2AC0(v1)
    lw      v0,-0x6DC0(v0)
    j       0x0884E160
    addiu   sp,sp,0x20
