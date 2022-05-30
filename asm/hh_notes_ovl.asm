; This gives HH more of a frontier note mechanic where notes
; only drop if your weapon is sheathed. Need to see if this
; would be a change to implement in code or as a cwcheat.
;
; Optimize clear code and check if sheathed
.org 0x09BAC0B8
  lb    v0,0x327(a0)
  bne   v0,zero,0x09BAC0D8
  nop
  sb    zero,0x1102(a0)
  sw    zero,0x1103(a0)
  sw    zero,0x1107(a0)
  nop
  nop
  jr    ra
  li v0,0x0
