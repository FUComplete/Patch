// Ignore checks on granny/wandering chef (BOOT.BIN)
.org 0x08856B64
  li    v1,0x7FF      //
.skip 4               //
  sll   v1,v1,16      // Granny bonus items
  ori   v1,v1,0xFBFF  //
.org 0x08857954
  li    a0,0x7FF      //
  sll   a0,a0,16      // Wandering Felyne Chef
  ori   a0,a0,0xFBFF  //
.org 0x088573A8
  li    a1,0x7FF      //
.skip 8               //
  sll   a1,a1,16      // Unknown
  ori   a1,a1,0xFBFF  //
.org 0x08856A54
  li    v0,0x7FF      //
.skip 4               //
  sll   v0,v0,16      // Unknown
  ori   v0,v0,0xFBFF  //
