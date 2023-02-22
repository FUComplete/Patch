@@VillageNPCDD:
    ; Increase the draw distance of NPCs and range for animations
    .org 0x09AB87BC
        lui     v1,0x45BC   ; Animation 
    .org 0x09AB8868
        lui     v1,0x45BC   ; NPC draw group 1
    .org 0x09AB8880
        lui     v1,0x45BC   ; NPC draw group 2

@@AutoPreviewEquips:
    ; Enable auto preview of equipments in shops
    .org 0x09A80E1C
        li      v1,0x1
    .org 0x09A9B9E8
        li      v0,0x1
    .org 0x09A9BD80
        li      v0,0x1
    .org 0x09A9BDE4
        li      v0,0x1
    .org 0x09A9DDF8
        li      v0,0x1
    .org 0x09A9E334
        li      v0,0x1
    .org 0x09A9E394
        li      v0,0x1
    .org 0x09A9F968
        li      v0,0x1
    .org 0x09A9FC60
        li      v0,0x1
    .org 0x09A9FCC0
        li      v0,0x1
    ; Hair auto preview
    .org 0x09A5B8D8
        li      v0,0x1
    .org 0x09A5C068
        li      v1,0x1
    .org 0x09A5D8B8
        li      v1,0x1

@@BedSavePrompt:
    ; Exit game? prompt
    .org 0x09AAC538
        .dh     198     ; Yes/No X pos

@@BonusDLC:
    ; Poogie outfits
    .org 0x09A5C700
        la      v0,0x07FFFBFF   ; Sleepy Pig White
        nop
    .org 0x09A5C740
        la      v0,0x07FFFBFF   ; Angel Leotard
        nop
    .org 0x09A5C780
        la      v0,0x07FFFBFF   ; Famitsu Disguise
        nop
    .org 0x09A5C7C0
        la      v0,0x07FFFBFF   ; Mafumofu Jumpsuit
        nop
    ; Trenya unlock
    .org 0x09A60684
        la      v0,0x07FFFBFF
        nop

@@NPCShopUI:
    ; Equip shops
    .org 0x09A7CD04
        .dh     64      ; Smithy "Change view" text Y pos
    .org 0x09AFEEE6
        .dh     220     ; Equipment type header BG X pos
    .org 0x09AFEEEA
        .dh     140     ; Equipment type header BG Width
    .org 0x09AFEEEE
        .dh     224     ; Equipment type header text X pos
    ; Item shops
    .org 0x09AFEF80
        .dh     221     ; Buy amount text X pos
        .dh     64      ; Buy amount text Y pos
        .dh     222     ; Buy amount arrow up X pos
        .dh     48      ; Buy amount arrow up Y pos
        .dh     222     ; Buy amount arrow down X pos
        .dh     80      ; Buy amount arrow down Y pos

@@GuildHallRoomSelect:
    ; Deals with the room selection screen when going online
    .org 0x09A74208
        .dh     77      ; BG X pos
    .org 0x09A7420C
        .dh     6       ; BG Y pos
    .org 0x09A74210
        .dh     326     ; BG Width
    .org 0x09A74214
        .dh     260     ; Height
    .org 0x09AFEC60
        .dh     160     ; Title text X pos
        .dh     21      ; Title text Y pos
    .org 0x09AFEC64
        .dh     107     ; Left room column X pos
    .org 0x09AFEC6A
        .dh     91      ; Left room column cursor X pos
    .org 0x09AFEC6C
        .dh     255     ; Right room column X pos
    .org 0x09AFEC6E
        .dh     238     ; Right room column cursor X pos

@@EquipSetUI:
    .org 0x09AE62AC
        .dh     72      ; Equipment set status window ":" X pos

@@ArmorColorUI:
    .org 0x09AE1034
        .dh     202     ; Undo button Y pos
    .org 0x09AE1050
        .dh     -4      ; Undo button outline X pos offset
    .org 0x09AE106C
        .dh     36      ; Undo button outline Width
    .org 0x09AE1074
        .dh     21      ; Undo button outline Height
    .org 0x09B05C40
        .dh     19      ; Window Width 

