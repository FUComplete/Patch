// "option_task.ovl" related changes...
// Reduce font width
.org 0x09A5B1A0
  .db 14
// Fix center alignment
.org 0x09A5B1C8
  sll       v1,v1,0x0
// Shift "min" text to the right 
.org 0x09A5B218
  .dh 267
// confirm/back text hanging on the edge... shift left
.org 0x09A5B324
  .dh 348
