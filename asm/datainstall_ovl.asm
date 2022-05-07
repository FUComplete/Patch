// Change data install directory
.ifdef jp
  .org DataInstallDir
    .ascii "ULJM05500MOD"
.else
  .org DataInstallDir
    .ascii "ULUS10391MOD"
  // EUR GameID
  // .org DataInstallDir
  //   .ascii "ULES01213MOD"
  // small changes to fix some yes/no
  // prompts and path
  .org DataInstallCfrm1X
    .dh 198
  .org DataInstallCfrm2X
    .dh 198
.endif
