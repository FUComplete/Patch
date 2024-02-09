; -------------------------------------------------
;                File Loader Code
; -------------------------------------------------

MLFileLoader:
    lw      s1,0x8(sp)
    lw      s0,0x4(sp)
    ; Backup registers
    addiu   sp,sp,-0x30
    sw      s3,0x14(sp)
    sw      s1,0x10(sp)
    sw      s0,0xC(sp)
    sw      v1,0x8(sp)
    sw      v0,0x4(sp)

MLFileChunkCheck:
    ; Checking if we are in a start/mid chunk or end chunk
    lui     s1,0x2
    bne     s1,s0,MLFileBinCheck
    lw      s1,0x10(sp)

MLFileChunkSkip:
    j       0x0884E738
    addiu   sp,sp,0x30

MLFileBinCheck:
    la      a0,MLFileBin
    lh      a1,0x380(a0)    ; loading DataBlock 0x0 (FileID)
    li      a2,0x8
    div     a1,a2
    nop
    nop
    mflo    a3  ; byte to check
    add     a0,a3,a0
    lb      a0,0x0(a0)
    mfhi    a3  ; bitflag check
    srlv    a3,a0,a3
    andi    a0,a3,0x1   ; if 1 then repalce
    beq     a0,zero,MLFilePatcher
    nop

MLFileWriteAddrStore:
    la      a0,MLDataBlock
    lw      a1,0x4(s1)    
    sw      a1,0x4(a0)

MLCheckFileExist:
    la      a0,MLnativePSP
    li      a1,0x1
    li      a2,0x0
    jal     sceIoOpen
    li      a3,0x0
    la      a0,0x80010002
    bne     v0,a0,MLFileReplace
    nop
    b       MLFilePatcher
    nop

MLFileReplace:
    ; Read first 4 bytes that store size.
    move    s0,v0
    move    a0,v0
    li      v1,0x0
    la      a1,MLDataBlock+0x8
    jal     sceIoRead
    li      a2,0x4
    move    v0,s0
    move    a0,s0
    la      a2,MLDataBlock
    lw      a1,0x4(a2)
    lw      a2,0x8(a2)
    jal     sceIoRead
    nop
    jal     sceIoClose
    move    a0,s0

; -------------------------------------------------
;               File Patcher Code
; -------------------------------------------------

MLFilePatcher:
    la      a0,MLDataBlock
    lw      a0,0x0(a0)
    ; begin to check if file matches 
    li      a1,0xF  ; str_tbl.pac
    beq     a0,a1,MLFP0015
    li      a1,0x2E ; option_task.ovl
    beq     a0,a1,MLFP0046
    li      a1,0x32 ; lobby_task.ovl
    beq     a0,a1,MLFP0050
    li      a1,0x33 ; game_task.ovl
    beq     a0,a1,MLFP0051
    li      a1,0x35 ; arcade_task.ovl
    beq     a0,a1,MLFP0053
    nop
    b       MLEndRtn
    nop

MLFP0015:
    ; 0015 = str_tbl.pac
    la      v0,0x089C7510
    la      v1,MLConfigBin
    ; Patch loader version string
    lw      a0,0x50(v0) ; load table that contains the version string
    add     a0,v0,a0
    addiu   a1,a0,0x38  ; load pointer to the specific string
    lbu     a2,0x0(a1)
    lbu     a3,0x1(a1)
    sll     a3,a3,0x8 
    add     a3,a2,a3
    add     a1,a3,a0
    addiu   a1,a1,0x95
    lw      a2,0x0(v1)  ; write the value
    sw      a2,0x0(a1)
    lw      a2,0x4(v1)
    sw      a2,0x4(a1)
    lw      a2,0x8(v1)
    sw      a2,0x8(a1)
    ; Check config and patch for true ele/status
    lb      a0,0x12(v1)
    beq     a0,zero,MLFP0015END
    nop
    li      a2,0x20 ; empty character
    lw      a0,0x714(v0)    ; load pointer to ele string
    add     a0,v0,a0
    addiu   a0,a0,0x64      ; skipping header reading and accounting for offset
    sb      a2,0xA(a0)      ; replace the 0 carry on ele with empty character
    sb      a2,0x21(a0)     ; replace the 0 carry on status with empty character 
