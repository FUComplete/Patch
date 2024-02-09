; --------------------------------------
; Files to copy to MS if not present:
;
; ICON0.PNG - 22474
; PIC1.PNG - 70276
; PARAM.SFO - 4912
; preload.bin
; config.bin
; modloader.bin
; nativePSP/
;   6552 - 1425408
;   6553 - 1439744
;   6554 - 1404928
;   6555 - 1556480
;   6566 - 1589248
;   6571 - 1400832
;   file.bin - 826
; --------------------------------------

; Exec start
.org PreloaderExec
    ; Check if preload.bin was successfully loaded from MS, if not generate FUCDAT.
    lw      a0,0x10(sp)
    beq     a0,zero,LoadConfig2Mem
    li      a0,0x0
    ; Generate FUCDAT folder
    la      a0,FUCDATPath
    li      a2,0x1B6
    jal     sceIoMkdir
    nop
    ; Generate nativePSP folder
    la      a0,FUCDATPathNativePSP
    li      a2,0x1B6
    jal     sceIoMkdir
    nop

SetFileTbl:
    la      a0,PathsTbl
    sw      a0,0xC(sp)

GenMS0Files:
    lw      a3,0xC(sp)
    lw      a0,0x0(a3)
    beq     a0,zero,LoadConfig2Mem
    nop
    li      a1,0x1
    li      a2,0x0
    jal     sceIoOpen
    li      a3,0x0
    move    s0,v0
    move    a0,v0
    lw      a3,0xC(sp)
    la      a1,PreloadFileCache
    lw      a2,0x8(a3)
    jal     sceIoRead
    li      a3,0x0
    jal     sceIoClose
    move    a0,s0
    lw      a3,0xC(sp)
    lw      a0,0x4(a3)
    li      a1,0x202    ; posix flag for CREAT and WRONLY
    li      a2,0x1B6    ; mode set to 666
    jal     sceIoOpen
    li      a3,0x0
    move    s0,v0
    move    a0,v0
    lw      a3,0xC(sp)
    la      a1,PreloadFileCache
    lw      a2,0x8(a3)
    jal     sceIoWrite
    li      a3,0x0
    jal     sceIoClose
    move    a0,s0
    lw      a0,0xC(sp)
    addiu   a0,a0,0xC
    sw      a0,0xC(sp)
    jal     sceKernelDcacheWritebackInvalidateAll
    nop
    j       GenMS0Files
    nop

LoadConfig2Mem:
    ; Load config.bin to memory, if fail regen files (SetFileTbl)
    la      a0,FUCDATConfig
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; Check if missing
    la      v1,0x80010002
    beq     v0,v1,SetFileTbl
    sw      v0,0x10(sp)
    move    s0,v0
    move    a0,v0
    li      v1,0x0
    la      a1,MLConfigBin
    jal     sceIoRead
    li      a2,64
    ; Close config.bin in FD
    jal     sceIoClose
    move    a0,s0
    jal     sceKernelDcacheWritebackInvalidateAll
    nop

CheckVerPair:
    la      a0,PreloadExecVersion
    la      a1,MLConfigBin
    jal     strcmp
    li      a2,0x0
    beq     v0,zero,LoadFileBin2Mem
    nop
    la      a0,0x80010002
    sw      a0,0x10(sp)
    j       SetFileTbl
    nop

LoadFileBin2Mem:
    ; Check if file replacer is enabled
    la      a0,MLConfigBin
    lb      a1,0x10(a0)
    beq     a1,zero,LoadModload2Mem
    nop
    ; Load file.bin to memory, if fail regen files (SetFileTbl)
    la      a0,FUCDATNatPSPFileBin
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; Check if missing
    la      v1,0x80010002
    beq     v0,v1,SetFileTbl
    sw      v0,0x10(sp)
    move    s0,v0
    move    a0,v0
    li      v1,0x0
    la      a1,MLFileBin
    jal     sceIoRead
    li      a2,826
    ; Close file.bin in FD
    jal     sceIoClose
    move    a0,s0
    jal     sceKernelDcacheWritebackInvalidateAll
    nop

