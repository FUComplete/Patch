@@MainMenuList:
    .org 0x09A5B8E4
        .dh 3     ; Up arrow limit
    .org 0x09A5B948
        .dh 4     ; Down arrow limit
    .org 0x09A5BBE0
        .dh 88    ; Menu listing Y pos
    .org 0x09A5BCCC
        .dh 4     ; Menu entry limit
    .org 0x09A5BCD8
        .dh 40    ; Text leading