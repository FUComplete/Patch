; -------------------------------------------------
; Guildhall chest check
; -------------------------------------------------

GHChestCheck:
    addiu   a0,a0,0x7FF8
    li      a1,0x55
    lb      a2,0x29A(s1)    
    bne     a1,a2,GHChestCheckEND   ; check if in guildhall
    li      a1,0x1
    la      a2,0x09A00E14
    lb      a2,0x0(a2)
    addiu   a2,a2,-0xA
    bne     a2,zero,GHChestCheckEND ; check if online or offline
    li      a1,0x1
    li      a1,0x0

GHChestCheckEND:
    j       0x09AA8DF0
    nop     

; -------------------------------------------------
; Guildhall chest check (rotation)
; -------------------------------------------------

GHChestRotCheck:
    addiu   sp,sp,-0x10
    sw      a1,0xC(sp)
    sw      a0,0x8(sp)
    li      a0,0x55
    lb      a1,0x29A(s1)
    bne     a0,a1,GHChestRotCheckEND    ; check if in guildhall
    li      v1,0x19
    la      a0,0x09A00E14
    lb      a0,0x0(a0)
    addiu   a0,a0,-0xA
    bne     a0,zero,GHChestRotCheckEND  ; check if online or offline
    nop
    li      v1,0x17

GHChestRotCheckEND:
    lw      a1,0xC(sp)
    lw      a0,0x8(sp)
    sw      v1,0x0(s0)
    j       0x09AA8E00
    addiu   sp,sp,0x10

; -------------------------------------------------
; Guildhall drink buff
; -------------------------------------------------

GHDrinkCheck:
    ; First lets backup these registers
    addiu   sp,sp,-0x20
    sw      a3,0x18(sp)
    sw      a2,0x14(sp)
    sw      a1,0x10(sp)
    sw      a0,0xC(sp)
    sw      v1,0x8(sp)
    sw      v0,0x4(sp)
    ; Check if its player state mem we are writing to
    la      a1,0x090AF180
    bne     a0,a1,GHDrinkRRestore
    nop
    ; Check if we've eaten at kitchen
    la      v0,0x099FF09C
    lb      a0,0x23A(v0)
    bne     zero,a0,GHDrinkRRestore
    li      a0,0x3

GHDrinkCatCounter:
    ; Check to see how many chefs we have
    move    v1,v0
    li      a2,0x0
    lb      a1,0x0(v1)
    bne     a0,a1,GHDrinkBoostChk
    nop
    addiu   a2,a2,0x1
    beq     a0,a1,. - 0x10
    addiu   v1,v1,0x70

GHDrinkBoostChk:
    ; a2 contains num of cats
    ; Based on how many chefs we have will set the value
    beq     zero,a2,GHDrinkRRestore   ; 0 chefs
    li      a1,0x4
    slt     at,a1,a2
    beq     at,zero,GHDrinkBoostStam1 ; 1-4 chefs
    nop
    b       GHDrinkBoostStam2 ; 5 chefs
    nop

GHDrinkBoostStam1:
    li      a1,0x4B ; 25 Stamina
    b       GHDrinkBoostHP
    nop

GHDrinkBoostStam2:
    li      a1,0x96 ; 50 Stamina
    b       GHDrinkBoostHP
    nop

GHDrinkBoostHP: ; a0 for hp
    li      a0,0xA
    mult    a2,a0
    mflo    a0

GHDrinkWRBoost:
    li      a2,0x1
    sb      a2,0x23A(v0)
    sb      a1,0x23C(v0)
    sb      a0,0x240(v0)

GHDrinkEFX:
    lw      v1,0x8(sp)
    lui     v0,0x4080   ; Scale
    mtc1    v0,f12
    move    a0,s0
    li      a1,0x0  ; EFX type
    li      a2,0x0  ; Color
    j       0x09AACD8C
    addiu   sp,sp,0x20

GHDrinkRRestore:
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      a0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)
    j       0x09AA7354
    addiu   sp,sp,0x20