.psp

; set some functions/addresses
sceIoOpen   equ 0x0890B938
sceIoRead   equ 0x0890B908
sceIoClose  equ 0x0890B918
memcpy      equ 0x0880CD4C
strcpy      equ 0x0880FB30
patcherAddr equ 0x08A4A600
configAddr  equ 0x08A4A5E0
bootFree1   equ 0x08954C88  ; Bank 1, size: 0xCB0
bootFree2   equ 0x08955EE8  ; Bank 2, size: 0xD20
filewlAddr  equ 0x08956800  ; File whitelist
ValStore    equ 0x08956B50  ; Store values for specific things
RegStore    equ 0x08956B80  ; Size 0x60, stores registers v0-t9

; Set a macro for adjusting addresses to uncached
.macro  vla,dest,value
    la      dest,value + 0x40000000
.endmacro
.macro  vj,value
    j       value + 0x40000000
.endmacro

; Main binary
.open "binary/BOOT.BIN","build/EBOOT.BIN",0x08801A4C
    .include    "patches/boot.asm"
    .include    "modloader/preloader.asm"
.close

; Main Menu
.open "binary/overlay/demo_task.ovl","build/0043",0x09A5A580
    .include    "patches/demo_task.asm"
.close

; New Game Menu
.open "binary/overlay/edit_task.ovl","build/0044",0x09A5A580
    .include    "patches/edit_task.asm"
.close

; Continue Menu
.open "binary/overlay/cont_task.ovl","build/0045",0x09A5A580
    .include    "patches/cont_task.asm"
.close

; Options Menu
.open "binary/overlay/option_task.ovl","build/0046",0x09A5A580
    .include    "patches/option_task.asm"
.close

; Lobby Task (village/guildhall)
.open "binary/overlay/lobby_task.ovl","build/0050",0x09A5A580
    .include    "patches/lobby_task.asm"
.close

; Game Task (in-quest)
.open "binary/overlay/game_task.ovl","build/0051",0x09A5A580
    .include    "patches/game_task.asm"
.close

; Training Hall
.open "binary/overlay/arcade_task.ovl","build/0053",0x09A5A580
    .include    "patches/arcade_task.asm"
.close

; Game Sub
.open "binary/overlay/game_sub.ovl","build/0056",0x09C14280
    .include    "patches/game_sub.asm"
.close

; Actual patcher code to be executed
.createfile "build/loader.bin",patcherAddr
    loader_start:
    ; This is executed on boot
    .include    "modloader/instructionfix.asm"
    .include    "modloader/configset.asm"
    @@Return:
        vj       RestoreFDataReg
        nop
    ; Executed as called upon...
    .include    "modloader/fileidgen.asm"
    .include    "modloader/fileloader.asm"
    .include    "modloader/filepatcher.asm"
    .include    "modloader/questloader.asm"
    ; Mods
    .include    "mods/guildhall.asm"
    .include    "mods/hh_rework.asm"
    loader_end:
.close

.createfile "build/config.bin",0x0
    .word       loader_end-loader_start
    .include    "modloader/config.asm"
.close
