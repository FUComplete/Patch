// Guildcard UI
// Use English OSK only 
.org GCDescriptOSKType
  .db 0x2
//  Fix character width from full to half
.org GCEditCharWidth
  sllv      v0,v0,zero
.org GCCharWidth
  sllv      v0,v0,zero
// Hunter Diary page
.org GCHunterDiaryClrWepX
  .dh 180
.org GCHunterDiaryImprvWepX
  .dh 116
// Felyne Diary
.org GCFelyneDiaryTxtAlign1
  .dh 128
.org GCFelyneDiaryMaxFondTxtX
  .dh 301
.org GCFelyneDiaryMaxFondTxtY
  .dh 196
.org GCFelyneDiaryNumComradeX
  .dh 364
.org GCFelyneDiaryNumComradeY
  .dh 212
.org GCFelyneDiaryComradeTxtX
  .dh 392
.org GCFelyneDiaryComradeTxtY
  .dh 212
// Treasure
.org GCTreasureAreaStrPTR
  li        v1,0x089A9A68
.org GCTreasureAreaCharLimit
  sb        zero,0x94(v0)
.org GCTreasureAreaSTRID
  .dh 1   // Mountains
  .dh 2   // Jungle
  .dh 3   // Desert
  .dh 4   // Swamp
  .dh 5   // Forest&Hills
  .dh 6   // Volcano
  .dh 7   // Great Forest
.org GCTreasureColX
  .dh 312
.org GCTreasurePTValLeftBG
  .dh 395
.org GCTreasurePTValCntrBG
  .dh 395
.org GCTreasurePTValRghtBG
  .dh 395
.org GCTreasurePTValNum
  .dh 452
.org GCTreasureCrownX
  .dh 378