MLFP0015END:
    b       MLEndRtn
    nop

MLFP0046:
    ; 0046 = option_task.ovl
    ; Since we are loading options from main menu copy the file loader
    ; setting from config to savedata...
    la      v0,0x09A0077D
    la      v1,MLConfigBin
    lb      a0,0x10(v1)
    sb      a0,0x0(v0)
    ; Patch instruction to jump to config setter for nativePSP
    la      v0,0x09A5AE14
    la      a0,nativePSPToggle
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)

MLFP0046END:
    b       MLEndRtn
    nop

MLFP0050:
    ; 0050 = lobby_task.ovl
    ; Patch ins for GatherFarm
    la      v0,0x09AAA0F0
    la      v1,MLConfigBin
    la      a0,GatherFarm
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    sw      zero,0xC(v0)
    ; Patch ins for QuestReallocCheck
    la      v0,0x09A834F8
    la      a0,QuestReallocCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    ; Patch ins for EventQuestRead
    la      v0,0x09A822E8
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    la      a0,EventQuestRead
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Patch ins for EventQuestCap
    la      v0,0x09A835B0
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    la      a0,EventQuestCap
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Patch ins for GHChestCheck
    la      v0,0x09AA8DE8
    lb      a0,0x1A(v1)
    beq     a0,zero,. + 0x2C
    nop
    lw      a0,0x0(v0)
    sw      a0,0x4(v0)
    la      a0,GHChestCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0xC(v0)
    ; Patch ins for GHChestRotCheck
    la      v0,0x09AA8DF8
    lb      a0,0x1A(v1)
    beq     a0,zero,. + 0x24
    nop
    la      a0,GHChestRotCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    ; Patch ins for GHDrinkCheck
    la      v0,0x09AA734C
    lb      a0,0x1B(v1)
    beq     a0,zero,. + 0x20
    nop
    la      a0,GHDrinkCheck
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)

MLFP0050END:
    b       MLEndRtn
    nop

MLFP0051:
    ; Patch ins for GatherCrouched
    la      v0,0x09A9CBA4
    la      v1,MLConfigBin
    la      a0,GatherCrouched
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    ; Patch ins for GatherStanding
    la      v0,0x09A630C0
    la      a0,GatherStanding
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)
    ; Patch ins for Lao/Shen cap removal
    la      v0,0x09AC3148
    lb      a0,0x19(v1)
    beq     a0,zero,. + 0x28
    nop
    sw      zero,0x0(v0)    ; Lao/Ash check
    sw      zero,0x4(v0)
    sw      zero,0x8(v0)
    sw      zero,0xC(v0)
    sw      zero,0x7C(v0)   ; Shen check
    sw      zero,0x80(v0)
    sw      zero,0x84(v0)
    sw      zero,0x88(v0)
    ; Patch ins for HHReworkAniChecks
    la      v0,0x09BAC0B8
    lb      a0,0x18(v1)
    beq     a0,zero,. + 0xA8
    nop
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

MLFP0051END:
    b       MLEndRtn
    nop

MLFP0053:
    ; Patch ins for ChallengeQuestsAddr1
    la      v0,0x09A5EF1C
    la      a0,ChallengeQuestsAddr1
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    ; Patch ins for ChallengeQuestsAddr2
    la      v0,0x09A69514
    la      a0,ChallengeQuestsAddr2
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)

MLFP0053END:
    b       MLEndRtn
    nop

MLEndRtn:
    lw      s3,0x14(sp)
    lw      s1,0x10(sp)
    lw      s0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)
    move    a0,t0
    move    a1,a0
    move    a2,a0
    move    a3,a0
    addiu   sp,sp,0x30
    j       0x0884E738
    lw      ra,0xC(sp)
 