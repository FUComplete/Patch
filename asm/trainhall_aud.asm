; Small code injection to change read address...
.org 0x08BC3030
  ori   a0,zero,0x8BA
  sll   a0,a0,16
  ori   a0,a0,0x4920
  sll   v1,v1,0x2
  j     0x09A5EF20
.org 0x08BC3050
  ori   v0,zero,0x8BA
  sll   v0,v0,16
  ori   v0,v0,0x4920
  mflo  v1
  j     0x09A69518