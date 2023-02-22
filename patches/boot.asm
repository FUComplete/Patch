; BOOT.BIN patches
@@DataBinCrypto:
    ; Lets kill DATA.BIN crypto so it reads decrypted 
    .org 0x0884D868
        nop
    .org 0x0884D8B8
        nop
    .org 0x0884E93C
        nop
    .org 0x0884EE0C
        nop

@@CharacterEncodeFix:
    ; Repalce various tables 
    .org 0x089122AE
        .import "patches/charencode.bin",0x00,188  ; UTF8 special characters
    .org 0x089126AE
        .import "patches/charencode.bin",0xC0,184  ; UTF8 characters
    .org 0x0892F2F8
        .import "patches/charencode.bin",0x180,384 ; UTF8MB3 characters
    
    ; Read only first byte of UTF8MB3
    .org 0x0889171C
        .dh     0x1
    
    ; Fix quest details for G1-G3 to show the "star" rank...
    .org 0x0881B55C
        .dh     0x1

@@EquipStrTbl:
    .org 0x089972AC
        .import "patches/equipdesc.bin" ; Equipment string ID's

@@DisableDataInstall:
    .org 0x08839D04
        li      v0,0x0
    .org 0x0884DE28
        li      v0,0x0

@@DataInstallToggleOnline:
    .org 0x088398C8
        .dh     0x0
    .org 0x08839AA8
        .dh     0x0
    .org 0x08839C00
        .dh     0x0

@@DisableStatusDisplayClear:
    ; Kill the instructions writing zero... making status display settings persistent between quests
    .org 0x08817BF4
        nop
        nop

@@BonusDLC:
    ; Titles
    .org 0x08903AF4
        la      v0,0x07FFFBFF   ; Kokoto
        nop
    .org 0x08903B24
        la      v0,0x07FFFBFF   ; Jumbo
        nop
    .org 0x08903B54
        la      v0,0x07FFFBFF   ; Minegarde
        nop
    .org 0x08903B84
        la      v0,0x07FFFBFF   ; Dondruma
        nop
    .org 0x08903BB8
        la      v0,0x07FFFBFF   ; Bookworm
        nop
    .org 0x08903BE8
        la      v0,0x07FFFBFF   ; Imper.Scholar
        nop
    .org 0x08903C18
        la      v0,0x07FFFBFF   ; E.Dragon King
        nop
    .org 0x08903C48
        la      v0,0x07FFFBFF   ; Schrade
        nop
    .org 0x08903C78
        la      v0,0x07FFFBFF   ; Hunter's Soul
        nop
    .org 0x08903CAC
        la      v0,0x07FFFBFF   ; Diva
        nop
    .org 0x08903CE0
        la      v0,0x07FFFBFF   ; Bee's Knees
        nop
    .org 0x08903D14
        la      v0,0x07FFFBFF   ; Reaver
        nop
    .org 0x08903D44
        la      v0,0x07FFFBFF   ; Famous
        nop
    .org 0x08903D74
        la      v0,0x07FFFBFF   ; Electric 
        nop
    
    ; Granny bonus items
    .org 0x08856B64
        nop
        .skip 0x4         
        la      v1,0x07FFFBFF    
    
    ; Wandering Felyne Chef
    .org 0x08857954
        la      a0,0x07FFFBFF
        nop
    
    ; Unknown (post quest check?)
    .org 0x08856A54
        nop
        .skip 0x4
        la      v0,0x07FFFBFF

@@SystemMessageLangSet:
    ; sceUtilityNetconfInitStart - Guildhall "Connecting" message
    .org 0x088AF1A8
        sw      s4,-0x67b0(v0)
    ; sceUtilitySavedataInitStart - "Game data corrupted" message
    .org 0x088C225C
        sw      s4,0x1C(s1)
    ; sceUtilityMsgDialogInitStart - Error code message
    .org 0x088C285C
        sw      s4,0x68C(s1)
    ; sceUtilityMsgDialogInitStart - Error with "No Monster Hunter Freedom Unite Game data was found."
    .org 0x088C28F0
        sw      s4,0x68C(s0)

