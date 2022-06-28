; Experimental freecam code.
;
; This still needs work, in its current state its probably 90% there...
; the comments may/may not be right and you are warned...
; things that are still needed to figure out are:
;   - Y axis height limiter
;   - Remove target/cam collision
;   - Finish writing up the cwcheat activator side
;   - Probably other things... ¯\_(ツ)_/¯
;
; Current FreeCam activator side for cwcheat..
;
; _C1 Freecam Activate
; _L 0x20065688 0x0A292804
; _L 0x2006568C 0x00000000
; _L 0x20065690 0x0A292833
; _L 0x20065694 0x00000000
; _L 0x20087534 0x0A2928B6
; _L 0x40087538 0x000A0001
; _L 0x00000000 0x00000000
; _L 0x20087698 0x0A29288B
; _L 0x4008769C 0x00070001
; _L 0x00000000 0x00000000
;
; Reserved for checking ovl state and button timers... also enable/disable
; flags for freecam.
;
.org 0x08A4A000 
  .ascii  "game"  ; game_task.ovl
  .ascii  "lobb"  ; lobby_task.ovl
  .db     0       ; time val
  .db     60      ; max time val
;
; This first block of code changes player movement coords into 
; camera/target movement and also checks flags for which set of
; coords to modify.
;
.org 0x08A4A010
  beq     s1,s2,@@GameStateCheck  ; really need to figure a better way to detect and prevent crashing...
  nop

@@PlayerMove:
  lv.q    C000,0(v1)          ;
  lv.q    C010,0(v0)          ;
  vadd.t  C000,C000,C010      ; we run the original function because we only 
  sv.q    C000,0(v1)          ; want to redirect player movement to cam/trgt
  j       0x08865690          ;
  nop
;
; GameStateCheck checks what ovl is loaded in the game, in this case if its game_task.ovl we know we are 
; in a quest... if its lobby_task.ovl we are either in the village somewhere or the guildhall.
;
@@GameStateCheck:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ; address where our strings are to check by
  lw      s1,0x0(s0)    ; loading into s1 "game"
  lui     s2,0x9A5      ; 
  ori     s2,s2,0xA5A0  ; address where the ovl string is... we load it
  lw      s2,0x0(s2)    ; into s2

@@GameOVLCheck:
  bne     s1,s2,@@LobbyOVLCheck     ; check if game_task.ovl is loaded if not 
  lw      s1,0x4(s0)                ; we check to see if lobby_task.ovl is
  j       @@FreeCamFlagCheck        ; loaded instead.
  nop

@@LobbyOVLCheck:
  bne     s1,s2,@@PlayerRegRestore  ; for right now not functional but will allow
  nop                               ; freecam to work in village...
  j       @@PlayerRegRestore        ;

@@PlayerRegRestore:
  lui     s2,0x90A
  ori     s2,s2,0xF180
  move    s1,s2
  addiu   s0,s1,0x80
  j       @@PlayerMove
  nop
;
; main freecam code
;
@@FreeCamFlagCheck:
  lb      s1,0xC(s0)                ; load the first flag
  bne     s1,zero,@@CamPosControl   ; if flag is 1, branch... otherwise load origianl code
  nop
  j       @@PlayerRegRestore             

@@CamPosControl:
  lb      s1,0xD(s0)                  ; check the second flag 
  bne     s1,zero,@@TargetPosControl  ; branch if equal to 1
  addiu   s1,t3,-0xDA0                ; write address of cam coord
  j       @@CoordWrite
  nop

@@TargetPosControl:
  addiu   s1,t3,-0xD90        ; write address of target coord

@@CoordWrite:
  lv.q    C000,0(s1)
  lv.q    C010,0(v0)
  vadd.t  C000,C000,C010
  sv.q    C000,0(s1)
  lui     s2,0x90A      ;
  ori     s2,s2,0xF180  ; we fix the original registers here before
  move    s1,s2         ; jumping back
  addiu   s0,s1,0x80    ;
  j       0x08865690
  nop

