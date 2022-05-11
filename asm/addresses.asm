; BOOT.BIN
.definelabel InvCombineSelectTextAX,0x08818198            ; "Please Select" text X pos 
.definelabel InvCombineSelectTextBX,0x0881831C            ; Same as above but for the second window...
.definelabel ComradeInfoNoneTextX,0x08818D98              ; Menu -> Reference -> Comrade Info. Text saying no comrade
.definelabel MonListMaxCrownX,0x0881AB94                  ; Menu -> Reference -> Monster List. Crown icon X pos
.definelabel MonListMinCrownX,0x0881ABEC                  ; Same as above but for Min
.definelabel MonListIconBGX,0x0881ACE0                    ; Background for the displayed monster icon X pos
.definelabel MonListIconX,0x0881AD0C                      ; Icon X pos
.definelabel StatusResCol2X,0x0881B818                    ; Status window second column ":" X pos
.definelabel EquipDetailResValX,0x08820634                ; Armor resist values X pos
.definelabel EquipDetailArmSeriesX,0x08820A24             ; "Color:" series text X pos
.definelabel EquipDetailHunterTypeX,0x08820A70            ; "Hunter Type:" text X pos
.definelabel EquipDetailSlotsX,0x088232BC                 ; "Slots:" X pos
.definelabel ChestMoveAmtArwUpX,0x08832E68
.definelabel ChestMoveAmtArwDownX,0x08832EC0
.definelabel ComradeBoardColon10X,0x088340C4              ; "Comrade Points" colon X pos
.definelabel ClockFacePos,0x08840504                      ; Clock face combined X/Y pos
.definelabel PauseMenuTextX,0x088494A8                    ; Text X pos
.definelabel OptionsMenuMDisplayTxtX,0x0884994C           ; "OFF" text X pos (when "Status Display" is set to "OFF")
.definelabel AbandonQstCfrmTextX,0x08849C78               ; "Yes/No" text X pos
.definelabel DATABINCryptoDef1_1,0x0884EBB8               ; 
.definelabel DATABINCryptoDef2_1,0x0884EBDC               ;
.definelabel DATABINCryptoDef1_2,0x0884EBFC               ;
.definelabel DATABINCryptoMod1,0x0884EC08                 ;
.definelabel DATABINCryptoDef2_2,0x0884EC10               ;
.definelabel DATABINCryptoMod2,0x0884EC14                 ;
.definelabel UTF8MB3ReadByte,0x0889171C                   ; Num of bytes to read per character
.definelabel MainMenuCharCfrmHiLiNX,0x088BD0A8            ; Character Load/Creaction Yes/No highlight for Yes X pos
.definelabel MainMenuCharCfrmHiLiYX,0x088BD0BC            ; Same as above but for No
.definelabel CharCreateCfrmSaveTxtX,0x088BD76C            ; "Save this character?" Yes/No X pos
.definelabel CharCreateCfrmOvrWrTxtX,0x088BE044           ; Same as above but for the "Character already exists" Yes/No
.definelabel CharCreateCfrmStartX,0x088BEA30              ; "Start Game?" Yes/No X pos 
.definelabel Unknown1,0x088BECCC
.definelabel OptionsMenuSaveCfrmX,0x088C03B0              ; Yes/No X pos for the save settings prompt in Options Menu
.definelabel OptionsMenuExistsCfrmX,0x088C0908            ; Same as above but when existing data is found
.definelabel Unknown2,0x088C12E8
.definelabel BedSavePromptCfrm1X,0x088C1E6C               ; "Would you like to save?" Yes/No X pos
.definelabel BedSavePromptCfrm2X,0x088C1EA8               ; "Exit game?" Yes/No X pos
.definelabel GCDescriptOSKType,0x088F4CB8                 ; OSK Lang Type to use for editing GC description
.definelabel GCEditCharWidth,0x088F8C9C                   ; How much space between characters there is in the edit mode
.definelabel GCCharWidth,0x088FA0D4                       ; Same as above but on the Guildcard itself
.definelabel GCHunterDiaryClrWepX,0x088FB51C              ; "Cleared with weapon" icon X pos
.definelabel GCHunterDiaryImprvWepX,0x088FBB84            ; "Improved Weapon" icon X pos
.definelabel GCFelyneDiaryTxtAlign1,0x088FC4B4            ; Right text alignment for "Max Fondness", "Number Transferred" and "Number Received"
.definelabel GCFelyneDiaryMaxFondTxtX,0x088FC4B8          ; Max Fondness text X pos
.definelabel GCFelyneDiaryMaxFondTxtY,0x088FC4D0          ; Y pos
.definelabel GCFelyneDiaryNumComradeX,0x088FC4E4          ; Number of comrades X pos
.definelabel GCFelyneDiaryNumComradeY,0x088FC4E8          ; Y pos
.definelabel GCFelyneDiaryComradeTxtX,0x088FC514          ; "Comrade" text X pos
.definelabel GCFelyneDiaryComradeTxtY,0x088FC51C          ; Y pos
.definelabel GCTreasureAreaStrPTR,0x088FCFF8              ; String pointer for Treasure Areas
.definelabel GCTreasureAreaCharLimit,0x088FD040           ; Character limit on Areas
.definelabel GCTreasureColX,0x088FD080                    ; Colon X pos between Area and Point Value
.definelabel Unknown3,0x088FD0A4
.definelabel GCTreasurePTValLeftBG,0x088FD0D0             ; Left corner of Treasure point value X pos
.definelabel GCTreasurePTValCntrBG,0x088FD100             ; Center section X pos
.definelabel GCTreasurePTValRghtBG,0x088FD150             ; Right corner X pos
.definelabel GCTreasurePTValNum,0x088FD1F0                ; Point value X pos
.definelabel GCTreasureCrownX,0x088FD234                  ; Crown X pos
.definelabel Unknown4,0x088FD260
.definelabel UTF8SpecChar,0x089122AE
.definelabel UTF8Char,0x089126AE
.definelabel UTF8MB3Char,0x0892F2F8
.definelabel InvCombineBGAPos,0x08935ABC                  ; Inventory Combine background X/Y pos
.definelabel InvCombineBGAScl,0x08935AC0                  ; Window Scale
.definelabel InvCombineBGATxtScl,0x08935AC4               ; Text Scale
.definelabel InvCombineBGATxtColor,0x08935AC6             ; "Material A" text color
.definelabel InvCombineBGAWinStyle,0x08935AC7             ; Window Style
.definelabel InvCombineBGAMatTxtPos,0x08935AC8            ; "Material A" text X/Y pos
.definelabel InvCombineBGATxtLeading,0x08935ACC           ; Leading 
.definelabel InvCombineBGBPos,0x08935AD0                  ; Inventory Combine background X/Y pos
.definelabel InvCombineBGBScl,0x08935AD4                  ; Window Scale
.definelabel InvCombineBGBTxtScl,0x08935AD8               ; Text Scale
.definelabel InvCombineBGBTxtColor,0x08935ADA             ; "Material B" text color
.definelabel InvCombineBGBWinStyle,0x08935ADB             ; Window Style
.definelabel InvCombineBGBMatTxtPos,0x08935ADC            ; "Material B" text X/Y pos
.definelabel InvCombineBGBTxtLeading,0x08935AE0           ; Leading 
.definelabel InvCombinedRsltBGPos,0x8935AE4               ; Combined Result window X/Y pos
.definelabel InvCombinedRsltBGScl,0x08935AE8              ; Window Scale
.definelabel InvCombinedRsltTxtScl,0x08935AEC             ; Text Scale
.definelabel InvCombinedRsltTxtColor,0x08935AEE           ; Text Color
.definelabel InvCombinedRsltWinStyle,0x08935AEF           ; Window Style
.definelabel InvCombinedRsltTxtPos,0x08935AF0             ; Text X/Y pos
.definelabel InvCombinedRsltLead,0x08935AF4            ; Leading
.definelabel InvCombineCfrmPos,0x08935AF8                 ; Combine/Quit Window X/Y pos
.definelabel InvCombineCfrmTxtScl,0x08935AFC              ; Text Scale
.definelabel InvCombineCfrmTxtColor,0x08935AFE            ; Text Color
.definelabel InvCombineCfrmWinStyle,0x08935AFF            ; Window Style
.definelabel InvCombineCfrmBGScl,0x08935B00               ; Window Scale
.definelabel InvCombineCfrmHiLiColor,0x08935B08           ; Highlight Color (BGRA)
.definelabel ChestSortWindow1Pos,0x08935B2C               ; Chest Take Out/Combine/Arrange "Sort" pos
.definelabel ChestSortWindow1Style,0x08935B30             ; Window Style
.definelabel InvSortWindowPos,0x08935B32                  ; Inventory "Sort" pos
.definelabel InvSortWindowStyle,0x08935B36                ; Window Style
.definelabel ChestSortWindow2Pos,0x08935B38               ; Chest Put in Item "Sort" pos
.definelabel ChestSortWindow2Style,0x08935B3C             ; Window Style
.definelabel ChestSortWindow3Pos,0x08935B3E               ; Chest Equipment "Sort" pos
.definelabel ChestSortWindow3Style,0x08935B42             ; Window Style
.definelabel ItmShopSortWindowPos,0x08935B44              ; Item Shop "Sort" pos
.definelabel ItmShopSortWindowStyle,0x08935B48            ; Window Style
.definelabel StatusEquipIcnX,0x08935B64                   ; Status window equipment icons X pos
.definelabel StatusEquipTxtX,0x08935B66                   ; Text X pos for the above window
.definelabel EquipDetailIcnX,0x08935B68                   ; Equipment Details equipment icon X pos
.definelabel EquipDetailTxtX,0x08935B6A                   ; Text X pos for the above window
.definelabel EquipShopChangeTxtX,0x08935B88               ; Weapon Shop "Before -> After" text X pos
.definelabel EquipDetailShotR2X,0x08935B8A                ; Equipment Details (and Shop) for Gunners second row shot type
.definelabel ChestEquipDetailChangeTxtX,0x08935B8C        ; Chest "Before -> After" equipment text X pos
.definelabel ChestEquipDetailShotR2X,0x08935B8E           ; Chest Equipment Details gunners second row shot type
.definelabel FarmRecSndZennyWinPos,0x08935BD0             ; Farm "Receive/Send" item zenny window X/Y pos
.definelabel FarmRecSndZennyWinScl,0x08935BD4             ; Scale (Width/Height)
.definelabel FarmRecSndZennyTxtPos,0x08935BD8             ; Text X/Y pos
.definelabel FarmRecSndWinPos,0x08935BE4                  ; Farm "Receive/Send" options window X/Y pos 
.definelabel FarmRecSndTxtScl,0x08935BE8                  ; Scale (Width/Height)
.definelabel FarmRecSndTxtColor,0x08935BEA                ; Text color
.definelabel FarmRecSndWinStyle,0x08935BEB                ; Window style
.definelabel FarmRecSndSqrBtnPos,0x08935C0C               ; Square button X/Y pos
.definelabel FarmRecSndItmWin2Pos,0x08935C10              ; Window for "Select the item to receive..." below Item window. X/Y pos
.definelabel FarmRecSndItmWin2Scl,0x08935C14              ; Scale
.definelabel FarmRecSndItmWin2TxtScl,0x08935C18           ; Text scale
.definelabel FarmRecSndItmWin2TxtColor,0x08935C1A         ; Text color
.definelabel FarmRecSndItmWin2WinStyle,0x08935C1B         ; Window Style
.definelabel FarmRecSndItmWin2TxtPos,0x08935C1C           ; Text X/Y pos
.definelabel FarmRecSndItmWin2TxtLead,0x08935C20          ; Text leading 
.definelabel FarmRecSndItmWin1Pos,0x08935C38              ; Window for "Place item into Item Bag..." below Item window. X/Y pos
.definelabel FarmRecSndItmWin1Scl,0x08935C3C              ; Scale
.definelabel FarmRecSndItmWin1TxtScl,0x08935C40           ; Text scale
.definelabel FarmRecSndItmWin1TxtColor,0x08935C42         ; Text color
.definelabel FarmRecSndItmWin1WinStyle,0x08935C43         ; Window Style
.definelabel FarmRecSndItmWin1TxtPos,0x08935C44           ; Text X/Y pos
.definelabel FarmRecSndItmWin1TxtLead,0x08935C48          ; Text leading
.definelabel EquipDetailPgTxtFmt,0x08935D58               ; "< x/x >" page selection text formating
.definelabel HUDExclamationDrawPos,0x08937B9C             ; Exclamation X/Y texture pos
.definelabel HUDExclamationDrawSize,0x08937BA0            ; Exclamation X/Y texture size
.definelabel AbandonQstBGPos,0x0893585D8                  ; Abandon Quest Background X/Y pos
.definelabel AbandonQstBGScl,0x0893585DC                  ; Scale
.definelabel AbandonQstTxtScl,0x089385E0                  ; Text scale
.definelabel AbandonQstWinStyle,0x089385E3                ; Window style
.definelabel AbandonQstTxtPos,0x089385E4                  ; Text X/Y pos
.definelabel AbandonQstTxtLead,0x089385E8                 ; Text leading
.definelabel MonListWinPos,0x08938614                     ; Monster List Window X/Y pos
.definelabel MonListTxtScl,0x08938618                     ; Text scale
.definelabel MonListTxtColor,0x0893861A                   ; Text color
.definelabel MonListWinStyle,0x0893861B                   ; Window style
.definelabel MonListWinScl,0x0893861C                     ; Scale
.definelabel GrannyShopPageIndicatorLX,0x089387A8         ; Left page indicator X pos 
.definelabel GrannyShopPageIndicatorRX,0x089387AC         ; Right page indicator X pos
.definelabel ReloadSpritePos,0x08938AEC                   ; Reload bullet texture X/Y pos
.definelabel ReloadSpriteID,0x08938AF4                    ; Sprite ID for Reload sprie
.definelabel LoadingSpritePos,0x08938AF6                  ; Loading... bullet texture X/Y pos
.definelabel ChangeSpritePos,0x08938B00                   ; Change bullet texture X/Y pos
.definelabel BowgunBulletSpritePos,0x08938B0C             ; Bullet position for bowgun X/Y pos
.definelabel GunlanceBulletSpritePos,0x08938B14           ; Bullet position for gunlance X/Y pos
.definelabel ItmWhlBGPos,0x08938B74                       ; Item Wheel background X/Y pos
.definelabel ItmWhlBGScl,0x08938B78                       ; Scale
.definelabel ItmWhlTxtBGPos,0x08938B80                    ; Item Wheel background for text X/Y pos
.definelabel ItmWhlTxtBGScl,0x08938B84                    ; Scale
.definelabel ItmWhlMainItmBGPos,0x08938B88                ; Item Wheel currently selected item background X/Y pos
.definelabel ItmWhlSqrBtnPos,0x08938B8C                   ; Square button X/Y pos
.definelabel ItmWhlLBtnPos,0x08938B90                     ; L Trigger X/Y pos
.definelabel ItmWhlMainItmPos,0x08938B94                  ; Item Wheel currently selected item X/Y pos
.definelabel ItmWhlMainItmScl,0x08938B98                  ; Scale
.definelabel ItmWhlGunAmmoBGPos,0x08938B9C                ; Gunner Ammo/Coat background X/Y pos
.definelabel ItmWhlGunAmmoBGScl,0x08938BA0                ; Scale
.definelabel ItmWhlExpBGPos,0x08938BA4
.definelabel ItmWhlExpBGScl,0x08938BA8
.definelabel ItmWhlExpItmBG1X,0x08938BB0                  ; Item Wheel expanded item background 1 (far left) pos
.definelabel ItmWhlExpItmBG2X,0x08938BB2                  ; Background 2
.definelabel ItmWhlExpItmBG4X,0x08938BB4                  ; Background 4
.definelabel ItmWhlExpItmBG5X,0x08938BB6                  ; Background 5 (far right)
.definelabel ItmWhlExpItmBGY,0x08938BB8                   ; Background 1,2,4,5 Y pos
.definelabel ItmWhlExpSqrBtnX,0x08938BBC                  ; Square button pos 
.definelabel ItmWhlExpOBtnX,0x08938BBE                    ; Circle button pos
.definelabel ItmWhlExpSqrOBtnY,0x08938BC0                 ; Square/Circle button pos
.definelabel ItmWhlExpMainItmBGPos,0x08938BC2             ; Background 3 (currently selected) X/Y pos
.definelabel ItmWhlExpTxtBGPos,0x08938BC6                 ; Currently selected text background X/Y pos
.definelabel ItmWhlExpTxtBGScl,0x08938BCA                 ; Scale
.definelabel ItmWhlExpMainItmPos,0x08938BCE               ; Main item X/Y pos
.definelabel ItmWhlExpMainItmScl,0x08938BD2               ; Main item scale
.definelabel ItmWhlExpSubItmPos,0x08938BD6                ; Sub items (1,2,4,5) X/Y pos
.definelabel ItmWhlExpGunAmmoBGPos,0x08938BDC             ; Background pos
.definelabel ItmWhlExpGunAmmoBGScl,0x08938BE0             ; Background scale
.definelabel ItmWhlExpGunAmmoBGSelX,0x08938BE4            ; Gunner ammo selection background X pos
.definelabel ItmWhlExpGunAmmoBGSel1Y,0x08938BE6           ; Top background Y pos
.definelabel ItmWhlExpGunAmmoBGSelScl,0x08938BE8          ; Scale
.definelabel ItmWhlExpGunAmmoBGSel2Y,0x08938BEC           ; Mid background Y pos
.definelabel ItmWhlExpGunAmmoBGSel3Y,0x08938BEE           ; Bottom background Y pos
.definelabel ItmWhlExpItmAnimLCapX,0x08938BF0             ; Item Wheel animation furthest left item
.definelabel ItmWhlExpItmAnimItm1X,0x08938BF2             ; Item 1 pos
.definelabel ItmWhlExpItmAnimItm2X,0x08938BF4             ; Item 2 pos
.definelabel ItmWhlExpItmAnimItm3X,0x08938BF6             ; Item 3 pos
.definelabel ItmWhlExpItmAnimItm4X,0x08938BF8             ; Item 4 pos
.definelabel ItmWhlExpItmAnimRCapX,0x08938BFA             ; Item Wheel animation furthest right item
.definelabel ItmWhlExpItmAnimLCapItmW,0x08938BFC          ; Actual item in the Left cap. Width
.definelabel ItmWhlExpItmAnimRCapItmW,0x08938BFE          ; Right cap item width
.definelabel ItmWhlExpItmAnimRCapItmX,0x08938C00          ; Right cap item X
.definelabel ItmWhlExpItmAnimLCapItmX,0x08938C02          ; Left cap item X
.definelabel ItmWhlExpGunAmmoSelPos,0x08938C04            ; Gunner Ammo/Coat Selector X/Y pos
.definelabel ItmWhlExpGunAmmoSelScl,0x08938C08            ; Scale
.definelabel ItmWhlExpGunTriCrosBtnX,0x08938C0C           ; Triangle/Cross X pos
.definelabel ItmWhlExpGunTriBtnY,0x08938C0E               ; Triangle Y pos
.definelabel ItmWhlExpGunCrosBtnY,0x08938C10              ; Cross Y pos
.definelabel ItmWhlExpGunAmmoTxtX,0x08938C12              ; Ammo/Coat text X pos
.definelabel WepValues,0x089574E0
.definelabel DATABINCryptoSubTable,0x089970C8             ; Substitution table for DATA.BIN
.definelabel EquipDescStrIDTbl,0x089972AC
.definelabel AdhocGuildHallID,0x089AE790
.definelabel AdhocArenaHallID,0x089AE798
.definelabel QuestIDTbl,0x089AEAF0
.definelabel AdhocGameID,0x089AF904
.definelabel ParamSFOStr,0x089AFE58
.definelabel GCTreasureAreaSTRID,0x089B3788               ; String IDs for the "Areas" on the Treasure page (Mountains, Jungle, Desert, etc)

