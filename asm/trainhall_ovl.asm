// arcade_task.ovl handles training hall related functions
// "Training Hall" room selection menu
.ifdef jp
.else 
  .org TrainHallRoomSelBGX
    .dh 77
  .org TrainHallRoomSelBGY
    .dh 6
  .org TrainHallRoomSelBGW
    .dh 326
  .org TrainHallRoomSelBGH
    .dh 260
  .org TrainHallRoomSelTitlePos
    .dh 170       // X pos
    .dh 20        // Y pos
  .org TrainHallRoomSelCol1X
    .dh 107
  .org TrainHallRoomSelCol2X
    .dh 254
  .org TrainHallRoomSelColY
    .dh 56
  .org TrainHallRoomSelCursor1X
    .dh 91
  .org TrainHallRoomSelCursor2X
    .dh 238
  // fix player/password alignment a little....
  .org 0x09A654D0
    .dh 412        // amount of players X pos 
  .org 0x09A65594
    .dh 406        // password set prompt X pos
.endif
// Increase limit of quest reads, decrease block size
.org 0x09A5EF54
  .dh 14 // amount to show
.org 0x09A5EF5C
  .dh 8880       //
.org 0x09A5F3A8  // these deal with block size
  .dh 8864       // and quest ID positions...
.org 0x09A69508  //
  .dh 8880       //
// Reallocation
.org 0x09A5EEF8
  .dh 0
.org 0x09A5EF14
  .dh 32
.org 0x09A5EF1C
  j     0x08BC3030
  nop
.org 0x09A69500
  .dh 0
.org 0x09A69510
  .dh 32
.org 0x09A69514
  j     0x08BC3050
  nop