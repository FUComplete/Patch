; Blademaster weapons
;
; Example structure:
; .org CarbaliteSword
;   .dh 10        ; Model
;   .db 5         ; Rarity
;   .db 0         ; Unk1
;   .dw 70000     ; Price
;   .dh 0x0,0x2   ; Sharpness (unsure how its calculated)
;   .dh 190       ; Attack
;   .db 0         ; Defense
;   .db 0         ; Affinity
;   .db 0         ; Element Type
;   .db 0         ; Element Value
;   .db 0         ; Status Type
;   .db 0         ; Status Value
;   .db 0         ; Slots
;   .db 0         ; HH notes/GL type
;   .db 0         ; Unk2 
;   .dh 65        ; Sort order (based on weapon type in chest)
;   .db 0         ; Unk3
;
; Note: for dual blades with dual ele/status attributes please see dualattribref.asm
;
; Example structure:
; .org SnowVenomAttrib
;   .dh 867       ; Weapon ID
;   .dh 128       ; Ele/Status ID A
;   .dh 12        ; Value A
;   .dh 2         ; Ele/Status ID B
;   .dh 8         ; Value B
;
