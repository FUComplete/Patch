; Ignore check for trenya bonus (lobby_task.ovl)
.org 0x09A60684
  li    v0,0x7FF
  sll   v0,v0,16
  ori   v0,v0,0xFBFF
