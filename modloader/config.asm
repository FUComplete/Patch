    .db     0x0     ; file replacer flag (0x0:disc0, 0x1:ms0)
    .db     0x1     ; save region (0x0:JP, 0x1:US, 0x2:EU)
    .db     0x0     ; true raw flag
    .db     0x0     ; dos audio
    .dh     0x3F5F  ; FoV value
    .db     0x3     ; vertical snap start position
    .db     0x0     ; minimap scale
    .db     0x0     ; HH rework toggle
    .db     0x0     ; Early Lao kill toggle
    .db     0x0     ; unused
    .db     0x0     ; unused
    .ascii  "DEBUG "  ; Version (add a space at the end, limit 8 characters)
    .align  0x10