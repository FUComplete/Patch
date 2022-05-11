.ifdef jp
  ; This handles page selector format
  .org EquipDetailPgTxtFmt
    .ascii "%2d/%d "
.else
  .org EquipDetailPgTxtFmt
    .ascii "%2d/%d "
  ; Equipment Details UI
  .org EquipDetailResValX
    .dh 84
  .org EquipDetailArmSeriesX
    .dh 154
  .org EquipDetailHunterTypeX
    .dh 98
  .org EquipDetailSlotsX
    .dh 49
.endif
