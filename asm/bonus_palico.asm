; Ignore bonus palico checks (game_sub.ovl)
.org 0x09C1B348
  li    v0,0x7FF      ;
  sll   v0,v0,16      ; Felyne Samurai
  ori   v0,v0,0xFBFF  ;
.org 0x09C1FCD8
  li    v0,0x7FF      ;
  sll   v0,v0,16      ; Elemental Atk Dragon
  ori   v0,v0,0xFBFF  ;