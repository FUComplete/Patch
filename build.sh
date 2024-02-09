#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
PYENV="$WORKDIR/env"
TOOLS="$WORKDIR/tools"
ISO="$WORKDIR/iso"
DATA_DIR="$WORKDIR/data"
BIN_DIR="$WORKDIR/binary"
BUILD_DIR="$WORKDIR/build"
DATAbin="$BUILD_DIR/ISO_ROOT/PSP_GAME/USRDIR/DATA.BIN"
MHFFd="$TOOLS/mhff/psp/data.py"
IN_FILES="$BUILD_DIR/data_in/"

# Build code
echo "Compiling ASM"
mkdir -p "$BUILD_DIR/data_in"
"$WORKDIR/armips" "$WORKDIR/main.asm" -stat -temp "$WORKDIR/log.txt"

# Update PARAM.SFO
echo "Updating PARAM.SFO"
sed 's/MONSTER HUNTER PORTABLE 2nd G/MONSTER HUNTER FREEDOM UNITE COMPLETE DEBUG/g' "$ISO/PARAM.SFO" > "$BUILD_DIR/ISO_ROOT/PSP_GAME/PARAM.SFO"
truncate --size=472 "$BUILD_DIR/ISO_ROOT/PSP_GAME/PARAM.SFO"

# Inject files into DATA.BIN, thanks Hario
echo "Injecting files into DATA.BIN"
cd $IN_FILES
for f in *
do
    echo "Replacing $f"
    python $MHFFd r "$DATAbin" "$f" "$f"
done
cd $WORKDIR

echo "DONE"