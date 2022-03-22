// Modify the read address for quest table to
// a new location (0x08A32510)
.ifdef jp
  // .org 0x09A84A94
  //   .dh 0x8A4
  // .org 0x09A84A9C
  //   .dh 0x7510
.else
  // .org 0x09A84A94
  //   .dh 0x8A3
  // .org 0x09A84A9C
  //   .dh 0x2510
// Gathering Hall room selectiom window
  .org GHRoomSelBGX
    .dh 77
  .org GHRoomSelBGY
    .dh 6
  .org GHRoomSelBGW
    .dh 326
  .org GHRoomSelBGH
    .dh 260
  .org GHRoomSelTitlePos
    .dh 160
    .dh 21
  .org GHRoomSelCol1X
    .dh 107
  .org GHRoomSelCursor1X
    .dh 91
  .org GHRoomSelCol2X
    .dh 255
  .org GHRoomSelCursor2X
    .dh 238
  // Required HR # at NPC
  .org GHReqHRNumX
    .dh 96
  // Quest board (posted quest)
  .org GHQstBrdPlayersAmtPos
    .dh 410     // X pos
  .org GHQstBrdRewardAmtPos
    .dh 328     // X pos
  .org GHQstBrdFeeAmtPos
    .dh 328     // X pos
  .org GHQstBrdTimeAmtPos
    .dh 328     // X pos
  .org GHQstBrdLocationPos
    .dh 328     // X pos
.endif
// Quest amount/block size 
.org 0x09A822EC
  .dh 18      // Amount of quests to read
.org 0x09A83510
  .dh 8880    // Quest block size
.org 0x09A835B4
  .dh 18      // Amount of quests
.org 0x09A83618
  .dh 8864    // Quest ID
