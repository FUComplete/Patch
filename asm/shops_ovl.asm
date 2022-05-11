.ifdef jp
.else
; Various shop UI changes
; Smithy
.org SmithyArmTypeViewTxtY
  .dh 64
; Affects both Smithy and Buy shop
.org SmithyEquipHeadBGPos
  .dh 220     ; X pos
.org SmithyEquipHeadBGScl
  .dh 140     ; Width
.org SmithyEquipHeadTxtPos
  .dh 224     ; X pos
; Item Shop
.org ItmShopBuyAmtTxtPos
  .dh 221     ; X pos
  .dh 64      ; Y pos
.org ItmShopBuyAmtArwUpPos
  .dh 222     ; X pos
  .dh 48      ; Y pos
.org ItmShopBuyAmtArwDwPos
  .dh 222     ; X pos
  .dh 80      ; Y pos
.endif
; Auto enable equipment previews
.org 0x09A80C78
  sb     a1,0x2c(a0)
.org 0x09A80E14
  .dh 0xF