LoadModload2Mem:
    ; Load modload.bin to memory, if fail regen files (SetFileTbl)
    la      a0,FUCDATModload
    li      a1,0x1
    jal     sceIoOpen
    li      a2,0x0
    ; Check if missing
    la      v1,0x80010002
    beq     v0,v1,SetFileTbl
    sw      v0,0x10(sp)
    move    s0,v0
    move    a0,v0
    li      v1,0x0
    la      a1,PreloadDataStore
    jal     sceIoRead
    li      a2,0x4
    move    v0,s0
    move    a0,v0
    la      a1,ModloaderCode
    la      a2,PreloadDataStore
    lw      a2,0x0(a2)
    jal     sceIoRead
    nop    
    ; Close modload.bin in FD
    jal     sceIoClose
    move    a0,s0
    jal     sceKernelDcacheWritebackInvalidateAll
    nop

WriteNativePath2Mem:
    ; Load the nativePSP path from preload into datastore upper...
    la      a0,MLnativePSP
    la      a1,FUCDATPathNativePSP
    li      a3,0x20
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    addiu   a1,a1,0x4
    addiu   a0,a0,0x4
    bne     a3,zero,. - 0x10
    addiu   a3,a3,-0x4    
    ; fix the path to include the "/" character.
    li      a2,0x2F
    sb      a2,-0x2(a0)

; -------------------------------
; Config Parsing
;
; v0 - MLConfigBin Address
; v1 - Flag check
; a0-a3 - alter accordingly
; -------------------------------

SaveRegionCheck:
    ; Check region flag to set the region save to load
    la      v0,MLConfigBin
    lb      v1,0x11(v0)
    beq     v1,zero,TrueRawBloatCheck
    ; beq     v1,zero,SetDATDirApnd
    nop  

SetFUSaveKeys:
    vla     a0,0x089AFF98
    la      a1,FUSaveKey1
    li      a3,0x10
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    addiu   a1,a1,0x4
    addiu   a0,a0,0x4
    bne     a3,zero,. - 0x10
    addiu   a3,a3,-0x4    

SetFUSaveKeys2:
    vla     a0,0x088C2384
    la      a1,FUSaveKey2
    lb      a2,0x0(a1)      ; 0x4A
    sb      a2,0x0(a0)
    lb      a2,0x1(a1)      ; 0x1F
    sb      a2,0x20(a0)
    lb      a2,0x2(a1)      ; 0xF3
    sb      a2,0x2C(a0)
    lb      a2,0x3(a1)      ; 0x59
    sb      a2,0x34(a0)
    lb      a2,0x4(a1)      ; 0xAE
    sb      a2,0x3C(a0)
    lb      a2,0x5(a1)      ; 0xB6
    sb      a2,0x44(a0)
    lb      a2,0x6(a1)      ; 0xEF
    sb      a2,0x4C(a0)
    lb      a2,0x7(a1)      ; 0xF8
    sb      a2,0x54(a0)
    lb      a2,0x8(a1)      ; 0x1C
    sb      a2,0x5C(a0)
    lb      a2,0x9(a1)      ; 0xA8
    sb      a2,0x64(a0)
    lb      a2,0xA(a1)      ; 0xCB
    sb      a2,0x6C(a0)
    lb      a2,0xB(a1)      ; 0x23
    sb      a2,0x74(a0)
    lb      a2,0xC(a1)      ; 0xBC
    sb      a2,0x7C(a0)
    lb      a2,0xD(a1)      ; 0xA5
    sb      a2,0x84(a0)
    lb      a2,0xE(a1)      ; 0x7B
    sb      a2,0x8C(a0)
    lb      a2,0xF(a1)      ; 0xB3
    sb      a2,0x94(a0)
    vla     a3,0x088C40A4
    bne     a3,a0,SetFUSaveKeys2 + 0x10
    move    a0,a3

SetF2SaveKey:
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

NAorEUCheckFU:
    vla     a0,0x089AE784
    li      a1,0x1
    bne     v1,a1,SetFUEUID
    nop

SetFUNAID:
    la      a1,FUSaveRegionNA
    j       SetFURegion
    nop

