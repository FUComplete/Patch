@@BonusWanderingCat:
    .org 0x09C199E4
        la      a1,0x07FFFBFF   ; Wandering Felyne(?)

@@BonusPalicoArmor:
    .org 0x09C1B348
        la      v0,0x07FFFBFF   ; Felyne Samurai Armor
        nop

@@BonusPalicoEleAtk:
    .org 0x09C1FCD8
        la      v0,0x07FFFBFF   ; Felyne Elemental Atk Dragon
        nop

; These next bonus checks im not sure what they exactly control...
@@BonusUnkn1:
    .org 0x09C2229C
        la      t8,0x07FFBFF
        nop

@@BonusUnkn2:
    .org 0x09C19D64
        la      v1,0x07FFBFF
        nop

; Kitchen related fixes...
@@KitchenMealsUI:
    ; Main "Today's Meals" menu
    .org 0x09CCAF38
        .dh 306     ; Meal window BG X pos
        .skip 2     ; Meal window BG Y pos (skip)
        .dh 166     ; Meal window BG width
        .dh 166     ; Meal window BG height
    .org 0x09CCAF44
        .dh 314     ; Meal list X pos
    .org 0x09CCAF54
        .dh 312     ; Meal highlight indicator X pos
        .skip 2     ; Meal highlight indicator Y pos (skip)
        .dh 154     ; Meal highlight indicator width
        .dh 17      ; Meal highlight indicator height (fix capcoms mistake)
    .org 0x09CCAF5C
        .dh 328     ; "Today's Meals" text X pos
    ; Meal A window
    .org 0x09CCAF60
        .dh 146     ; Meal "A" window BG X pos
    .org 0x09CCAF6C
        .dh 152     ; "Meal A" text X pos
    ; Meal B window
    .org 0x09CCAF74
        .dh 146     ; Meal "B" window BG X pos
    .org 0x09CCAF80
        .dh 152     ; "Meal B" text X pos
    ; Confirm window
    .org 0x09CCAF88
        .dh 210     ; "Order Food" confirmation window BG X pos
    .org 0x09CCAF94
        .dh 218     ; "Order Food" confirmation text X pos
    .org 0x09CCAFA4
        .dh 216     ; "Order Food" highlight X pos

@@FelyneComradeBoard:
    ; Felyne Comrade Board text alignments
    .org 0x09C1FB10
        .dh 92      ; Comrade Board learn/unlearn "Pts Remaining" text X pos 
    .org 0x09C20154
        .dh 106     ; Comrade Board learn/unlearn "pts" text X pos
    .org 0x09CCB678
        .ascii "%10d%s" ; Comrade Board learn/unlearn "pts" text offset formatting (move 10 over)
