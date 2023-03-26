; Checks certain configuration options and applies on boot patches...
@@TrueRawBloatCheck:
    vla     v0,0x08938104
    vla     v1,configAddr
    lb      a0,0x6(v1)
    beq     a0,zero,@@DosAudioCheck
    li      a0,0x64
    li      a1,0xA
    li      a2,0x0
    sw      a0,0x0(v0)
    addiu   v0,0x4
    bne     a1,a2,. - 0x8
    addiu   a2,0x1     

@@DosAudioCheck:
    vla     v0,0x08956800
    lb      a0,0x7(v1)
    beq     a0,zero,@@MinimapScaleSet
    lb      a0,0x333(v0)
    lb      a1,0x334(v0)
    lb      a2,0x335(v0)
    ori     a0,a0,0xF
    ori     a1,a1,0x40
    ori     a2,a2,0x8
    sb      a0,0x333(v0)
    sb      a1,0x334(v0)
    sb      a2,0x335(v0)

@@MinimapScaleSet:
    vla     v0,0x08842ED4
    lb      a0,0xB(v1)
    beq     a0,zero,@@FoVSet
    li      a1,0x1
    bne     a0,a1,. + 0x44
    li      a1,0x3F40   ; 75% Map Scale
    sh      a1,0x0(v0)
    sh      a1,0x4(v0)
    li      a1,0x165    ; X pos
    li      a2,0x22     ; Y pos
    sh      a1,0xC(v0)
    sh      a2,0x10(v0)
    sh      a1,0x30(v0)
    sh      a2,0x38(v0)
    li      a1,0x425C   ; 75% Ping Scale
    sh      a1,0x142C(v0)
    li      a1,0x1A4    ; X pos
    li      a2,0x5E     ; Y pos
    sh      a1,0x1440(v0)
    sh      a2,0x1444(v0)
    b       @@MinimapScaleCampIcon
    li      a1,0x3F00   ; 50% Map Scale
    sh      a1,0x0(v0)
    sh      a1,0x4(v0)
    li      a1,0x188    ; X pos
    li      a2,0x22     ; Y pos
    sh      a1,0xC(v0)
    sh      a2,0x10(v0)
    sh      a1,0x30(v0)
    sh      a2,0x38(v0)
    li      a1,0x420C   ; 50% Ping Scale
    sh      a1,0x142C(v0)
    li      a1,0x1B2    ; X pos
    li      a2,0x4A     ; Y pos
    sh      a1,0x1440(v0)
    sh      a2,0x1444(v0)
@@MinimapScaleCampIcon:
    vla     v0,0x08936DE0
    li      a1,0x90
    li      a2,0xE6
    sh      a1,0x0(v0)
    sh      a2,0x2(v0)
@@MinimapLoadingScreenScale:
    vla     v0,0x088BC38C
    li      a1,0x3F80   ; 100% Scale
    sh      a1,0x0(v0)
    vla     v0,0x089AFBF4
    li      a1,0xA4     ; X pos
    li      a2,0x28     ; Y pos
    sh      a1,0x0(v0)
    sh      a2,0x2(v0)

@@FoVSet:
    vla     v0,0x08886DA4
    lh      a0,0x8(v1)
    sh      a0,0x0(v0)

@@SetFUIcon:
    vla     v0,0x088C02E4
    lb      a0,0x5(v1)
    beq     a0,zero,@@VertCamSet
    li      a1,0xE
    sb      a1,0x0(v0)
    sb      a1,0x3ABC(v0)

@@VertCamSet:
    vla     v0,0x088138BC
    lb      a0,0xA(v1)
    sb      a0,0x0(v0)
