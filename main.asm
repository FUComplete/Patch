.psp

// Main binary
.open "binary/BOOT.BIN","build/BOOT.BIN",0x08801A4C

// Labeled addresses...
.include "asm/addresses.asm"

// ASM patches
.include "asm/characterencode.asm"
.include "asm/crypto_databin.asm"
.include "asm/savedata.asm"
// .include "asm/str_equipment.asm"
.include "asm/abandonquest.asm"
.include "asm/bedsave.asm"
.include "asm/equipdetails.asm"
.include "asm/guildcard.asm"
.include "asm/hallid.asm"
.include "asm/invcombine.asm"
.include "asm/itemwheel.asm"
.include "asm/mainmenu.asm"
.include "asm/pausemenu.asm"
.include "asm/refcomradeinfo.asm"
.include "asm/refmonsterlist.asm"
.include "asm/statuswindow.asm"
.include "asm/grannyshop.asm"
.include "asm/hud.asm"
.include "asm/optionsmenu.asm"

// Unknown values I patched before...
// Don't remember why either...
.include "asm/unknown.asm"

.close

// Overlay specific changes
.open "binary/overlay/arcade_task.ovl","build/overlay/arcade_task.ovl",0x09A5A580
.include "asm/trainhall_ovl.asm"
.close

.open "binary/overlay/edit_task.ovl","build/overlay/edit_task.ovl",0x09A5A580
.include "asm/charcreate_ovl.asm"
.close

.open "binary/overlay/game_sub.ovl","build/overlay/game_sub.ovl",0x09C14280
.include "asm/kitchen_ovl.asm"
.close

.open "binary/overlay/install_task.ovl","build/overlay/install_task.ovl",0x09A5A580
.include "asm/datainstall_ovl.asm"
.close

.open "binary/overlay/lobby_task.ovl","build/overlay/lobby_task.ovl",0x09A5A580
.include "asm/guildhall_ovl.asm"
.include "asm/armorcolor_ovl.asm"
.include "asm/bedsave_ovl.asm"
.include "asm/chestcombine_ovl.asm"
.include "asm/equipsetdetail_ovl.asm"
.include "asm/farm_ovl.asm"
.include "asm/npcquest_ovl.asm"
.include "asm/shops_ovl.asm"
.close

// str_tbl.bin related additions
.open "data/str_tbl.pac","build/str_tbl.pac",0x089C7510
.include "asm/quest_table.asm"
.close

