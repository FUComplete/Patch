@@TrainHallRoomSelect:
    .org 0x09A67F94
        .dh     77      ; BG X pos
    .org 0x09A67F98
        .dh     6       ; BG Y pos
    .org 0x09A67F9C
        .dh     326     ; BG width
    .org 0x09A67FA0
        .dh     260     ; BG height
    .org 0x09A69D08
        .dh     170     ; Title X pos
        .dh     20      ; Title Y pos
    .org 0x09A69D0C
        .dh     107     ; Room left column X pos
    .org 0x09A69D14
        .dh     254     ; Room right column X pos
    .org 0x09A69D0E
        .dh     56      ; Room column Y pos
    .org 0x09A69D12
        .dh     91      ; Cursor left column X pos
    .org 0x09A69D16
        .dh     238     ; Cursor right column X pos

@@TrainHallRoomSettings:
    .org 0x09A654D0
        .dh     412     ; Amount of players X pos 
    .org 0x09A65594
        .dh     406     ; Password set prompt X pos

@@ChallengeQuestBlock:
    .org 0x09A5EF54
        .dh     14      ; amount to show
    .org 0x09A5EF5C
        .dh     8880    ;
    .org 0x09A5F3A8     ; these deal with block size
        .dh     8864    ; and quest ID positions...
    .org 0x09A69508     ; 
        .dh     8880    ;
    ; Initial and offset read positions...
    .org 0x09A5EEF8
        .dh     0       ; Start read position
    .org 0x09A5EF14
        .dh     32      ; Offset read position
    .org 0x09A69500
        .dh     0       ; Start read position
    .org 0x09A69510
        .dh     32      ; Offset read position
