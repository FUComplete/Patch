.psp

; New location of stuff for modloader - 0x08A35510
; Total size free'd shrinking str_tbl = 86016 
; str_tbl.pac location - 0x089C7510 (preloader and such will be dumped here and then flushed)
; SV_SHYUK.at3 location - 0x08B80080 ( gathering hall)
; SV_GOLIO.at3 location - 0x08B6E880 : 1589248 in size (in options menu)

; Syscalls
sceIoOpen   equ 0x0890B938
sceIoRead   equ 0x0890B908
sceIoClose  equ 0x0890B918
sceIoWrite  equ 0x0890B8F8
sceIoMkdir  equ 0x0890BC80
sceKernelIcacheInvalidateAll    equ 0x0890BB30
sceKernelDcacheWritebackInvalidateAll   equ 0x0890BB38
memcpy      equ 0x0880CD4C
strcpy      equ 0x0880FB30
strcat      equ 0x0880F90C
strcmp      equ 0x0880FAC4

; Memory regions

;Preload
PreloadDataStore    equ 0x089C7510
PreloaderExec       equ 0x089C7530
PreloadFileCache    equ 0x08B6E880  ; Size - 1589248

;Modload
MLFileBin           equ 0x08A35510  ; Size - 832
MLConfigBin         equ 0x08A35850  ; Size - 64
; DataStore = DataBlock+nativePSP = 128 bytes
; DataBlock allocation:
;   0x0  -  FileID (0x2)
;   0x4  -  File Address (0x4)
;   0x8  -  FileSize (0x4)
;   0xC  -  Currently interacted carve amount remaining (0x1)
MLDataBlock         equ 0x08A35890  ; Size - 80
MLnativePSP         equ 0x08A358E0  ; size - 48
ModloaderCode       equ 0x08A35910  ; modload.bin location



; FileWLStore ; Size - 826, Alloc - 832
; ModloaderDataStore
; ModloaderExec

; bootFree1   equ 0x08954C88  ; Bank 1, size: 0xCB0
; bootFree2   equ 0x08955EE8  ; Bank 2, size: 0xD20
; filewlAddr  equ 0x08956800  ; File whitelist
; ValStore    equ 0x08956B50  ; Store values for specific things
; RegStore    equ 0x08956B80  ; Size 0x60, stores registers v0-t9

; Set a macro for adjusting addresses to uncached
.macro  vla,dest,value
    la      dest,value + 0x40000000
.endmacro
.macro  vj,value
    j       value + 0x40000000
.endmacro

; Main binary
.open "binary/EBOOT.BIN","build/ISO_ROOT/PSP_GAME/SYSDIR/EBOOT.BIN",0x08801A4C
    .include    "patches/boot.asm"
    .include    "modloader/preloader_init.asm"
.close

; Main Menu
.open "binary/overlay/demo_task.ovl","build/data_in/0043",0x09A5A580
    .include    "patches/demo_task.asm"
.close

; New Game Menu
.open "binary/overlay/edit_task.ovl","build/data_in/0044",0x09A5A580
    .include    "patches/edit_task.asm"
.close

; Continue Menu
.open "binary/overlay/cont_task.ovl","build/data_in/0045",0x09A5A580
    .include    "patches/cont_task.asm"
.close

; Options Menu
.open "binary/overlay/option_task.ovl","build/data_in/0046",0x09A5A580
    .include    "patches/option_task.asm"
.close

; Lobby Task (village/guildhall)
.open "binary/overlay/lobby_task.ovl","build/data_in/0050",0x09A5A580
    .include    "patches/lobby_task.asm"
.close

; Game Task (in-quest)
.open "binary/overlay/game_task.ovl","build/data_in/0051",0x09A5A580
    .include    "patches/game_task.asm"
.close

; Training Hall
.open "binary/overlay/arcade_task.ovl","build/data_in/0053",0x09A5A580
    .include    "patches/arcade_task.asm"
.close

; Game Sub
.open "binary/overlay/game_sub.ovl","build/data_in/0056",0x09C14280
    .include    "patches/game_sub.asm"
.close

.createfile "build/ISO_ROOT/FUC/PRELOAD.BIN",PreloaderExec-0x4
    preloader_start:
        .word   preloader_end-preloader_start-0x4
        .include    "modloader/preloader_exec.asm"
        PreloadRTN:
            ; Clear caches
            jal     sceKernelIcacheInvalidateAll
            nop
            jal     sceKernelDcacheWritebackInvalidateAll
            nop
            li      v0,0x0
            ; Restore reg
            lw      s0,0x1C(sp)
            lw      a1,0x18(sp)
            lw      v1,0x14(sp)
            move    a0,s0
            jal     0x0884F7B0
            addiu   sp,sp,0x20
            j       PreloaderInitHook+8
            nop 
    preloader_end:
.close

.createfile "build/ISO_ROOT/FUC/MODLOAD.BIN",ModloaderCode-0x4
    modloader_start:
        .word   modloader_end-modloader_start-0x4
        .include    "modloader/fileidgen.asm"
        .include    "modloader/fileops.asm"
        ; Mods
        .include    "mods/nativePSP_toggle.asm"
        .include    "mods/questloader.asm"
        .include    "mods/hold_gather.asm"
        .include    "mods/guildhall.asm"
        .include    "mods/hh_rework.asm"
    modloader_end:
.close

; Actual patcher code to be executed
; .createfile "build/ISO_ROOT/FUC/loader.bin",patcherAddr
;     loader_start:
;     ; This is executed on boot
;     .include    "modloader/instructionfix.asm"
;     .include    "modloader/configset.asm"
;     @@Return:
;         vj       RestoreFDataReg
;         nop
;     ; Executed as called upon...
;     .include    "modloader/fileidgen.asm"
;     .include    "modloader/fileloader.asm"
;     .include    "modloader/filepatcher.asm"
;     .include    "modloader/questloader.asm"
;     ; Mods
;     .include    "mods/guildhall.asm"
;     .include    "mods/hh_rework.asm"
;     loader_end:
; .close

.createfile "build/ISO_ROOT/FUC/CONFIG.BIN",0x0
    .area 64,0
        ; Version string, also found in preloader_exec.
        .ascii  "1.4.0 ENG "  ; Version (add a space at the end, limit 12 characters total)
        .align  0x10
        .db     0x0     ; 0x10 - File replacer toggle
        .db     0x1     ; 0x11 - Save region (0x0:JP, 0x1:US, 0x2:EU)
        .db     0x0     ; 0x12 - True raw flag
        .db     0x0     ; 0x13 - Dos audio
        .dh     0x3F5F  ; 0x14 - FoV value
        .db     0x3     ; 0x16 - Vertical snap start position
        .db     0x0     ; 0x17 - Minimap scale
        .db     0x0     ; 0x18 - HH rework toggle
        .db     0x0     ; 0x19 - Early Lao kill toggle
        .db     0x0     ; 0x1A - Full chest guildhall (offline)
        .db     0x0     ; 0x1B - Guildhall drink buff
    .endarea
.close
