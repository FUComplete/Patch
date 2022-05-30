.ifdef jp
.else
  ; "option_task.ovl" related changes...
  ; Reduce font width
  .org 0x09A5B1A0
    .db 14
  ; Fix center alignment
  .org 0x09A5B1C8
    sll       v1,v1,0x0
  ; Shift "min" text to the right 
  .org 0x09A5B218
    .dh 267
  ; confirm/back text hanging on the edge... shift left
  .org 0x09A5B324
    .dh 348
.endif
; disable data install toggle
.org 0x09A5BD94
  .dh 0
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
.org 0x09A5B9D8
  .dh 12    ; block outline X pos (right)
.org 0x09A5B9EC
  .dh 11    ; block outline height (right)
.org 0x09A5BB00
  .dh 11    ; block outline Y pos (bottom)
.org 0x09A5BC14
  .dh 11    ; block outline height (left)
