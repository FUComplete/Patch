// Crypto for DATA.BIN

// NULL Keys
.org DATABINCryptoDef1_1
  .dh 0x0
.org DATABINCryptoDef1_2
  .dh 0x0
.org DATABINCryptoDef2_1
  .dh 0x0
.org DATABINCryptoDef2_2
  .dh 0x0
.org DATABINCryptoMod1
  .dh 0x0
.org DATABINCryptoMod2
  .dh 0x0

// Rewrite Sub Table
.org DATABINCryptoSubTable
  .import "data/databin.crypt"
