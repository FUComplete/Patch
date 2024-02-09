; Hold to gather... 
; ---------------------------------
; Carve Counter
; ---------------------------------

CarveCounter:
    addiu   v1,a0,-0x1
    addiu   sp,sp,-0x10
    sw      a0,0xC(sp)
    la      a0,MLDataBlock
    sb      v1,0xC(a0)
    lw      a0,0xC(sp)
    addiu   sp,sp,0x10
    j       0x0886CFF0
    sh      v1,0x12(s0)

; ---------------------------------
; Gathering (Crouched)
; ---------------------------------

GatherCrouched:
    li      a2,0x20
    lbu     a3,0x481(a0)    ; face button check, 0x20 = circle
    bne     a2,a3,GatherCEND
    li      a2,0x1D
    lbu     a1,0x299(a0)
    li      a2,0x5D ; Plant
    beq     a1,a2,GatherCEND
    nop
    li      a2,0x60 ; Carve
    beq     a1,a2,GatherCCarve
    nop
    b       GatherCEND
    li      a2,0x1D

GatherCCarve:
    la      a1,MLDataBlock
    lb      a1,0xC(a1)  ; Check CarveCounter stored value for remaining carves
    bne     a1,zero,GatherCEND
    nop
    li      a2,0x1D

GatherCEND:
    j       0x09A9CBAC
    li      a1,0x0

; ---------------------------------
; Gathering (Standing)
; ---------------------------------

GatherStanding:
    addiu   sp,sp,-0x20
    sw      a3,0x1C(sp)
    sw      a2,0x18(sp)
    sw      a1,0x14(sp)
    sw      a0,0x10(sp)
    ; load animation ID  
    lhu     a0,0x298(s4)
    li      a1,0x5200   ; bug
    beq     a0,a1,GatherSMineNet
    li      a1,0x5100   ; mine
    beq     a0,a1,GatherSMineNet
    li      a1,0x4A00   ; carve
    beq     a0,a1,GatherSCarve
    li      a1,0x4700   ; plant
    beq     a0,a1,GatherSPlant
    nop
    b       GatherSZero
    nop

GatherSMineNet:
    ; Check if button is held
    li      a0,0x80
    lbu     a1,0x481(s4)    ; face button check, 0x80 = square
    bne     a0,a1,GatherSZero  
    ; Check item wheel if its a bugnet or a pickaxe
    lb      a2,0x648(s4)
    sll     a2,a2,0x2
    la      a3,0x09A00846
    addu    a3,a2,a3
    lhu     a2,0x0(a3)
    ; Checking bugnets
    li      a3,0x4C9    ; Fish Bugnet
    beq     a2,a3,GatherSEND
    li      a3,0x96     ; Mega Bugnet
    beq     a2,a3,GatherSEND
    li      a3,0x95     ; Bugnet
    beq     a2,a3,GatherSEND
    li      a3,0x94     ; Old Bugnet
    beq     a2,a3,GatherSEND
    ; Checking pickaxes
    li      a3,0x4CA    ; Fish Pickaxe
    beq     a2,a3,GatherSEND
    li      a3,0x92     ; Mega Pickaxe
    beq     a2,a3,GatherSEND
    li      a3,0x91     ; Iron Pickaxe
    beq     a2,a3,GatherSEND
    li      a3,0x90     ; Old Pickaxe
    beq     a2,a3,GatherSEND
    nop
    ; If none are present then zero out
    b       GatherSZero
    nop

GatherSCarve:
    ; Check if button is held
    li      a0,0x20
    lbu     a1,0x481(s4)    ; face button check, 0x20 = circle
    bne     a0,a1,GatherSZero  
    ; Check carves
    la      a2,MLDataBlock
    lb      a2,0xC(a2)  ; Check CarveCounter stored value for remaining carves
    bne     a2,zero,GatherSEND
    nop
    b       GatherSZero
    nop

GatherSPlant:
    ; Check if button is held
    li      a0,0x20
    lbu     a1,0x481(s4)    ; face button check, 0x20 = circle
    beq     a0,a1,GatherSEND
    nop

GatherSZero:
    ; zero out since either we didnt hold O or not in a flagged animation
    sb      zero,0x298(s4)
    sb      zero,0x299(s4)

GatherSEND:
    lw      a3,0x1C(sp)
    lw      a2,0x18(sp)
    lw      a1,0x14(sp)
    lw      a0,0x10(sp)
    j       0x09A630C8
    addiu   sp,sp,0x20

; ---------------------------------
; Gathering (Farm)
; ---------------------------------

GatherFarm:
    addiu   sp,sp,-0x20
    sw      a3,0x1C(sp)
    sw      a2,0x18(sp)
    sw      a1,0x14(sp)
    sw      a0,0x10(sp)
    ; Check if we are in farm
    li      a1,0x2E ; farm stageID
    lbu     a2,0x29A(s0)
    bne     a1,a2,GatherFZero
    li      a1,0x80
    lbu     a2,0x481(s0)    ; Check button if pressed
    bne     a1,a2,GatherFZero
    lhu     a1,0x298(s0)
    li      a2,0x108    ; Bugnet
    beq     a1,a2,GatherFEND
    li      a2,0x8      ; Mine
    beq     a1,a2,GatherFEND
    nop

GatherFZero:
    sb      zero,0x298(s0)
    sb      zero,0x299(s0)

GatherFEND:
    lw      a3,0x1C(sp)
    lw      a2,0x18(sp)
    lw      a1,0x14(sp)
    lw      a0,0x10(sp)
    j       0x09AAA0F8
    addiu   sp,sp,0x20