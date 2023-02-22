; current memory allocations for preloader code:
; ----------------------------------------------
; preload bank1 - 0x08954C88 size: 0xCB0
; preload bank2 - 0x08955EE8 size: 0xD20
;
; loader.bin - 0x08A4A600
;

; Modify the index load function to jump to our new code
.org 0x0884D7E4
@@FDataIndexIOCall:
    jal     bootFree1 + 0x10
    move    a0,s0

; Set area limits
.org bootFree1
.area 0xCB0
.skip 0x10

; skip backing up v0, as it should be a zero at this point
@@BackupFDataReg:
    addiu   sp,sp,-0x20
    sw      s0,0x1C(sp)
    sw      a3,0x18(sp)
    sw      a2,0x14(sp)
    sw      a1,0x10(sp)
    sw      a0,0xC(sp)
    sw      v1,0x8(sp)
    sw      v0,0x4(sp)

; Load config.bin and loader.bin
@@CheckModConf:
    ; Check if config.bin exists on ms0:/
    la      a0,LoaderConfPathEx
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    la      v1,0x80010002
    bne     v0,v1,@@LoadModConf
    li      v1,0x0
    li      v0,0x0
    lui     v1,0x3
    addu    v1,s0,v1
    ; Load config.bin in disc0:/ since it doesnt exist on ms0:/
    la      a0,LoaderConfPathIn
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0

@@LoadModConf:
    move    s0,v0
    move    a0,v0
    la      a1,configAddr
    la      a2,0x20
    jal     sceIoRead
    nop
    jal     sceIoClose
    move    a0,s0     

@@CheckFileBin:
    ; Check if config.bin exists on ms0:/
    la      a0,FileBinPathEx
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    la      v1,0x80010002
    bne     v0,v1,@@LoadFileBin
    li      v1,0x0
    li      v0,0x0
    lui     v1,0x3
    addu    v1,s0,v1
    ; Load config.bin in disc0:/ since it doesnt exist on ms0:/
    la      a0,FileBinPathIn
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0

@@LoadFileBin:
    move    s0,v0
    move    a0,v0
    la      a1,filewlAddr
    la      a2,0x33A
    jal     sceIoRead
    nop
    jal     sceIoClose
    move    a0,s0 

@@CheckModBin:
    ; Check if loader.bin exists on ms0:/
    la      a0,LoaderBinPathEx
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    la      v1,0x80010002
    bne     v0,v1,@@LoadModBin
    li      v1,0x0
    li      v0,0x0
    lui     v1,0x3
    addu    v1,s0,v1
    ; Load loader.bin in disc0:/ since it doesnt exist on ms0:/
    la      a0,LoaderBinPathIn
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0

@@LoadModBin:
    move    s0,v0
    move    a0,v0
    la      a1,patcherAddr
    lw      a2,-0x20(a1)
    jal     sceIoRead
    nop
    jal     sceIoClose
    move    a0,s0

@@ClearCaches:
    jal     0x0890BB30
    nop
    jal     0x0890BB38
    nop

; ----------------------------------

; Fix savedata/crypto for region specified in config (0x5)

@@QuestBlockDecryptFix:
    vla     a0,0x088C2C50
    li      a1,0x22A0
    sh      a1,0x0(a0)
    addiu   a1,a1,0x10
    sh      a1,0x90(a0)
    li      a1,0x12
    sh      a1,0x88(a0)

@@SaveRegionCheck:
    vla     v0,configAddr
    lb      v1,0x5(v0)
    beq     v1,zero,@@SetDatDirApnd

@@SetFUSaveKeys:
    ; FU Key (1)
    vla     a0,0x089AFF98
    la      a1,FUSaveKey1
    li      v0,0x0
    li      a3,0x14
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    addiu   v0,v0,0x4
    addiu   a0,a0,0x4
    bne     v0,a3,. - 0x10
    addiu   a1,a1,0x4    