@@ChestUI:
    ; Combine
    .org 0x09ADEE6C
        .dh     30      ; Material B "Please select" text X pos 
    .org 0x09ADEFF0
        .dh     30      ; Material A "Please select" text X pos
    .org 0x09B05B58
        .dh     56      ; Material A BG X pos
    .org 0x09B05B5C
        .dh     182     ; Material A BG Width
    .org 0x09B05B64
        .dh     64      ; Material A text X pos
    .org 0x09B05B70
        .dh     56      ; Material B BG X pos
    .org 0x09B05B74
        .dh     182     ; Material B BG Width
    .org 0x09B05B7C
        .dh     64      ; Material B text X pos
    ; Arrange Item/Equip
    .org 0x09B05CB8
        .dh     9       ; Arrange Items sub menu BG Width
    ; Take Out Item
    .org 0x09B05D60
        .dh     230     ; Place "amount" into inventory X pos

@@FarmUI:
    ; Crops
    .org 0x09A8D81C
        .dh     42      ; Plant "None" text X pos
    .org 0x09A8D864
        .dh     42      ; Plant "Item" text X pos
    .org 0x09A8D8D0
        .dh     42      ; Plant "-----------" text X pos
    ; Trenya
    .org 0x09AFFA90
        .dh     368     ; Destination BG X pos
    .org 0x09AFFA94
        .dh     104     ; Destination BG Width
    .org 0x09AFFA9C
        .dh     376     ; Locations text X pos
    .org 0x09AFFAAC
        .dh     374     ; Destination highlight selection X pos
    .org 0x09AFFAB0
        .dh     92      ; Destination highlight selection Width
        .dh     17      ; Destination highlight selection Height
    .org 0x09AFFAB4
        .dh     382     ; "Destination" text X pos
    .org 0x09AFFAB8
        .dh     296     ; Destination PTS BG X pos
    .org 0x09AFFAC4
        .dh     304     ; Destination PTS text X pos
    .org 0x09AFFAD4
        .dh     302     ; Destination PTS highlight selection X pos
    .org 0x09AFFADA
        .dh     17      ; Destination PTS highlight selection Height
    .org 0x09AFFADC
        .dh     304     ; Destination PTS "PokkePts" text X pos
    ; Treshis Disciple
    .org 0x09AFDE98
        ; Point Exchange
        .dh     222     ; "Quantity" X pos
        .dh     64      ; "Quantity" Y pos
        .dh     222     ; Quantity arrow up X pos
        .dh     48      ; Quantity arrow up Y pos
        .dh     222     ; Quantity arrow down X pos
        .dh     80      ; Quantity arrow down Y pos

@@GuildhallShopNPC:
    ; Reposition NPC so the feet no longer clip through the floor, fixing the shadow as well.
    .org 0x09B042B4
        .dw     7.5     ; Y pos
        .dw     4535.0  ; Z pos

@@WanderingChefNPC:
    ; Reposition NPC so they arent floating in the air anymore...
    .org 0x09B04040
        .dw     11600.0 ; X pos
        .dw     -97.0   ; Y pos
        .dw     11180.0 ; Z pos

@@QuestGiverUI:
    ; Quest level listing
    .org 0x09A873D8
        .dh     96      ; Required HR nummber X pos
    ; Quest page 
    .org 0x09A889A0
        .dh     51      ; Quest page BG Width (the one with a semi transparent black background and arrows left/right)
    .org 0x09A889E0
        .dh     54      ; Quest page arrow distance
    ; Quest details
    .org 0x09AFF578
        .dh     328     ; Reward amount ":" X pos
    .org 0x09AFF584
        .dh     328     ; Fee amount ":" X pos
    .org 0x09AFF590
        .dh     328     ; Time amount ":" X pos
    .org 0x09AFF59C
        .dh     328     ; Location ":" X pos

@@QuestboardUI:
    ; Posted quest details
    .org 0x09AFF8A8
        .dh     410     ; Players amount X pos
    .org 0x09AFF8CC
        .dh     328     ; Quest Reward X pos
    .org 0x09AFF8D8
        .dh     328     ; Quest Fee X pos
    .org 0x09AFF8E4
        .dh     328     ; Time limit X pos
    .org 0x09AFF8F0
        .dh     328     ; Location X pos

@@EventQuestBlockSize:
    .org 0x09A83510
        .dh     8880    ; Quest block size
    .org 0x09A83618
        .dh     8864    ; Quest ID