@@MainMenuUIFix:
    ; Intro prompt about savedata requirements
    .org 0x088C15E0
        .dh     198     ; Savedata requirements "Yes No" text X pos
    
    ; Various Yes/No prompts:
    ; Load Character
    .org 0x088BD0A8
        .dh     -32     ; Load character confirm hilight "No" X pos
    .org 0x088BD0BC
        .dh     34      ; Load character confirm hilight "Yes" X pos
    
    ; New Character
    .org 0x088BD76C
        .dh     198     ; Create character confirm save text X pos
    .org 0x088BE044
        .dh     198     ; Create character confirm save overwrite text X pos
    .org 0x088BEA30
        .dh     198     ; Create character confirm start game text X pos
    .org 0x088BEA08
        .dh     84      ; Create character start game window Y pos
    .org 0x088BEA14
        .dh     104     ; Create character start game window Height
    .org 0x088BEA1C
        .dh     112     ; Create character start game text Y pos
    .org 0x088BEA30
        .dh     195     ; Create character start game prompt X pos
    .org 0x088BEA40
        .dh     144     ; Create character start game prompt Y pos
    .org 0x088BE81C
        .dh     176     ; Create character "Press the O button" text X pos
    .org 0x088BE7E0
        .dh     198     ; Delete corrupted game data "Yes No" prompt X pos

    ; Import Character (F2)
    .org 0x088C4A84
        .dh     198     ; Cancel import "Yes No" text X pos

    ; Import Character (FU)
    .org 0x088C5470
        .dh     198     ; Cancel import "Yes No" text X pos

    ; Options Menu
    .org 0x088C03B0
        .dh     198     ; Save options confirm text X pos
    .org 0x088C0908
        .dh     198     ; Existing save found options confirm text X pos

@@CharacterSelectUIFix:
    ; "Character selected" prompt
    .org 0x088BFF48
        .dh     174     ; "Press the O button" X pos

