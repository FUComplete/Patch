@@F2ImportPrompts:
; Prompts handling details about what is or isn't imported from your F2 save.
    .org 0x09A5B208
        .dh 26  ; Last page X pos
    .org 0x09A5B228
        .dh 198 ; Yes/No prompt X pos
    .org 0x09A5B240
        .dh 26  ; Pages 1 and 2 X pos

@@SaveConfirmPrompts:
    .org 0x09A60F60
        .dh 198 ; "Being game without saving" Yes/No X pos
    .org 0x09A6310A
        .dh 198 ; "Do you want to use this character"/"Are you a beginner" Yes/No X pos
    .org 0x09A612EC
        .dh 220 ; "Welcome to the world of Monster Hunter" text Y pos

@@SaveCreateSelectionMenu:
    .org 0x09A5A99C
        .dh 148 ; "Import a Monster Hunter Freedom 2 Charater" text Y pos
    .org 0x09A5A9AC
        .dh 208 ; "Import a Monster Hunter Freedom Unite Character" text Y pos
