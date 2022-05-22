; Bowgun/Bow weapons
;
; Example structures:
; .org ShootersBarrel
;   .dh 115       ; Model
;   .db 0         ; Rarity
;   .db 0         ; Unk1
;   .dw 900       ; Price
;   .dh 190       ; Attack
;   .db 0         ; Defense
;   .db 2         ; Recoil(bowgun)/Charge attack levels(bow)
;   .db 3         ; Slots
;   .db 0         ; Affinity
;   .dh 1         ; Sort order (based on weapon type in chest)
;   .db 3         ; Bullet/Charge attack table
;   .db 0         ; Element Type (bow only)
;   .db 0         ; Element Value (bow only)
;   .db 2         ; Reload (Unk2 for bow)
;   .db 0         ; Unk3
;   .db 0         ; Unk4
;   .db 0         ; Unk5
;   .db 0         ; Unk6
;   .dw 0x0B,0x82,0x70,0x35   ; bit flags for shot/coating types
; .org CourageousWish
;   .dh 312       ; Model
;   .db 7         ; Rarity
;   .db 0         ; Unk1
;   .dw 79200     ; Price
;   .dh 220       ; Attack
;   .db 0         ; Defense
;   .db 3         ; Recoil(bowgun)/Charge attack levels(bow)
;   .db 2         ; Slots
;   .db 0         ; Affinity
;   .dh 58        ; Sort order (based on weapon type in chest)
;   .db 38        ; Bullet/Charge attack table
;   .db 1         ; Element Type (bow only)
;   .db 8         ; Element Value (bow only)
;   .db 2         ; Reload (Unk2 for bow)
;   .db 0         ; Unk3
;   .db 0         ; Unk4
;   .db 0         ; Unk5
;   .db 0         ; Unk6
;   .dw 0x72,0x00,0x00,0x00   ; bit flags for shot/coating types
