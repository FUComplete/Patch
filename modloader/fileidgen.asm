; Code checks file index read value and generates a file ID, this
; is then written to the file path for nativePSP.
;
; a0 - FileID
; a1 - Number place (1000,100,10,1)
; 
CheckFileID:
    addiu   sp,sp,-0x20
    sw      a2,0x1C(sp)
    sw      a1,0x18(sp)
    sw      a0,0x14(sp)
    sw      v1,0x10(sp)
    sw      v0,0xC(sp)
    ; Calculate fileID and write to DataBlock 0x0
    vla     v0,MLDataBlock
    subu    a0,v1,s3
    srl     a0,a0,0x2
    sh      a0,0x0(v0)

AppendID1000s:
    ; Append the decimal value of fileID to MLnativePSP
    vla     v0,MLnativePSP + 35
    li      v1,0x30
    sb      v1,0x0(v0)
    li      a1,0x3E8    ; 1000
    div     a0,a1
    nop
    nop
    mflo    a2
    beq     a2,zero,AppendID100s 
    mfhi    a0
    add     a2,v1,a2
    sb      a2,0x0(v0)
    
AppendID100s:
    sb      v1,0x1(v0)
    li      a1,0x64     ; 100
    div     a0,a1
    nop
    nop
    mflo    a2
    beq     a2,zero,AppendID10s 
    mfhi    a0
    add     a2,v1,a2
    sb      a2,0x1(v0)

AppendID10s:
    sb      v1,0x2(v0)
    li      a1,0xA     ; 10
    div     a0,a1
    nop
    nop
    mflo    a2
    beq     a2,zero,AppendID1s 
    mfhi    a0
    add     a2,v1,a2
    sb      a2,0x2(v0)

AppendID1s:
    add     a0,v1,a0
    sb      a0,0x3(v0)
    ; Write back and exec original registers/instructions and return
    lw      a2,0x1C(sp)
    lw      a1,0x18(sp)
    lw      a0,0x14(sp)
    lw      v1,0x10(sp)
    lw      v0,0xC(sp)
    lw      v1,0x2AC0(v1)
    lw      v0,-0x6DC0(v0)
    j       0x0884E160
    addiu   sp,sp,0x20
