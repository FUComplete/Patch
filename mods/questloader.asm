; -------------------------------------------------
; Challenge quest address change (arcade_task.ovl)
; -------------------------------------------------

ChallengeQuestsAddr1:
    la      a0,0x08BA4920
    j       0x09A5EF24
    nop

ChallengeQuestsAddr2:
    la      v0,0x08BA4920
    j       0x09A6951C
    nop

; -----------------------------------------------------
; Guildhall event quest address change (lobby_task.ovl)
; -----------------------------------------------------
QuestReallocCheck:
    addiu   sp,sp,-0x10
    sw      a0,0xC(sp)
    ; Check savedata for toggle
    la      a0,0x09A0077E
    lb      a0,0x0(a0)
    beq     a0,zero,QuestLoadInternal
    nop

QuestLoadExternal:
    bnel    v0,zero,. + 0x10
    lw      v0,0x94C(v1)
    b       QuestReallocCheckJREND
    li      v0,0x0
    lui     at,0x14
    ori     at,at,0x2300
    b       QuestReallocCheckEND
    nop

QuestLoadInternal:
    lui     v0,0x8CD
    li      at,0x3EC0

QuestReallocCheckEND:
    lw      a0,0xC(sp)
    j       0x09A83510
    addiu   sp,sp,0x10

QuestReallocCheckJREND:
    lw      a0,0xC(sp)
    jr      ra
    addiu   sp,sp,0x10

; -----------------------------------------------------
; Guildhall event quest read change (lobby_task.ovl)
; -----------------------------------------------------

EventQuestRead:
    addiu   sp,sp,-0x10
    sw      a0,0xC(sp)
    la      a0,0x09A0077E
    lb      a0,0x0(a0)
    beq     a0,zero,EQRInternal
    nop

EQRExternal:
    slti    v0,s3,0x12  ; read 18
    b       EQREND
    nop

EQRInternal:
    slti    v0,s3,0x26  ; read 38

EQREND:
    lw      a0,0xC(sp)
    j       0x09A822F0
    addiu   sp,sp,0x10

; -----------------------------------------------------
; Guildhall event quest cap change (lobby_task.ovl)
; -----------------------------------------------------

EventQuestCap:
    addiu   sp,sp,-0x10
    sw      a0,0xC(sp)
    la      a0,0x09A0077E
    lb      a0,0x0(a0)
    beq     a0,zero,EQCInternal
    nop

EQCExternal:
    slti    v0,s1,0x12
    b       EQCEND
    nop

EQCInternal:
    slti    v0,s1,0x26

EQCEND:
    lw      a0,0xC(sp)
    j       0x09A835B8
    addiu   sp,sp,0x10