SetFUEUID:
    la      a1,FUSaveRegionEU
    
SetFURegion:
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    sw      a2,0x1180(a0)
    sw      a2,0x17D4(a0)
    lw      a2,0x4(a1)
    sw      a2,0x4(a0)
    sw      a2,0x1184(a0)
    sw      a2,0x17D8(a0)
    lh      a2,0x8(a1)
    sh      a2,0x8(a0)
    sh      a2,0x1188(a0)
    sh      a2,0x17DC(a0)

NAorEUCheckF2:
    vla     a0,0x089B0070
    li      a1,0x1
    bne     v1,a1,SetF2EUID

SetF2NAID:
    la      a1,F2SaveRegionNA
    j       SetF2Region
    nop

SetF2EUID:
    la      a1,F2SaveRegionEU

SetF2Region:
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    lw      a2,0x4(a1)
    sw      a2,0x4(a0)
    lh      a2,0x8(a1)
    sh      a2,0x8(a0)

SetPARAMSFOLangEN:
    vla     a0,0x089AFE58
    la      a1,PARAMSFOStringsEN
    li      a3,0x70
    lw      a2,0x0(a1)
    sw      a2,0x0(a0)
    addiu   a1,a1,0x4
    addiu   a0,a0,0x4
    bne     a3,zero,. - 0x10
    addiu   a3,a3,-0x4

SetFUIcon:
    vla     a0,0x088C02E4
    li      a1,0xE
    sb      a1,0x0(a0)
    sb      a1,0x3ABC(a0)

TrueRawBloatCheck:
    lb      v1,0x12(v0)
    beq     v1,zero,DosAudioCheck
    nop
    vla     a0,0x08938104
    li      a1,0x64
    li      a3,0xA
    sw      a1,0x0(a0)
    addiu   a0,a0,0x4
    bne     a3,zero,. - 0x8
    addiu   a3,a3,-0x1

DosAudioCheck:
    lb      v1,0x13(v0)
    beq     v1,zero,FoVSet
    nop
    vla     a0,MLFileBin
    lb      a1,0x333(a0)
    lb      a2,0x334(a0)
    lb      a3,0x335(a0)
    ori     a1,a1,0xF
    ori     a2,a2,0x40
    ori     a3,a3,0x8
    sb      a1,0x333(a0)
    sb      a2,0x334(a0)
    sb      a3,0x335(a0)

FoVSet:
    vla     a0,0x08886DA4
    lh      v1,0x14(v0)
    sh      v1,0x0(a0)

VertCamSet:
    vla     a0,0x088138BC
    lh      v1,0x16(v0)
    sh      v1,0x0(a0)

MinimapScaleSet:
    vla     a0,0x08842ED4
    lb      v1,0x17(v0)
    beq     v1,zero,FileIDGenInsPatch
    li      a1,0x1
    bne     a1,v1,Minimap50
    nop

Minimap75:
    ; Map scale
    li      a1,0x3F40   ; 75%
    sh      a1,0x0(a0)
    sh      a1,0x4(a0)
    li      a1,0x165    ; X pos
    li      a2,0x22     ; Y pos
    sh      a1,0xC(a0)
    sh      a1,0x30(a0)
    sh      a2,0x10(a0)
    sh      a2,0x38(a0)
    ; Ping scale
    li      a1,0x425C   ; 75%
    sh      a1,0x142c(a0)
    li      a1,0x1A4    ; X pos
    li      a2,0x5E     ; Y pos
    sh      a1,0x1440(a0)
    sh      a2,0x1444(a0)
    b       MinimapCampScale

Minimap50:
    ; Map scale
    li      a1,0x3F00   ; 50%
    sh      a1,0x0(a0)
    sh      a1,0x4(a0)
    li      a1,0x188    ; X pos
    li      a2,0x22     ; Y pos
    sh      a1,0xC(a0)
    sh      a1,0x30(a0)
    sh      a2,0x10(a0)
    sh      a2,0x38(a0)
    ; Ping scale
    li      a1,0x420C   ; 50%
    sh      a1,0x142c(a0)
    li      a1,0x1B2    ; X pos
    li      a2,0x4A     ; Y pos
    sh      a1,0x1440(a0)
    sh      a2,0x1444(a0)

