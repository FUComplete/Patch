@@OptionsTextFix:
    .org 0x09A5B1A0
        .db 14  ; Font width
    .org 0x09A5B1C8
        nop     ; Alignment offset
    .org 0x09A5B218
        .dh 267 ; "MIN" text X pos
    .org 0x09A5B324
        .dh 348 ; Confirm/Back text X pos

; TODO Investigate if this is still needed
;
; volume block outline
;
; ╷ ──────────────────────────────┬───
; │ Outline is four lines...      │
; │ No line is correct or square. │
; │ Why draw it this way?         │
; └───────────────────────────────┴───
;                   - IncognitoMan
;
; @@VolumeBlockOutline:
;     .org 0x09A5B9D8
;         .dh 12    ; block outline X pos (right)
;     .org 0x09A5B9EC
;         .dh 11    ; block outline height (right)
;     .org 0x09A5BB00
;         .dh 11    ; block outline Y pos (bottom)
;     .org 0x09A5BC14
;         .dh 11    ; block outline height (left)


@@DataInstallCheck:
    .org 0x09A5AB28
        li      v0,0x0   ; Disable DATA INSTALL check