#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
DATA_DIR="$WORKDIR/data"
BUILD_DIR="$WORKDIR/build"
mkisofs -iso-level 4 -xa -graft-points -path-list "$DATA_DIR/path_list" -sort "$DATA_DIR/sort_file" -A "PSP GAME" -V "MHFUC" -sysid "PSP GAME" -volset "MHFUC" -publisher "CAPCOM CO.,LTD." -p "CAPCOM CO.,LTD." -o "$BUILD_DIR/FUC_Debug.ISO"