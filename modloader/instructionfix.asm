; Patch temp -> mem function to check and patch 
@@Modloader:
    vla     v0,0x0884E6F0
    la      a0,FileLoader
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x18(v0)

; Patches index read to check position and generate ID in ValStore 0x0
@@FileIDGen:
    vla     v0,0x0884E158
    la      a0,CheckFileID
    srl     a0,a0,0x2
    lui     a1,0x0800
    addu    a0,a1,a0
    sw      a0,0x0(v0)
    sw      zero,0x4(v0)

