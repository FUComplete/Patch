HHReworkAniChecks:
    lb      v0,0x327(s0)
    beq     v0,zero,@@HHAnimCheck00
    li      a0,0x1
    beq     v0,a0,@@HHAnimCheck01
    li      a0,0x4
    beq     v0,a0,@@HHAnimCheck04
    nop
    b       @@HHReturn
    nop

@@HHAnimCheck00:
    lh      v0,0x298(s0)
    li      a0,0x0900   ; Falling (short)
    beq     v0,a0,@@HHReturn
    nop
    b       @@HHRetClearN
    nop

@@HHAnimCheck01:
    lh      v0,0x298(s0)
    li      a0,0x1302   ; KO'd
    beq     v0,a0,@@HHRetClearN
    li      a0,0x1502   ; Sleeped
    beq     v0,a0,@@HHRetClearN
    li      a0,0x1602   ; Paralyzed
    beq     v0,a0,@@HHRetClearN
    li      a0,0x1B02   ; Snowman
    beq     v0,a0,@@HHRetClearN
    li      a0,0x0003   ; Carted
    beq     v0,a0,@@HHRetClearN
    nop
    b       @@HHReturn
    nop

@@HHAnimCheck04:
    lh      v0,0x298(s0)
    li      a0,0x0500   ; Sheath weapon
    beq     v0,a0,@@HHRetClearN
    li      a0,0x0A00   ; Sheath weapon while moving
    beq     v0,a0,@@HHRetClearN
    nop
    b       @@HHReturn
    nop

@@HHRetClearN:
    sh      zero,0x1102(s0)
    sw      zero,0x1104(s0)
    sw      zero,0x1108(s0)

@@HHReturn:
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      a0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)
    jr      ra
    addiu   sp,sp,0x20