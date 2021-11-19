// Character encoding fixes:
// Fixes various encodings of UTF8MB3 and 
// UTF8 full-width to half-width ASCII
.org UTF8MB3ReadByte
  .dh 0x1 // Just read the first byte 
// Write new character tables to use half width
// characters instead...
.org UTF8SpecChar
  .import "data/charencode.bin",0x00,188
.org UTF8Char
  .import "data/charencode.bin",0xC0,184
.org UTF8MB3Char
  .import "data/charencode.bin",0x180,384
