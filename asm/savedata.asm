// Fix various ID and folder names

.org 0x08997238
  .ascii "ULUS10391MOD"

.org 0x0899727C
  .ascii "ULUS10391MOD"

.org 0x089AE784
  .ascii "ULUS10391"

.org 0x089AF904
  .ascii "ULUS10391"

.org 0x089AFF58
  .ascii "ULUS10391"

.org 0x089AFF74
  .ascii "ULUS10391MOD"

// Change key to match MHFU
.org 0x089AFF98
  .ascii "3Nc94Hq1zOLh8d62Sb69"

// Need to make this cleaner...
.org 0x088C2384
  .dh 0x4A
.org 0x088C23A4
  .dh 0x1F
.org 0x088C23B0
  .dh 0xF3
.org 0x088C23B8
  .dh 0x59
.org 0x088C23C0
  .dh 0xAE
.org 0x088C23C8
  .dh 0xB6
.org 0x088C23D0
  .dh 0xEF
.org 0x088C23D8
  .dh 0xF8
.org 0x088C23E0
  .dh 0x1C
.org 0x088C23E8
  .dh 0xA8
.org 0x088C23F0
  .dh 0xCB
.org 0x088C23F8
  .dh 0x23
.org 0x088C2400
  .dh 0xBC
.org 0x088C2408
  .dh 0xA5
.org 0x088C2410
  .dh 0x7B
.org 0x088C2418
  .dh 0xB3

// MHF2 Save Import Key/Folder swap

// GameID
.org 0x089B0070
  .ascii "ULUS10266"

// Key
.org 0x088C3F0C
  .dh 0xB9
.org 0x088C3F2C
  .dh 0xA9
.org 0x088C3F38
  .dh 0x00
.org 0x088C3F40
  .dh 0x9D
.org 0x088C3F48
  .dh 0x6F
.org 0x088C3F50
  .dh 0xC2
.org 0x088C3F58
  .dh 0xB4
.org 0x088C3F60
  .dh 0xEB
.org 0x088C3F68
  .dh 0xF4
.org 0x088C3F70
  .dh 0xF8
.org 0x088C3F78
  .dh 0xCA
.org 0x088C3F80
  .dh 0xB2
.org 0x088C3F88
  .dh 0xD7
.org 0x088C3F90
  .dh 0x72
.org 0x088C3F98
  .dh 0xE9
.org 0x088C3FA0
  .dh 0xAB

// Modify SaveData PARAM.SFO strings to english
.org ParamSFOStr
  .ascii  "Monster Hunter Freedom Unite"
  .fill   12,0
  .ascii  "Game Data"
  .fill   7,0
  .ascii  "Game Data for Monster Hunter Freedom Unite."
  .fill   17,0