; ------------------- lets work on button input code now.
;
; Controls:
; 
; L+R+X         - activate (0x43 @ 0x090AF60D)
; L+X           - switch between cam/target (0x41)
; L+R+Triangle  - teleport player to cam pos (0x13)
; Analog        - move along X/Z axis
; DPAD Up       - increase Y axis
; DPAD Down     - decrease Y axis
;
; updated for more control
;
; L+Triangle    - Cam lock toggle (0x11)
; L+Circle      - Target lock toggle (0x21)
;
  beq     s1,s2,@@CheckButton  ; really need to figure a better way to detect and prevent crashing...
  nop
  j       0x08865694
  nop      

@@CheckButton:
  lb      s0,0x48D(s2)  ; we load the current pressed button
  li      s1,0x43
  beq     s0,s1,@@FreeCamToggle
  nop
  li      s1,0x41
  beq     s0,s1,@@CamTypeToggle
  nop
  li      s1,0x11
  beq     s0,s1,@@CamLockToggle
  nop
  li      s1,0x21
  beq     s0,s1,@@TargetLockToggle
  nop  
  li      s1,0x13
  beq     s0,s1,@@FreeCamToggle ; eventually teleport code
  nop
  move    s1,s2
  j       @@GenericTimerCheck      ; need to make this jump to timer check code 
  addiu   s0,s1,0x80 

@@TargetLockToggle:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ;
  lb      s1,0x8(s0)    ; load timer
  bne     s1,zero,@@FreeCamTimer
  lb      s2,0x9(s0)    ; load max timer value
  lb      s1,0xF(s0)    ;
  xori    s1,s1,0x1     ; check and swap the flag
  sb      s1,0xF(s0)    ;
  li      s1,0x1        ; begin timer
  sb      s1,0x8(s0)    ;

@@CamLockToggle:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ;
  lb      s1,0x8(s0)    ; load timer
  bne     s1,zero,@@FreeCamTimer
  lb      s2,0x9(s0)    ; load max timer value
  lb      s1,0xE(s0)    ;
  xori    s1,s1,0x1     ; check and swap the flag
  sb      s1,0xE(s0)    ;
  li      s1,0x1        ; begin timer
  sb      s1,0x8(s0)    ;

@@CamTypeToggle:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ;
  lb      s1,0x8(s0)    ; load timer
  bne     s1,zero,@@FreeCamTimer
  lb      s2,0x9(s0)    ; load max timer value
  lb      s1,0xD(s0)    ;
  xori    s1,s1,0x1     ; check and swap the flag
  sb      s1,0xD(s0)    ;
  li      s1,0x1        ; begin timer
  sb      s1,0x8(s0)    ;

@@FreeCamToggle:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ;
  lb      s1,0x8(s0)    ; load timer
  bne     s1,zero,@@FreeCamTimer
  lb      s2,0x9(s0)    ; load max timer value
  lb      s1,0xC(s0)    ;
  xori    s1,s1,0x1     ; check and swap the flag
  sb      s1,0xC(s0)    ;
  li      s1,0x1        ; begin timer
  sb      s1,0x8(s0)    ;

@@FreeCamRegFix:
  lui     s2,0x90A      ;
  ori     s2,s2,0xF180  ; we fix the original registers here before
  move    s1,s2         ; jumping back
  j       0x08865694    ;
  addiu   s0,s1,0x80    ;  

@@FreeCamTimer:
  beq     s1,s2,@@FreecamTimerReset  
  addiu   s1,s1,0x1
  sb      s1,0x8(s0)
  j       @@FreeCamRegFix
  nop

@@FreecamTimerReset:
  sb      zero,0x8(s0)
  j       @@FreeCamRegFix
  nop
;
; We need a general timer...
;
@@GenericTimerCheck:
  lui     s0,0x8A4      ; 
  ori     s0,s0,0xA000  ;
  lb      s1,0x8(s0)    ; load timer
  bne     s1,zero,@@GenericTimerAdder
  lb      s2,0x9(s0)    ; load max timer value
  j       @@FreeCamRegFix
  nop

@@GenericTimerAdder:
  beq     s1,s2,@@FreecamTimerReset  
  addiu   s1,s1,0x1
  sb      s1,0x8(s0)
  j       @@FreeCamRegFix
  nop
