.ifdef jp
.else
  // Fix misaligned "OFF" under status display 
  .org OptionsMenuMDisplayTxtX
    .dh 162
.endif
// remove instances of data install in options menu
.org 0x088398D8
  .dh 2
.org 0x08839B5C
  .dw 0
.org 0x08839BD4
  .dh 2
