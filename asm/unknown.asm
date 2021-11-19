// Unknown values from my previous patch
// Seem to be Yes/No related? More than
// likely part of the Save/Load prompts
.org Unknown1
  .dh 198
.org Unknown2 // this one might not..
  .dh 174 
// Guildcard related... probably Treasure
.org Unknown3
  .dh 318
.org Unknown4
  .dh 378
// Rewrite Equip STR PTR test
.org EquipDescStrIDTbl
  .import "data/equipdesc.bin" 