@@SetFUSaveKeys2:
    vla     v0,0x088C2384
    la      a1,FUSaveKey2
    lb      a2,0x0(a1)      ; 0x4A
    sb      a2,0x0(v0)
    lb      a2,0x1(a1)      ; 0x1F
    sb      a2,0x20(v0)
    lb      a2,0x2(a1)      ; 0xF3
    sb      a2,0x2C(v0)
    lb      a2,0x3(a1)      ; 0x59
    sb      a2,0x34(v0)
    lb      a2,0x4(a1)      ; 0xAE
    sb      a2,0x3C(v0)
    lb      a2,0x5(a1)      ; 0xB6
    sb      a2,0x44(v0)
    lb      a2,0x6(a1)      ; 0xEF
    sb      a2,0x4C(v0)
    lb      a2,0x7(a1)      ; 0xF8
    sb      a2,0x54(v0)
    lb      a2,0x8(a1)      ; 0x1C
    sb      a2,0x5C(v0)
    lb      a2,0x9(a1)      ; 0xA8
    sb      a2,0x64(v0)
    lb      a2,0xA(a1)      ; 0xCB
    sb      a2,0x6C(v0)
    lb      a2,0xB(a1)      ; 0x23
    sb      a2,0x74(v0)
    lb      a2,0xC(a1)      ; 0xBC
    sb      a2,0x7C(v0)
    lb      a2,0xD(a1)      ; 0xA5
    sb      a2,0x84(v0)
    lb      a2,0xE(a1)      ; 0x7B
    sb      a2,0x8C(v0)
    lb      a2,0xF(a1)      ; 0xB3
    sb      a2,0x94(v0)
    vla     a0,0x088C40A4
    bne     v0,a0,@@SetFUSaveKeys2 + 0x10
    move    v0,a0

@@SetF2SaveKey:
    vla     a0,0x088C3F0C
    la      a1,F2SaveKey
    lb      a2,0x0(a1)      ; 0xB9
    sb      a2,0x0(a0)
    lb      a2,0x1(a1)      ; 0xA9
    sb      a2,0x20(a0)
    lb      a2,0x2(a1)      ; 0x00
    sb      a2,0x2C(a0)
    lb      a2,0x3(a1)      ; 0x9D
    sb      a2,0x34(a0)
    lb      a2,0x4(a1)      ; 0x6F
    sb      a2,0x3C(a0)
    lb      a2,0x5(a1)      ; 0xC2
    sb      a2,0x44(a0)
    lb      a2,0x6(a1)      ; 0xB4
    sb      a2,0x4C(a0)
    lb      a2,0x7(a1)      ; 0xEB
    sb      a2,0x54(a0)
    lb      a2,0x8(a1)      ; 0xF4
    sb      a2,0x5C(a0)
    lb      a2,0x9(a1)      ; 0xF8
    sb      a2,0x64(a0)
    lb      a2,0xA(a1)      ; 0xCA
    sb      a2,0x6C(a0)
    lb      a2,0xB(a1)      ; 0xB2
    sb      a2,0x74(a0)
    lb      a2,0xC(a1)      ; 0xD7
    sb      a2,0x7C(a0)
    lb      a2,0xD(a1)      ; 0x72
    sb      a2,0x84(a0)
    lb      a2,0xE(a1)      ; 0xE9
    sb      a2,0x8C(a0)
    lb      a2,0xF(a1)      ; 0xAB
    sb      a2,0x94(a0)

@@NAorEUCheckFU:
    li      a1,0x1
    vla     v0,0x089AE784
    beq     v1,a1,@@SetFUNAID
    nop

@@SetFUEUID:
    la      a0,FUSaveRegionEU
    vj      @@SetFURegion
    nop

@@SetFUNAID:
    la      a0,FUSaveRegionNA

@@SetFURegion:
    lw      a1,0x0(a0)
    lw      a2,0x4(a0)
    lh      a3,0x8(a0)
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sh      a3,0x8(v0)
    addiu   v0,v0,0x1180
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sh      a3,0x8(v0)
    addiu   v0,v0,0x654
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sh      a3,0x8(v0)

@@NAorEUCheckF2:
    li      a1,0x1
    vla     v0,0x089B0070
    beq     a1,v1,@@SetF2NAID
    nop

@@SetF2EUID:
    la      a0,F2SaveRegionEU
    vj      @@SetF2Region
    nop

@@SetF2NAID:
    la      a0,F2SaveRegionNA

@@SetF2Region:
    lw      a1,0x0(a0)
    lw      a2,0x4(a0)
    lh      a3,0x8(a0)
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sh      a3,0x8(v0)

@@SetPARAMSFOLangEN:
    vla     v0,0x089AFE58
    la      a0,PARAMSFOStringsEN
    li      a2,0x0
    li      a3,0x70
    lw      a1,0x0(a0)
    sw      a1,0x0(v0)
    addiu   v0,v0,0x4
    addiu   a0,a0,0x4
    bne     a2,a3,. - 0x10
    addiu   a2,a2,0x4