; -------------------------------- we know this works from new2 so no need to touch *yet*
;
; Camera 
;
; .org 0x08887698
;   j ADDR
;   nop
;
; CamPos = 08A4A1C4 - now 08A4A22C
;
@@CamPos:
  lui     a0,0x8A4            ; load the address where we check flags
  ori     a0,a0,0xA00E        ;
  lb      a1,0x0(a0)          ; load the first flag
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction 
  nop
  swc1    f2,0x40(s4)
  lwc1    f2,0x204(s3)
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction 
  add.s   f1,f2,f1
  swc1    f1,0x44(s4)
  lwc1    f1,0x58(s4)
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction 
  add.s   f0,f1,f0
  swc1    f0,0x48(s4)
  lbu     v0,0x98(s5)
  beq     a1,zero,@@CamRegRestore + 0x8   ; if flag is 0, branch... 
  lb      a1,0x1(a0)                      ; load second flag
  bne     a1,zero,@@CamRegRestore + 0x8   ; if not zero branch 
  nop

@@CamVerticalUp:
  addiu   a0,s3,0x48C         ; address for dpad (0x10 up, 0x40 down)
  lb      a1,0x0(a0)
  li      a0,0x10
  bne     a1,a0,@@CamVerticalDown   ; if it doesnt equal up check for down 
  li      a0,0x40                   ; write 0x40 before jumping to down check
  lui     a0,0x41A0           ; we want to add 20
  mtc1    a0,f13
  lwc1    f14,0x44(s4)
  add.s   f13,f14,f13
  swc1    f13,0x44(s4)
  j       @@CamRegRestore           ; to where it fixes floats/regs 
  nop

@@CamVerticalDown:
  bne     a1,a0,@@CamRegRestore + 0x8   ; if it doesnt equal down then ignore 
  lui     a0,0x41A0                     ; we want to sub 20
  mtc1    a0,f13
  lwc1    f14,0x44(s4)
  sub.s   f13,f14,f13
  swc1    f13,0x44(s4)  
  
@@CamRegRestore:
  mtc1    zero,f13            ; fix f13/14 
  mtc1    zero,f14            ;
  addiu   a1,t4,0x20          ; Fix the registers to their original states
  addiu   a0,t4,0xA4          ;
  j       0x088876B4
  nop
;
; Target
;
; .org 0x08887534
;   j ADDR
;   nop
;
; TargetPos: 08A4A270 - now 08A4A2D8
;
@@TargetPos:
  lui     a0,0x8A4            ; load the address where we check flags
  ori     a0,a0,0xA00F        ;
  lb      a1,0x0(a0)          ; load the first flag
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction
  nop
  swc1    f0,0x54(s4)
  lwc1    f0,0x200(s3)
  li      v0,0
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction
  andi    v0,v0,0xFFFF
  swc1    f0,0x50(s4)
  mtc1    v0,f0
  cvt.s.w f0,f0
  lwc1    f1,0x208(s3)
  lui     v0,0x38C9
  bne     a1,zero,. + 0xC     ; if flag is 1, branch... skipping instruction  
  ori     v0,v0,0xFDB
  swc1    f1,0x58(s4)
  beq     a1,zero,@@TargetRegRestore + 0x8  ; if flag is 0, branch... 
  lb      a1,0x1(a0)                        ; load second flag
  beq     a1,zero,@@TargetRegRestore + 0x8  ; if zero branch 
  nop

@@TargetVerticalUp:
  addiu   a0,s3,0x48C         ; address for dpad (0x10 up, 0x40 down)
  lb      a1,0x0(a0)
  li      a0,0x10
  bne     a1,a0,@@TargetVerticalDown  ; if it doesnt equal up check for down 
  li      a0,0x40             ; write 0x40 before jumping to down check
  lui     a0,0x41A0           ; we want to add 20
  mtc1    a0,f13
  lwc1    f14,0x54(s4)
  add.s   f13,f14,f13
  swc1    f13,0x54(s4)
  j       @@TargetRegRestore   ; to where it fixes floats/regs 
  nop
  
@@TargetVerticalDown:
  bne     a1,a0,@@TargetRegRestore + 0x8  ; if it doesnt equal down then ignore 
  lui     a0,0x41A0                       ; we want to sub 20
  mtc1    a0,f13
  lwc1    f14,0x54(s4)
  sub.s   f13,f14,f13
  swc1    f13,0x54(s4) 

@@TargetRegRestore: 
  mtc1    zero,f13            ; fix f13/14 
  mtc1    zero,f14            ;
  li      a1,0                ; fix registers to original state
  move    a0,s3               ;
  j       0x0888755C
  nop