; arcade_task.ovl @ 0x09A5A580

.definelabel TrainHallRoomSelBGX,0x09A67F94
.definelabel TrainHallRoomSelBGY,0x09A67F98
.definelabel TrainHallRoomSelBGW,0x09A67F9C
.definelabel TrainHallRoomSelBGH,0x09A67FA0
.definelabel TrainHallRoomSelTitlePos,0x09A69D08
.definelabel TrainHallRoomSelCol1X,0x09A69D0C
.definelabel TrainHallRoomSelColY,0x09A69D0E
.definelabel TrainHallRoomSelColLead,0x09A69D10
.definelabel TrainHallRoomSelCursor1X,0x09A69D12
.definelabel TrainHallRoomSelCol2X,0x09A69D14
.definelabel TrainHallRoomSelCursor2X,0x09A69D16

; edit_task.ovl @ 0x09A5A580

.definelabel CharImportTxt1X,0x9A5B208
.definelabel CharImportTxt2X,0x9A5B240
.definelabel CharCreateCfrmWOSaveX,0x09A60F60             ; "Begin without saving" Yes/No prompt X pos
.definelabel CharCreateCfrmUseCharX,0x09A6310A            ; "Do you want to use this character?" Yes/No prompt X pos

; game_sub.ovl @ 0x09C14280

