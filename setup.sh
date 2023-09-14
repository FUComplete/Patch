#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
PYENV="$WORKDIR/env"
TOOLS="$WORKDIR/tools"
ISO="$WORKDIR/iso"
DATA_DIR="$WORKDIR/data"
PATCH="$WORKDIR/patches"
BIN_DIR="$WORKDIR/binary"
OVL_DIR="$WORKDIR/binary/overlay"
DECEBOOT="$TOOLS/deceboot"

# ---------------------------------------
# Grab repos and build the tools...
# ---------------------------------------
if [ ! -d "$TOOLS/mhff" ]; then
mkdir -p "$TOOLS"
mkdir "$TOOLS/armips" && git clone --recurse-submodules https://github.com/Kingcom/armips.git "$TOOLS/armips"
mkdir "$TOOLS/mhef" && git clone https://github.com/IncognitoMan/mhef.git "$TOOLS/mhef"
mkdir "$TOOLS/mhff" && git clone https://github.com/IncognitoMan/mhff.git "$TOOLS/mhff"
fi
# Setup python venv
if [ ! -d "$PYENV" ]; then
python -m venv env/
source "$WORKDIR/env/bin/activate"
cd "$TOOLS/mhef"
python setup.py install
cd "$WORKDIR"
fi
# Build armips
if [ ! -f "$WORKDIR/armips" ]; then
cd "$TOOLS/armips"
mkdir build
cd "$TOOLS/armips/build"
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
cp armips "$WORKDIR"
cd "$WORKDIR"
fi
# Build deceboot
if [ ! -f "$TOOLS/deceboot/deceboot" ]; then
cd "$TOOLS"
7z x "$TOOLS/deceboot*.zip" src
mv "$TOOLS/src" "$TOOLS/deceboot"
cd "$TOOLS/deceboot"
sed -i 's/main.cpp/main.cpp -fpermissive/' Makefile
make
cd "$WORKDIR"
fi

# ---------------------------------------
# Extract clean files from MHP2G
# ---------------------------------------
if [ ! -f "$ISO/PARAM.SFO" ]; then
source "$WORKDIR/env/bin/activate"
7z e "$ISO/P2G.iso" -o"$ISO/" PSP_GAME/USRDIR/DATA.BIN
7z e "$ISO/P2G.iso" -o"$ISO/" PSP_GAME/SYSDIR/EBOOT.BIN
7z e "$ISO/P2G.iso" -o"$ISO/" PSP_GAME/PARAM.SFO
python "$TOOLS/mhef/examples/psp/data.py" d 2G_JP "$ISO/DATA.BIN" "$ISO/P2GDATA.BIN"
rm "$ISO/DATA.BIN"
fi
mkdir -p $OVL_DIR
if [ ! -f "$BIN_DIR/EBOOT.BIN" ]; then
"$DECEBOOT/deceboot" "$ISO/EBOOT.BIN" "$BIN_DIR/EBOOT.BIN"
rm "$ISO/EBOOT.BIN"
fi
if [ ! -f "$OVL_DIR/demo_task.ovl" ]; then
mkdir -p "$ISO/clean_droot"
python "$TOOLS/mhff/psp/data.py" a "$ISO/P2GDATA.BIN" "$ISO/clean_droot"
rm "$ISO/P2GDATA.BIN"
cd "$ISO/clean_droot"
sed 's/"//g' "$DATA_DIR/index.csv" | while IFS=, read id file; do mkdir -p $(dirname "$file") && mv "$id" "$file"; done
cp -R "$ISO/clean_droot/overlay/"* "$BIN_DIR/overlay"
fi
cd "$WORKDIR"

# ---------------------------------------
# Extract files from FUComplete
# ---------------------------------------
if [ ! -f "$WORKDIR/build/ISO_ROOT/UMD_DATA.BIN" ]; then
source "$WORKDIR/env/bin/activate"
mkdir -p "$WORKDIR/build/ISO_ROOT"
7z x "$ISO/FUC.iso" -o"$WORKDIR/build/ISO_ROOT"
fi
if [ ! -f "$ISO/patch_droot/system/resides.tmh" ]; then
mkdir -p "$ISO/patch_droot"
python "$TOOLS/mhff/psp/data.py" a "$WORKDIR/build/ISO_ROOT/PSP_GAME/USRDIR/DATA.BIN" "$ISO/patch_droot"
cd "$ISO/patch_droot"
sed 's/"//g' "$DATA_DIR/index.csv" | while IFS=, read id file; do mkdir -p $(dirname "$file") && mv "$id" "$file"; done
fi

echo "DONE"