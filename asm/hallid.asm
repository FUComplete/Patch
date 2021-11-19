.ifdef jp
// GameID in lobby_task.ovl
  .org AdhocGameID
    .ascii "FUCM05500"
.else
  .org AdhocGameID
    .ascii "FUCM10391"
.endif
// HallIDs for Guild/Arena
  .org AdhocGuildHallID
    .ascii "FUCMQ0"
  .org AdhocArenaHallID
    .ascii "FUCMA0"