.definelabel ComradeBoardPtsRemainX,0x09C1FB10
.definelabel ComradeBoardPtsCostX,0x09C20154
.definelabel KitchenMealsBGPos,0x09CCAF38                 ; Today's Meals menu background X/Y pos
.definelabel KitchenMealsBGScl,0x09CCAF3C                 ; Background scale
.definelabel KitchenMealsTxtScl,0x09CCAF40                ; Text scale
.definelabel KitchenMealsWinStyle,0x09CCAF43              ; Window style
.definelabel KitchenMealsTxtPos,0x09CCAF44                ; Text X/Y pos
.definelabel KitchenMealsTxtLead,0x09CCAF48               ; Text leading
.definelabel KitchenMealsTxtLine,0x09CCAF4A               ; Number of lines
.definelabel KitchenMealsHiLiColor,0x09CCAF50             ; Highlight color (BGRA)
.definelabel KitchenMealsHiLiPos,0x09CCAF54               ; X/Y pos
.definelabel KitchenMealsHiLiScl,0x09CCAF58               ; Scale
.definelabel KitchenMealsTitlePos,0x09CCAF5C              ; "Today's Meals" X/Y pos
.definelabel KitchenMealABGPos,0x09CCAF60                 ; Meal A background X/Y pos
.definelabel KitchenMealABGScl,0x09CCAF64                 ; Background scale
.definelabel KitchenMealATxtScl,0x09CCAF68                ; Text scale
.definelabel KitchenMealATxtColor,0x09CCAF6A              ; "Meal A" color
.definelabel KitchenMealAWinStyle,0x09CCAF6B              ; Window style
.definelabel KitchenMealATxtPos,0x09CCAF6C                ; Text X/Y pos
.definelabel KitchenMealATxtLead,0x09CCAF70               ; Text leading
.definelabel KitchenMealBBGPos,0x09CCAF74                 ; Meal B background X/Y pos
.definelabel KitchenMealBBGScl,0x09CCAF78                 ; Background scale
.definelabel KitchenMealBTxtScl,0x09CCAF7C                ; Text scale
.definelabel KitchenMealBTxtColor,0x09CCAF7E              ; "Meal B" color
.definelabel KitchenMealBWinStyle,0x09CCAF7F              ; Window style
.definelabel KitchenMealBTxtPos,0x09CCAF80                ; Text X/Y pos
.definelabel KitchenMealBTxtLead,0x09CCAF84               ; Text leading
.definelabel KitchenMealCfrmBGPos,0x09CCAF88              ; Order confirm background X/Y pos
.definelabel KitchenMealCfrmBGScl,0x09CCAF8C              ; Background scale
.definelabel KitchenMealCfrmTxtScl,0x09CCAF90             ; Text scale
.definelabel KitchenMealCfrmTxtColor,0x09CCAF92           ; Text color
.definelabel KitchenMealCfrmWinStyle,0x09CCAF93           ; Window style
.definelabel KitchenMealCfrmTxtPos,0x09CCAF94             ; Text X/Y pos
.definelabel KitchenMealCfrmTxtLead,0x09CCAF98            ; Text leading
.definelabel KitchenMealCfrmHiLiPos,0x09CCAFA4            ; Highlight X/Y pos
.definelabel KitchenMealCfrmHiLiScl,0x09CCAFA8            ; Scale
.definelabel ComradeBoardTxtSpc1,0x09CCB678