@@HUDandWheelUI:
    ; HUD fixes
    .org 0x08938B0E
        .dh     30      ; Bullet indicator for bowguns Y pos (next to clock)
    ; Sharpness Bar
    .org 0x088414DC
        .dh     31      ; Highlight Y pos
    .org 0x0893675C
        .dh     108     ; Highlight UV X
        .dh     33      ; Highlight UV Y
        .dh     44      ; Highlight UV Width
        .dh     10       ; Highlight UV Height
    .org 0x0893676A
        .dh     43      ; Type1 bar Y pos
    .org 0x08936776
        .dh     51      ; Type2 bar Y pos
    .org 0x08936782
        .dh     59      ; Type3 bar Y pos
    .org 0x08936786
        .dh     8       ; Type3 bar Height

    ; Item Wheel
    .org 0x08938B64
        .dh     392     ; Selected item text X pos
        .dh     244     ; Selected item text Y pos
        .dh     404     ; Item quantity X pos
        .dh     228     ; Item quantity Y pos
        .skip   8       ; Some text formatting 
        .dh     312     ; Item window BG X pos
        .dh     208     ; Item window BG Y pos
        .dh     160     ; Item window BG Width
        .dh     24      ; Item window BG Height
        .skip   4       ; Unkn
        .dh     320     ; Selected item text BG X pos
        .dh     240     ; Selected item text BG Y pos
        .dh     144     ; Selected item text BG Width
        .dh     20      ; Selected item text BG Height
        .dh     372     ; Selected item icon BG X pos
        .dh     200     ; Selected item icon BG Y pos
        .dh     363     ; Square button X pos
        .dh     224     ; Square button Y pos
        .dh     320     ; LTrigger button X pos
        .dh     212     ; LTrigger button Y pos
        .dh     376     ; Selected item icon X pos
        .dh     202     ; Selected item icon Y pos
        .dh     32      ; Selected item icon Width
        .dh     32      ; Selected item icon Height
        .dh     312     ; Selected Ammo/Coating text BG X pos
        .dh     184     ; Selected Ammo/Coating text BG Y pos
        .dh     160     ; Selected Ammo/Coating text BG Width
        .dh     16      ; Selected Ammo/Coating text BG Height
        .dh     312     ; Item window BG X pos (expanded)
        .dh     200     ; Item window BG Y pos (expanded)
        .dh     160     ; Item window BG Width (expanded)
        .dh     64      ; Item window BG Height (expanded)
        .skip   4       ; Unkn
        .dh     324     ; Item icon BG 1 X pos (expanded)
        .dh     348     ; Item icon BG 2 X pos (expanded)
        .dh     404     ; Item icon BG 3 X pos (expanded)
        .dh     428     ; Item icon BG 4 X pos (expanded)
        .dh     200     ; Item icon BG 1-4 Y pos (expanded)
        .skip   2       ; Unkn
        .dh     312     ; Square button X pos (expanded)
        .dh     456     ; Circle button X pos (expanded)
        .dh     224     ; Square/Circle button Y pos (expanded)
        .dh     372     ; Selected item icon BG X pos (expanded)
        .dh     200     ; Selected item icon BG Y pos (expanded)
        .dh     320     ; Selected item text BG X pos (expanded)
        .dh     240     ; Selected item text BG Y pos (expanded)
        .dh     144     ; Selected item text BG Width (expanded)
        .dh     20      ; Selected item text BG Height (expanded)
        .dh     376     ; Selected item icon X pos (expanded)
        .dh     202     ; Selected item icon Y pos (expanded)
        .dh     32      ; Selected item icon Width (expanded)
        .dh     32      ; Selected item icon Height (expanded)
        .skip   6       ; Selected item icon offset (X,Unkn,Y)
        .dh     312     ; Item window BG X pos (expanded)(gunner)
        .dh     128     ; Item window BG Y pos (expanded)(gunner)
        .dh     160     ; Item window BG Width (expanded)(gunner)
        .dh     136     ; Item window BG Height (expanded)(gunner)
        .dh     312     ; Ammo/Coating text BG X pos (expanded)(gunner)
        .dh     138     ; Ammo/Coating text BG top Y pos (expanded)(gunner)
        .dh     160     ; Ammo/Coating text BG Width (expanded)(gunner)
        .dh     16      ; Ammo/Coating text BG Height (expanded)(gunner)
        .dh     154     ; Ammo/Coating text BG middle Y pos (expanded)(gunner)
        .dh     170     ; Ammo/Coating text BG bottom Y pos (expanded)(gunner)
        .dh     324     ; Item wheel animation left cap X pos (expanded)
        .dh     334     ; Item wheel animation item 1 X pos (expanded)
        .dh     362     ; Item wheel animation item 2 X pos (expanded)
        .dh     390     ; Item wheel animation item 3 X pos (expanded)
        .dh     418     ; Item wheel animation item 4 X pos (expanded)
        .dh     444     ; Item wheel animation right cap X pos (expanded)
        .dh     12      ; Item wheel animation left cap icon Width (expanded)
        .dh     12      ; Item wheel animation right cap icon Width (expanded)
        .dh     0       ; Item wheel animation right cap icon X pos (expanded)
        .dh     0       ; Item wheel animation left cap icon X pos (expanded)
        .dh     306     ; Ammo/Coating selector X pos (expanded)
        .dh     153     ; Ammo/Coating selector Y pos (expanded)
        .dh     172     ; Ammo/Coating selector Width (expanded)
        .dh     20      ; Ammo/Coating selector Height (expanded)
        .dh     384     ; Triangle/Cross button X pos (expanded)
        .dh     124     ; Triangle button Y pos (expanded)
        .dh     184     ; Cross button Y pos (expanded)
        .dh     398     ; Ammo/Coating text X pos
    .org 0x08845CB4
        .dh     402     ; Selected item accent sprite right X pos (angled sprite)
    .org 0x08845CE0
        .dh     358     ; Selected item accent sprite left X pos (angled sprite)
    .org 0x088467C8
        .dh     402     ; Selected item accent sprite right X pos (angled sprite)(expanded)
    .org 0x088467F4
        .dh     358     ; Selected item accent sprite left X pos (angled sprite)(expanded)

