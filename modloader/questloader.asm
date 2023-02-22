ChallengeQuests:
    ; Small code to redirect challenge quests read pointers...
    la      a0,0x08BA4920
    j       0x09A5EF24
    nop
    la      v0,0x08BA4920
    j       0x09A6951C
    nop

; -----------------------------------------------------------------

EventQuestsRead:
    la      t3,0x09A0077E
    lb      t4,0x0(t3)
    bne     t4,zero,@@SavedataQRead
    li      t4,0xE
    slti    v0,s3,0x26      ; Limit to 38 internal
    b       @@RestoreRegQRead
    nop

@@SavedataQRead:
    slti    v0,s3,0x12      ; Limit to 18 external (savedata)

@@RestoreRegQRead:
    li      t3,0x1
    j       0x09A822F0
    nop

; -----------------------------------------------------------------

EventQuestsCap:
    la      t3,0x09A0077E
    lb      t4,0x0(t3)
    bne     t4,zero,@@SavedataQCap
    li      t4,0xE
    slti    v0,s1,0x26      ; Limit to 38 internal
    b       @@RestoreRegQCap
    nop

@@SavedataQCap:
    slti    v0,s1,0x12      ; Limit to 18 external (savedata)

@@RestoreRegQCap:
    li      t3,0x1
    j       0x09A835B8
    nop

; -----------------------------------------------------------------

QuestReallocCheck:
    la      t3,0x09A0077E
    lb      t4,0x0(t3)
    bne     t4,zero,@@QuestLoadExternal
    li      t4,0xE

@@QuestLoadInternal:
    lui     v0,0x8CD
    li      at,0x3EC0
    b       @@RestoreRegQLoad
    nop

@@QuestLoadExternal:
    bnel    v0,zero,. + 0x10
    lw      v0,0x94C(v1)
    b       @@RestoreRegQLoad + 0x10
    li      v0,0x0
    lui     at,0x14
    ori     at,at,0x2300


@@RestoreRegQLoad:
    li      t3,0x1
    j       0x09A83510
    nop
    ; might not need this...
    li      t3,0x1
    jr      ra  
    nop