; install_task.ovl

.definelabel DataInstallCfrm1X,0x09A5AB44                 ; "Install the Install Data?" Yes/No prompt X pos
.definelabel DataInstallCfrm2X,0x09A5B364                 ; "Install Data already exists." Yes/No prompt X pos
.definelabel DataInstallDir,0x09A5D600                    ; Data install directory

; lobby_task.ovl @ 0x09A5A580

.definelabel EquipSetStatColonX,0x09AE62AC                ; Colon placement for status window on sets
.definelabel GHRoomSelBGX,0x09A74208
.definelabel GHRoomSelBGY,0x09A7420C
.definelabel GHRoomSelBGW,0x09A74210
.definelabel GHRoomSelBGH,0x09A74214
.definelabel SmithyArmTypeViewTxtY,0x09A7CD04             ; Text for armor type view in smithy shop (to sort between blade/gun)
.definelabel GHReqHRNumX,0x09A873D8                       ; Required HR # X pos at quest giver
.definelabel NPCQstPageIndBGW,0x09A889A0                  ; Quest page indicator background width
.definelabel NPCQstPageIndArwW,0x09A889E0                 ; Quest page "arrow" width
.definelabel FarmPlantItmNoneX,0x09A8D81C                 ; Farm planting row item "None" text X pos
.definelabel FarmPlantItmX,0x09A8D864                     ; Same as above but the text when you actually plant something
.definelabel BedSavePromptCfrm3X,0x09AAC538               ; "Exit game?" Yes/No X pos
.definelabel ChestCombSelectTxtBX,0x09ADEE6C              ; "Please Select" text X pos for Item B
.definelabel ChestCombSelectTxtAX,0x09ADEFF0              ; Same as above for Item A
.definelabel ArmColorUndoBTNY,0x09AE1034                  ; Armor color picker "Undo" button Y pos
.definelabel ArmColorUndoBTNLineX,0x09AE1050              ; "Undo" button outline X pos
.definelabel ArmColorUndoBTNW,0x09AE106C                  ; "Undo" button outline width
.definelabel ArmColorUndoBTNH,0x09AE1074                  ; "Undo" button outline height
.definelabel TreshisDAmtTxtPos,0x09AFDE98
.definelabel TreshisDAmtArwUpPos,0x09AFDE9C
.definelabel TreshisDAmtArwDownPos,0x09AFDEA0
.definelabel GHRoomSelTitlePos,0x09AFEC60                 ; Gathering Hall Title X/Y pos
.definelabel GHRoomSelCol1X,0x09AFEC64                    ; Column 1 X pos 
.definelabel GHRoomSelColY,0x09AFEC66                     ; Column Y pos
.definelabel GHRoomSelColLead,0x09AFEC68                  ; Column leading
.definelabel GHRoomSelCursor1X,0x09AFEC6A                 ; Column 1 cursor X pos
.definelabel GHRoomSelCol2X,0x09AFEC6C                    ; Column 2 X pos
.definelabel GHRoomSelCursor2X,0x09AFEC6E                 ; Column 2 cursor X pos
.definelabel SmithyEquipHeadBGPos,0x09AFEEE6              ; Smithy/Shop equipment header (above the list) background X/Y pos
.definelabel SmithyEquipHeadBGScl,0x09AFEEEA              ; Scale of background
.definelabel SmithyEquipHeadTxtPos,0x09AFEEEE             ; Text X/Y pos
.definelabel ItmShopBuyAmtTxtPos,0x09AFEF80               ; Shop buy amount # X/Y pos
.definelabel ItmShopBuyAmtArwUpPos,0x09AFEF84             ; Top arrow X/Y pos
.definelabel ItmShopBuyAmtArwDwPos,0x09AFEF88             ; Bottom arrow X/Y pos
.definelabel NPCQstPageIndArwPos,0x09AFF490               ; Quest page indicator "arrow" X pos
.definelabel NPCQstPageIndBGPos,0x09AFF49C                ; Quest page indicator background X pos
.definelabel NPCQstPageRewardAmtPos,0x09AFF578            ; Quest page reward # X/Y pos
.definelabel NPCQstPageFeeAmtPos,0x09AFF584               ; Contract fee X/Y pos
.definelabel NPCQstPageTimeAmtPos,0x09AFF590              ; Time limit X/Y pos
.definelabel NPCQstPageLocationPos,0x09AFF59C             ; Location X/Y pos
.definelabel GHQstBrdPlayersAmtPos,0x09AFF8A8             ; Gathering Hall quest board players amount X/Y pos
.definelabel GHQstBrdRewardAmtPos,0x09AFF8CC              ; Reward # X/Y pos
.definelabel GHQstBrdFeeAmtPos,0x09AFF8D8                 ; Contract fee X/Y pos
.definelabel GHQstBrdTimeAmtPos,0x09AFF8E4                ; Time limit X/Y pos
.definelabel GHQstBrdLocationPos,0x09AFF8F0               ; Location X/Y pos
.definelabel TrenyaDestBGPos,0x09AFFA90                   ; Trenya destination background X/Y pos
.definelabel TrenyaDestBGScl,0x09AFFA94                   ; Background scale
.definelabel TrenyaDestTxtScl,0x09AFFA98                  ; Text scale
.definelabel TrenyaDestTxtColor,0x09AFFA9A                ; "Destination" color
.definelabel TrenyaDestWinStyle,0x09AFFA9B                ; Window style
.definelabel TrenyaDestTxtPos,0x09AFFA9C                  ; Text X/Y pos
.definelabel TrenyaDestTxtLead,0x09AFFAA0                 ; Text lead
.definelabel TrenyaDestTxtLine,0x09AFFAA2                 ; Number of lines
.definelabel TrenyaDestHiLiPos,0x09AFFAAC                 ; Highlight X/Y pos
.definelabel TrenyaDestHiLiScl,0x09AFFAB0                 ; Highlight scale
.definelabel TrenyaDestTitlePos,0x09AFFAB4                ; "Destination" X/Y pos
.definelabel TrenyaDestPtsBGPos,0x09AFFAB8                ; Points value selection background X/Y pos
.definelabel TrenyaDestPtsBGScl,0x09AFFABC                ; Scale
.definelabel TrenyaDestPtsTxtScl,0x09AFFAC0               ; Text Scale
.definelabel TrenyaDestPtsTxtColor,0x09AFFAC2             ; "PokkePts" text color
.definelabel TrenyaDestPtsWinStyle,0x09AFFAC3           ; Window style
.definelabel TrenyaDestPtsTxtPos,0x09AFFAC4               ; Text X/Y pos
.definelabel TrenyaDestPtsTxtLead,0x09AFFAC8              ; Text leading
.definelabel TrenyaDestPtsTxtLine,0x09AFFACA              ; Number of lines
.definelabel TrenyaDestPtsHiLiPos,0x09AFFAD4              ; Highlight X/Y pos
.definelabel TrenyaDestPtsHiLiScl,0x09AFFAD8              ; Highlight Scale
.definelabel TrenyaDestPtsTitlePos,0x09AFFADC             ; "PokkePts" X/Y pos
.definelabel ChestCombineBGAPos,0x09B05B58                ; Chest combine items "Material A" background X/Y pos
.definelabel ChestCombineBGAScl,0x09B05B5C                ; Background Scale
.definelabel ChestCombineTxtAScl,0x09B05B60               ; Text Scale
.definelabel ChestCombineTxtAColor,0x09B05B62             ; "Material A" text color
.definelabel ChestCombineBGAWinStyle,0x09B05B63           ; Window style
.definelabel ChestCombineTxtAPos,0x09B05B64               ; Text X/Y pos
.definelabel ChestCombineTxtALead,0x09B05B68              ; Text leading
.definelabel ChestCombineBGBPos,0x09B05B70                ; Chest combine items "Material B" background X/Y pos
.definelabel ChestCombineBGBScl,0x09B05B74                ; Background scale 
.definelabel ChestCombineTxtBScl,0x09B05B78               ; Text scale
.definelabel ChestCombineTxtBColor,0x09B05B7A             ; "Material B" text color
.definelabel ChestCombineBGBWinStyle,0x09B05B7B           ; Window style
.definelabel ChestCombineTxtBPos,0x09B05B7C               ; Text X/Y pos
.definelabel ChestCombineTxtBLead,0x09B05B80              ; Text leading
.definelabel ArmColorBGScl,0x09B05C40                     ; Armor color background scale
.definelabel ChestArrangeSubBoxScl,0x09B05CB8             ; Chest "Arrange Items" sub menu (Item/Equipment) scale
.definelabel ChestMoveAmtTxtPos,0x09B05D60