@@InGameOptionMenu:
    .org 0x0884994C
        .dh     162     ; Fix misaligned "OFF" under status display (X pos)

@@InventoryCombineUI:
    .org 0x08818198
        .dh     30      ; "Please Select" A text X pos
    .org 0x0881831C
        .dh     30      ; "Please Select" B text X pos
    .org 0x08935ABC
        .dh     146     ; Material "A" BG X pos
    .org 0x08935AC0
        .dh     182     ; Material "A" BG width
    .org 0x08935AC8
        .dh     154     ; Material "A" text X pos
    .org 0x08935AD0
        .dh     146     ; Material "B" BG X pos
    .org 0x08935AD4
        .dh     182     ; Material "B" BG width
    .org 0x08935ADC
        .dh     154     ; Material "B" text X pos
    .org 0x08935AE8
        .dh     134     ; Combined result BG width

@@GuildCardSendRecv:
    .org 0x088F42EC
        .dh     198     ; Delete guildcard? "Yes/No" prompt X pos (Guildcard List)
    .org 0x088F43D0
        .dh     174     ; Deleted guildcard "Press the O button" text X pos
    .org 0x088F5D18
        .dh     198     ; Send guildcard? "Yes/No" prompt X pos
    .org 0x088FFDCC
        .dh     174     ; "Press the O button" text X pos (after sending guildcard)
    .org 0x088F68E8
        .dh     198     ; Delete guildcard? "Yes/No" prompt X pos
    .org 0x088F6950
        .dh     174     ; "Press the O button" text X pos (deleting card)

@@PauseMenuUI:
    .org 0x088494A8
        .dh     216     ; Pause menu text X pos

@@AbandonQuestUI:
    .org 0x08849C78
        .dh     64      ; "Yes/No" option X pos
    .org 0x089385E4
        .dh     247     ; Text X pos

@@EquipDetailsUI:
    .org 0x08935D58
        .ascii  "%2d/%d "   ; Various "page indicator" string formatting
    .org 0x08820634
        .dh     84      ; Armor resistance values text X pos
    .org 0x08820A24
        .dh     154     ; Armor color series text X pos
    .org 0x08820A70
        .dh     98      ; Armor "Hunter Type" value text X pos
    .org 0x088232BC
        .dh     49      ; Armor slots X pos

@@ReferenceMenuUI:
    ; Comrade Info
    .org 0x08818D98
        .dh     36      ; "No Felyne Comrade selected" text X pos
    .org 0x088340C4
        .dh     90      ; Comrade Skill ":" X pos 
    ; Monster List
    .org 0x0881AB94
        .dh     78      ; Max Length crown sprite X pos
    .org 0x0881ABEC
        .dh     78      ; Min Length crown sprite X pos
    .org 0x0881ACE0
        .dh     152     ; Monster icon background X pos
    .org 0x0881AD0C
        .dh     172     ; Monster icon X pos
    .org 0x08938614
        .dh     224     ; Monster List BG X pos
    .org 0x0893861C
        .dh     33      ; Monster List BG Width

@@StatusUI:
    .org 0x0881B818
        .dh     70      ; Resistance column ":" X pos

@@GrannyPeddlerUI:
    .org 0x089387A8
        .dh     23      ; Left arrow indicator for pages X pos

@@PlayerChestUI:
    .org 0x08832E68
        .dh     0       ; Move to inventory arrow up X pos
    .org 0x08832EC0
        .dh     0       ; Move to inventory arrow down X pos