MinimapCampScale:
    ; Change the draw region to the new smaller camp icon
    vla     a0,0x08936DE0
    li      a1,0x90
    li      a2,0xE6
    sh      a1,0x0(a0)
    sh      a2,0x2(a0)

MinimapLoadingScreenScale:
    ; Reduce the loading screen minimap so camp doesnt look off...
    vla     a0,0x088BC38C
    li      a1,0x3F80   ; 100%
    sh      a1,0x0(a0)
    vla     a0,0x089AFBF4
    li      a1,0xA4
    li      a2,0x28
    sh      a1,0x0(a0)
    sh      a2,0x2(a0)

; -------------------------------
; Instruction patching
; -------------------------------

; TBD: add to as modloader is expanded upon

FileIDGenInsPatch:
    vla     a0,0x0884E158
    la      a1,CheckFileID
    srl     a1,a1,0x2
    lui     a2,0x0800
    addu    a1,a2,a1
    sw      a1,0x0(a0)
    sw      zero,0x4(a0)

ModloaderInsPatch:
    vla     a0,0x0884E730
    la      a1,MLFileLoader
    srl     a1,a1,0x2
    lui     a2,0x0800
    addu    a1,a2,a1
    sw      a1,0x0(a0)
    sw      zero,0x4(a0)

CarveCounterInsPatch:
    vla     a0,0x0886CFE8
    la      a1,CarveCounter
    srl     a1,a1,0x2
    lui     a2,0x0800
    addu    a1,a2,a1
    sw      a1,0x0(a0)
    sw      zero,0x4(a0)

; -------------------------------
; Return
; -------------------------------

RTNCHECK:
    ; RTN   
    j       PreloadRTN
    nop
    .align 0x10

; ---------------------------------------------------------

; I know this is extremely inefficent but to copy/concat the paths 
; would end up taking more space than just stating the full paths 
; of each file...

; Pointer/Size table for savedata gen...
; Each section is essentially:
;   ISO_PATH
;   SAVEDATA_PATH
;   SIZE
;
PathsTbl:
    ; PARAM.SFO
    .dw FUCPARAM
    .dw FUCDATPARAM
    .dw 4912
    ; ICON0.PNG
    .dw FUCICON
    .dw FUCDATICON
    .dw 22474
    ; PIC1.PNG
    .dw FUCPIC1
    .dw FUCDATPIC1
    .dw 70276
    ; file.bin
    .dw FUCNatPSPFileBin
    .dw FUCDATNatPSPFileBin
    .dw 826
    ; 6552
    .dw FUCNatPSP6552
    .dw FUCDATNatPSP6552
    .dw 1425412
    ; 6553
    .dw FUCNatPSP6553
    .dw FUCDATNatPSP6553
    .dw 1439748
    ; 6554
    .dw FUCNatPSP6554
    .dw FUCDATNatPSP6554
    .dw 1404932
    ; 6555
    .dw FUCNatPSP6555
    .dw FUCDATNatPSP6555
    .dw 1556484
    ; 6566
    .dw FUCNatPSP6566
    .dw FUCDATNatPSP6566
    .dw 1589252
    ; 6571
    .dw FUCNatPSP6571
    .dw FUCDATNatPSP6571
    .dw 1400836
    ; config.bin
    .dw FUCConfig
    .dw FUCDATConfig
    .dw 64
    ; modload.bin
    .dw FUCModload
    .dw FUCDATModload
    .dw modloader_end-modloader_start
    ; preload.bin (always write last)
    .dw FUCPreload
    .dw FUCDATPreload
    .dw preloader_end-preloader_start
    ; TERM
    .dw 0
    .align 0x10

; External file paths
FUCDATPath:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT",0x0
    .align  0x4
FUCDATPathNativePSP:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP",0x0
    .align  0x4
FUCDATPARAM:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/PARAM.SFO",0x0
    .align  0x4
FUCDATICON:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/ICON0.PNG",0x0
    .align  0x4
