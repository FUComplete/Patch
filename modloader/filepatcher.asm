FilePatcher:
    ; Backup registers again
    addiu   sp,sp,-0x20
    sw      a3,0x18(sp)
    sw      a2,0x14(sp)
    sw      a1,0x10(sp)
    sw      a0,0xC(sp)
    sw      v1,0x8(sp)  ; Stores file base position
    sw      v0,0x4(sp)

@@CheckFileID:
    ; Check if the FileID matches for patching
    vla     v0,ValStore
    lh      a0,0x0(v0)
    ; li      a1,0x2B ; 0043 - demo_task.ovl
    ; beq     a0,a1,@@DemoTaskPatch
    ; li      a1,0x2C ; 0044 - edit_task.ovl
    ; beq     a0,a1,@@EditTaskPatch
    ; li      a1,0x2D ; 0045 - cont_task.ovl
    ; beq     a0,a1,@@ContTaskPatch
    ; li      a1,0x2E ; 0046 - option_task.ovl
    ; beq     a0,a1,@@OptionTaskPatch
    li      a1,0x32 ; 0050 - lobby_task.ovl
    beq     a0,a1,@@LobbyTaskPatch
    li      a1,0x33 ; 0x51 - game_task.ovl
    beq     a0,a1,@@GameTaskPatch
    li      a1,0x35 ; 0053 - arcade_task.ovl
    beq     a0,a1,@@ArcadeTaskPatch
    ; li      a1,0x38 ; 0056 - game_sub.ovl
    ; beq     a0,a1,@@GameSubPatch
    nop
    ; Restore Reg
    b       @@FilePatcherRR
    nop

; ----------------------------------------------

; @@DemoTaskPatch:
;     b       @@FilePatcherRR
;     nop

; ----------------------------------------------

; @@EditTaskPatch:
;     b       @@FilePatcherRR
;     nop

; ----------------------------------------------

; @@ContTaskPatch:
;     b       @@FilePatcherRR
;     nop

; ----------------------------------------------

; @@OptionTaskPatch:
;     b       @@FilePatcherRR
;     nop

; ----------------------------------------------

@@LobbyTaskPatch:
    ; Event quest read check
    la      v0,0x09A822E8
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    la      a0,EventQuestsRead
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Event quest cap check
    la      v0,0x09A835B0
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    la      a0,EventQuestsCap
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Event quest realloc
    la      v0,0x09A834F8
    la      a0,QuestReallocCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    ; Drink buff instruction redirect
    la      v0,0x09AA734C
    la      a0,GHDrinkCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Guildhall chest detect (also affects farm/kitchen)
    la      v0,0x09AA8DE8
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    sw      zero,0xC(v0)
    li      a0,0x17
    sh      a0,0x10(v0)
    la      a0,GHChestCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Restore Reg
    b       @@FilePatcherRR
    nop

; ----------------------------------------------

@@GameTaskPatch:
    ; HH Rework patches
    la      v0,configAddr
    lb      a0,0xC(v0)
    beq     a0,zero,@@FilePatcherRR
    la      v0,0x09BAC0B8
    la      a0,0x27BDFFE0   ; addiu sp,sp,-0x20
    la      a1,0xAFA70018   ; sw    a3,0x18(sp)
    la      a2,0xAFA60014   ; sw    a2,0x14(sp)
    sw      a0,0x0(v0)
    sw      a1,0x4(v0)
    sw      a2,0x8(v0)
    la      a0,0xAFA50010   ; sw    a1,0x10(sp)
    la      a1,0xAFA4000C   ; sw    a0,0xC(sp)
    la      a2,0xAFA30008   ; sw    v1,0x8(sp)
    sw      a0,0xC(v0)
    sw      a1,0x10(v0)
    sw      a2,0x14(v0)
    la      a0,0xAFA20004   ; sw    v0,0x4(sp)
    sw      a0,0x18(v0)
    la      a0,HHReworkAniChecks
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x1C(v0)     ; j     HHReworkAniChecks
    sw      zero,0x20(v0)   ; nop
    sw      zero,0x24(v0)   ; nop
    ; Fix HH poke MV
    la      v0,0x09BF7900
    li      a0,0x2
    li      a1,0x1F
    li      a2,0x12
    sb      a1,0x2(v0)      ; Left swing MV
    sb      a2,0x14(v0)     ; Left swing KO
    sb      a1,0x1A(v0)     ; Right swing MV
    sb      a2,0x2C(v0)     ; Right swing KO
    sb      a0,0x39(v0)     ; First poke damage type
    sb      a0,0x51(v0)     ; Second poke damage type
    ; Lao/Shen early kill config check
    la      v0,configAddr
    lb      a0,0xD(v0)
    beq     a0,zero,. + 0x2C
    la      v0,0x09AC3148
    ; Lao/Ash check
    sw      zero,0x0(v0)
    sw      zero,0x4(v0)
    sw      zero,0x8(v0)
    sw      zero,0xC(v0)
    ; Shen check
    sw      zero,0x7C(v0)
    sw      zero,0x80(v0)
    sw      zero,0x84(v0)
    sw      zero,0x88(v0)
    ; Restore Reg
    b       @@FilePatcherRR
    nop

; ----------------------------------------------

@@ArcadeTaskPatch:
    ; Challenge quest read 1
    la      v0,0x09A5EF1C
    la      a0,ChallengeQuests
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Challenge quest read 2
    la      v0,0x09A69514
    la      a0,ChallengeQuests + 0x10
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Restore Reg
    b       @@FilePatcherRR
    nop

; ----------------------------------------------

; @@GameSubPatch:
;     b       @@FilePatcherRR
;     nop

; ----------------------------------------------

@@FilePatcherRR:
    ; Restore registers and continue
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      a0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)
    j       0x0884E708
    addiu   sp,sp,0x20

; FilePatcher:
;     j       0x0884E708
;     nop