@@SupplyChest:
    .org 0x8847B48
        .dh     1       ; Pickup item delay value

@@BedSavePrompts:
    .org 0x088C1E6C
        .dh     198     ; "Would you like to save?" confirm text X pos
    .org 0x088C1EA8
        .dh     198     ; "Exit Game?" confirm text X pos

@@GuildCardList:
    .org 0x088F3E98
        .dh     2       ; Set OSK language to English
    .org 0x088F87C0
        .dh     348     ; "Sort" text X pos
    .org 0x088F8140
        .dh     431     ; Right arrow X pos

@@GuildCard:
    ; Fix text input and character sizing/length
    .org 0x088F4CB8
        .db     0x2     ; Set OSK language to English
    .org 0x088F8C9C
        sllv    v0,v0,zero  ;
    .org 0x088FA0D4         ; Reduce width of characters
        sllv    v0,v0,zero  ;
    
    ; Guildcard Intro edit text
    .org 0x088F8C84
        andi    v1,s3,0x1F  ;
    .org 0x088F8CAC         ; Set from 3 lines to 2 lines and increase characters per line
        sra     v0,s3,0x5   ;
    
    ; Guildcard Intro text
    .org 0x088FA0BC
        andi    v1,s3,0x1F  ;
    .org 0x088FA0E4         ; Set from 3 lines to 2 lines and increase characters per line
        sra     v0,s3,0x5   ;
    
    ; Guildcard player title
    .org 0x088F97C0
        .dh     264     ; BG Width
    .org 0x088F9C14
        .dh     16      ; Drop shadow text Y pos
    .org 0x088F9C38
        .dh     23      ; Text X pos
    .org 0x088F9C3C
        .dh     17      ; Text Y pos

    ; Guildcard player name
    .org 0x088F9C78
        .dh     45      ; Text Y pos
    .org 0x089B33B8
        .dh     144     ; BG Width

    ; Guildcard page indicator
    .org 0x088F967C
        .dh     342     ; BG left cap X pos
    .org 0x088F96B0
        .dh     342     ; BG center X pos
    .org 0x088F96F0
        .dh     342     ; BG right cap X pos
    .org 0x088F9724
        .dh     370     ; LTrigger BTN X pos
    .org 0x088F9728
        .dh     15      ; LTrigger BTN Y pos
    .org 0x088F973C
        .dh     422     ; RTrigger BTN X pos
    .org 0x088F9740
        .dh     15      ; RTrigger BTN Y pos
    .org 0x088F9754
        .dh     352     ; Arrows X pos
    .org 0x088F975C
        .dh     95      ; Right arrow Gap
    .org 0x088F978C
        .dh     394     ; Page indicator text X pos
    .org 0x088F9790
        .dh     17      ; Page indicator text Y pos

    ; HR indicator
    .org 0x089B33BC
        .dh     288     ; BG X pos
    .org 0x088F9CE0
        .dh     294     ; Text X pos
    
    ; Weapon Usage
    .org 0x088FA3D8
        .dh     148     ; "Weapon Usage" text X pos

    ; Hunter Diary page
    .org 0x088FA830
        .dh     148     ; "Hunter's Diary" text X pos
    .org 0x088FA9CC
        .dh     36      ; "Failed" quest text X pos
    .org 0x088FAA50
        .dh     36      ; "Retired" quest text X pos
    .org 0x088FAAD4
        .dh     36      ; "Cleared" quest text X pos
    .org 0x088FAC74
        .dh     48      ; "Successfully hunted" orange text X pos
    .org 0x088FAD20
        .dh     48      ; "Total play time" orange text X pos
    .org 0x088FADBC
        .dh     48      ; "Hunter rank has risen" orange text X pos
    .org 0x088FAE3C
        .dh     48      ; "fell # times in combat" name text X pos (yourself)
    .org 0x088FAE94
        .dh     48      ; "fell # times in combat" name text X pos (other players?)
    .org 0x088FAED8
        .dh     104     ; "fell # times in combat" text X pos
    .org 0x088FAF84
        .dh     48      ; "Fallen a total of over #" text X pos
    .org 0x088FB01C
        .dh     48      ; "New treasure record:" text X pos
    .org 0x088FB0B0
        .dh     48      ; "Cleared under # minutes!" text X pos
    .org 0x088FB12C
        .dh     48      ; "Completed this without any armor!" text X pos
    .org 0x088FB1C0
        .dh     48      ; "Obtained <ITEM>!" text X pos
    .org 0x088FB280
        .dh     48      ; "Cleared all Village Chiefs" text X pos
    .org 0x088FB350
        .dh     48      ; "Cleared all Gathering Hall" text X pos
    .org 0x088FB3FC
        .dh     48      ; "Successfully cleared # Quests!" text X pos
    .org 0x088FB494
        .dh     48      ; "Retired # times!" text X pos
    .org 0x088FB51C
        .dh     138     ; Clear weapon icon X pos
    .org 0x088FB574
        .dh     48      ; "Cleared with <WEP> # times!" text X pos
    .org 0x088FB608
        .dh     48      ; "Cleared by just a sliver!" text X pos
    .org 0x088FB6D4
        .dh     48      ; "<MONSTER> longest length updated" text X pos
    .org 0x088FB7B8
        .dh     48      ; "<MONSTER> shortest length updated" text X pos
    .org 0x088FB85C
        .dh     48      ; "Comrade Diary: Set up a lot of traps" text X pos
    .org 0x088FB900
        .dh     48      ; "Comrade Diary: Blew its horn a lot" text X pos
    .org 0x088FB9A4
        .dh     48      ; "Comrade Diary: Goofed off" text X pos
    .org 0x088FBA48
        .dh     48      ; "Comrade Diary: Used Large Barrel-Bombs!" text X pos
    .org 0x088FBAEC
        .dh     48      ; "Comrade Diary: Gathered a lot" text X pos
    .org 0x088FBB84
        .dh     112     ; Improve weapon icon X pos
    .org 0x088FBBC8
        .dh     36      ; "Improved a <WEP>" text X pos
    .org 0x088FBD04
        .dh     36      ; "Created <WEP>!" text X pos
    .org 0x088FBDB8
        .dh     36      ; "Earned Award" text X pos
    .org 0x088FBE88
        .dh     36      ; "Felyne Comrade has joined the ranks" text X pos
    .org 0x088FBEF0
        .dh     35      ; Top arrow Y pos

    ; Felyne Diary
    .org 0x088FC034
        .dh     148     ; "Felyne Comrade Diary" text X pos
    .org 0x088FC4B4
        .dh     128     ; Text alignment X pos
    .org 0x088FC4B8
        .dh     301     ; "Max Fondness" text X pos
    .org 0x088FC4D0
        .dh     196     ; "Max Fondness" text Y pos
    .org 0x088FC4E4
        .dh     364     ; Comrade "number" X pos
    .org 0x088FC4E8
        .dh     212     ; Comrade "number" Y pos
    .org 0x088FC514
        .dh     392     ; "Comrade" text X pos
    .org 0x088FC51C
        .dh     212     ; "Comrade" text Y pos

    ; Treasures
    .org 0x088FCD1C
        .dh     148     ; "Treasures" text X pos
    .org 0x088FCFF8
        la      v1,0x089A9A68   ; Change string pointer start position
    .org 0x088FD040
        sb      zero,0x94(v0)   ; Increase string length of areas (sets a 0 where the end of a string should be)
    .org 0x089B3788
        ; Sets which string to use
        .dh     1       ; Mountains
        .dh     2       ; Jungle
        .dh     3       ; Desert
        .dh     4       ; Swamp
        .dh     5       ; Forest&Hills
        .dh     6       ; Volcano
        .dh     7       ; Great Forest
    .org 0x088FD080
        .dh     312     ; Treasure place ":" placement X pos
    .org 0x088FD0A4
        .dh     318     ; Secondary players name X pos
    .org 0x088FD0D0
        .dh     395     ; Treasure "Points" value BG (left) X pos
    .org 0x088FD100
        .dh     395     ; Treasure "Points" value BG (center) X pos
    .org 0x088FD150
        .dh     395     ; Treasure "Points" value BG (right) X pos
    .org 0x088FD1F0
        .dh     452     ; Treasure points "Number" X pos
    .org 0x088FD234
        .dh     378     ; "Gold Crown" X pos
    .org 0x088FD260
        .dh     378     ; "Silver Crown" X pos

    ; Awards
    .org 0x088FD468
        .dh     148     ; "Awards" text X pos
    
    ; Monster Log
    .org 0x088FD884
        .dh     148     ; "Monster Log" text X pos

    ; Training Records
    .org 0x088FDBB4
        .dh     148     ; "Training Records" text X pos

    ; Groupt Training Records
    .org 0x088FE058
        .dh     148     ; "Group Training Records" text X pos
    .org 0x088FE370
        .dh     26      ; Quest titles X pos
    .org 0x088FDFD0
        .dh     189     ; Quest list BG Width
    .org 0x088FE184
        .dh     59      ; Blank quest list Left Cap BG Y pos
    .org 0x088FE1C8
        .dh     59      ; Blank quest list Center BG Y pos
    .org 0x088FE208
        .dh     59      ; Blank quest list Right Cap BG Y pos
    .org 0x088FE248
        .dh     61      ; Blank quest "????" text Y pos
    .org 0x088FE258
        .dh     59      ; Quest list text Y pos
    .org 0x088FE25C
        .dh     61      ; Quest list text BG Y pos 
    .org 0x088FE438
        .dh     59      ; Quest list highlight Y pos
    ; .org 0x088FE3C4
    ;     .dh     103     ; Top arrow X pos
    .org 0x088FE3C8
        .dh     41      ; Top arrow Y pos
    ; .org 0x088FE3EC
    ;     .dh     103     ; Bottom arrow X pos
    .org 0x088FE3F0
        .dh     242     ; Bottom arrow Y pos