FUCDATPIC1:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/PIC1.PNG",0x0
    .align  0x4
FUCDATConfig:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/CONFIG.BIN",0x0
    .align  0x4
FUCDATPreload:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/PRELOAD.BIN",0x0
    .align  0x4
FUCDATModload:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/MODLOAD.BIN",0x0
    .align  0x4
FUCDATNatPSPFileBin:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/FILE.BIN",0x0
    .align  0x4
FUCDATNatPSP6552:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6552",0x0
    .align  0x4
FUCDATNatPSP6553:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6553",0x0
    .align  0x4
FUCDATNatPSP6554:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6554",0x0
    .align  0x4
FUCDATNatPSP6555:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6555",0x0
    .align  0x4
FUCDATNatPSP6566:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6566",0x0
    .align  0x4
FUCDATNatPSP6571:
    .ascii  "ms0:/PSP/SAVEDATA/FUCDAT/NATIVEPSP/6571",0x0
    .align  0x4

; Internal file paths
FUCPARAM:
    .ascii  "disc0:/FUC/PARAM.SFO",0x0
    .align  0x4
FUCICON:
    .ascii  "disc0:/FUC/ICON0.PNG",0x0
    .align  0x4
FUCPIC1:
    .ascii  "disc0:/FUC/PIC1.PNG",0x0
    .align  0x4
FUCConfig:
    .ascii  "disc0:/FUC/CONFIG.BIN",0x0
    .align  0x4
FUCPreload:
    .ascii  "disc0:/FUC/PRELOAD.BIN",0x0
    .align  0x4
FUCModload:
    .ascii  "disc0:/FUC/MODLOAD.BIN",0x0
    .align  0x4
FUCNatPSPFileBin:
    .ascii  "disc0:/FUC/NATIVEPSP/FILE.BIN",0x0
    .align  0x4
FUCNatPSP6552:
    .ascii  "disc0:/FUC/NATIVEPSP/6552",0x0
    .align  0x4
FUCNatPSP6553:
    .ascii  "disc0:/FUC/NATIVEPSP/6553",0x0
    .align  0x4
FUCNatPSP6554:
    .ascii  "disc0:/FUC/NATIVEPSP/6554",0x0
    .align  0x4
FUCNatPSP6555:
    .ascii  "disc0:/FUC/NATIVEPSP/6555",0x0
    .align  0x4
FUCNatPSP6566:
    .ascii  "disc0:/FUC/NATIVEPSP/6566",0x0
    .align  0x4
FUCNatPSP6571:
    .ascii  "disc0:/FUC/NATIVEPSP/6571",0x0
    .align  0x4

; Savedata related
FUSaveRegionNA:
    .ascii  "ULUS10391",0x0
    .align  0x4

F2SaveRegionNA:
    .ascii  "ULUS10266",0x0
    .align  0x4

FUSaveRegionEU:
    .ascii  "ULES01213",0x0
    .align  0x4

F2SaveRegionEU:
    .ascii  "ULES00851",0x0
    .align  0x4

FUSaveKey1:
    .ascii  "3Nc94Hq1zOLh8d62Sb69",0x0  ; Key for NA/EU
    .align  0x4

FUSaveKey2:
    .db     0x4A,0x1F,0xF3,0x59,0xAE,0xB6,0xEF,0xF8,0x1C,0xA8,0xCB,0x23,0xBC,0xA5,0x7B,0xB3,0x0
    .align  0x4
F2SaveKey:
    .db     0xB9,0xA9,0x00,0x9D,0x6F,0xC2,0xB4,0xEB,0xF4,0xF8,0xCA,0xB2,0xD7,0x72,0xE9,0xAB,0x0
    .align  0x4

PARAMSFOStringsEN:
    .ascii  "Monster Hunter Freedom Unite"
    .fill   12,0
    .ascii  "Game Data"
    .fill   7,0
    .ascii  "Game Data for Monster Hunter Freedom Unite."
    .fill   17,0
    .align  0x10

PreloadExecVersion:
    .ascii  "1.4.0 ENG "
    .align  0x10
    