; ----------------------------------

; Although DATA INSTALL is disabled in the patch, for consistency sake
; and incase it's used for something else, we match the path to be <GAMEID>MOD

@@SetDatDirApnd:
    li      a1,0x2
    vla     v0,0x08997238
    beq     v1,zero,@@DatDirJP
    nop
    beq     v1,a1,@@DatDirEU
    nop

@@DatDirNA:
    la      a0,FUSaveRegionNAMOD
    vj      @@DatDirSet
    nop

@@DatDirEU:
    la      a0,FUSaveRegionEUMOD
    vj      @@DatDirSet
    nop

@@DatDirJP:
    la      a0,P2GSaveRegionJPMOD
    vj      @@DatDirSet
    nop

@@DatDirSet:
    lw      a1,0x0(a0)
    lw      a2,0x4(a0)
    lw      a3,0x8(a0)
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sw      a3,0x8(v0)
    addiu   v0,v0,0x44
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sw      a3,0x8(v0)
    vla     v0,0x089AFF74
    sw      a1,0x0(v0)
    sw      a2,0x4(v0)
    sw      a3,0x8(v0)

@@SavedataEND:
    nop

; ----------------------------------

; Execute loader.bin

@@ExecModBin:
    vj       patcherAddr
    nop

RestoreFDataReg:
    lw      s0,0x1C(sp)
    lw      a3,0x18(sp)
    lw      a2,0x14(sp)
    lw      a1,0x10(sp)
    lw      a0,0xC(sp)
    lw      v1,0x8(sp)
    lw      v0,0x4(sp)   
    jal     0x0884F7B0
    addiu   sp,sp,0x20    
    j       0x0884D7EC
    nop

.endarea

;
; block2 holds string/encoding/paths/savedata related changes
;

; set area limits
.org bootFree2
.area 0xD20
.skip 0x10

; set path
LoaderConfPathEx:
    .ascii  "ms0:\.\FUC\config.bin"
    .align  0x10

LoaderConfPathIn:
    .ascii  "disc0:/FUC/config.bin"
    .align  0x10

LoaderBinPathEx:
    .ascii  "ms0:\.\FUC\loader.bin"
    .align  0x10

LoaderBinPathIn:
    .ascii  "disc0:/FUC/loader.bin"
    .align  0x10

FileBinPathEx:
    .ascii  "ms0:\.\FUC\nativePSP\file.bin"
    .align  0x10

FileBinPathIn:
    .ascii  "disc0:/FUC/nativePSP/file.bin"
    .align  0x10

FileReplacerPathEx:
    .ascii  "ms0:\.\FUC\nativePSP\."
    .align  0x10

FileReplacerPathIn:
    .ascii  "disc0:/FUC/nativePSP/."
    .align  0x10

FUSaveRegionNA:
    .ascii  "ULUS10391"
    .skip   0x3

FUSaveRegionNAMOD:
    .ascii  "ULUS10391MOD"

F2SaveRegionNA:
    .ascii  "ULUS10266"
    .skip   0x3

FUSaveRegionEU:
    .ascii  "ULES01213"
    .skip   0x3

FUSaveRegionEUMOD:
    .ascii  "ULES01213MOD"

F2SaveRegionEU:
    .ascii  "ULES00851"
    .skip   0x3

P2GSaveRegionJPMOD:
    .ascii  "ULJM05500MOD"

FUSaveKey1:
    .ascii  "3Nc94Hq1zOLh8d62Sb69"  ; Key for NA/EU
    .skip  0x8

FUSaveKey2:
    .db     0x4A,0x1F,0xF3,0x59,0xAE,0xB6,0xEF,0xF8,0x1C,0xA8,0xCB,0x23,0xBC,0xA5,0x7B,0xB3
    .skip   0x8
F2SaveKey:
    .db     0xB9,0xA9,0x00,0x9D,0x6F,0xC2,0xB4,0xEB,0xF4,0xF8,0xCA,0xB2,0xD7,0x72,0xE9,0xAB
    .skip   0x8

PARAMSFOStringsEN:
    .ascii  "Monster Hunter Freedom Unite"
    .fill   12,0
    .ascii  "Game Data"
    .fill   7,0
    .ascii  "Game Data for Monster Hunter Freedom Unite."
    .fill   17,0

.org ValStore - 0x10
    .ascii  "END"

.org ValStore
    .fill   48,0

; Register buffer for backing up and restoring registers as needed... 
.org RegStore
    .fill   96,0

.endarea