@@ItemLimits:
    ; Remvoe the buy-to-box limits of certain items...
    .org 0x0899A5CC
        .db     0       ; Powercharm
    .org 0x0899A5FC
        .db     0       ; Armorcharm
    .org 0x0899B064
        .db     0       ; BBQ Spit
    .org 0x0899B0AC
        .db     0       ; Binoculars

@@Misc:
    ; Exclamation sprite initial draw position
    .org 0x08937B9C
        .dh     247     ; X pos
        .dh     95      ; Y pos
    ; Exclamation sprite size
    .org 0x08937BA0
        .dh     6       ; Width
        .dh     14      ; Height

    ; "Checking for Memory Stick Duo" at start of the game needs its
    ; window and text repositioned for the Patch/Loader version strings
    .org 0x088C10EC
        .dh     64      ; Window Y pos
    .org 0x088C10F8
        .dh     136     ; Window Height
    .org 0x088C1100
        .dh     80      ; Text Y pos
    .org 0x088C1108
        li      a2,0xE  ; String ID
    ; There's actually 2 of these back to back for some reason...
    .org 0x088C129C
        .dh     64      ; Window Y pos
    .org 0x088C12A8
        .dh     136     ; Window Height
    .org 0x088C12B0
        .dh     80      ; Text Y pos
    .org 0x088C12B8
        li      a2,0xE  ; String ID
    
    ; Start of the game, savedata is checked and loaded if it exists...
    .org 0x088C12E8
        .dh     174     ; Auto-loaded Game data "Press the O button" text X pos

    ; Set "Small Item Box" display to regular "Item Box"
    .org 0x0892E738
        .dw     0x08836B58

@@Unknown:
    ; TODO figure out what this does again...
    .org 0x088BECCC
        .dh     198     ; Something related to bed saves "Yes/No" prompts