#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
PYENV="$WORKDIR/env"
TOOLS="$WORKDIR/tools"
ISO="$WORKDIR/iso"
DATA_DIR="$WORKDIR/data"
FU_DATA="$DATA_DIR/fu"
FUC_EN="$DATA_DIR/en"
PATCH="$WORKDIR/patches"
BIN_DIR="$WORKDIR/binary"
OVL_DIR="$WORKDIR/binary/overlay"
DECEBOOT="$TOOLS/deceboot"
# Grab some repos...
if [ ! -d "$TOOLS/mhff" ]; then
mkdir "$TOOLS"
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
# Build umd-replace
if [ ! -f "$TOOLS/umdreplace" ]; then
cd "$TOOLS"
7z e "$TOOLS/UMD-replace*.rar" UMD-replace.c
gcc UMD-replace.c -o umdreplace
cd "$WORKDIR"
fi
# Extract files from MHFU
cd "$ISO"
if [ ! -f "$FU_DATA/endroll.pmf" ]; then
source "$WORKDIR/env/bin/activate"
7z e "$ISO/FU.iso" PSP_GAME/USRDIR/DATA.BIN
7z e "$ISO/FU.iso" PSP_GAME/ICON0.PNG
7z e "$ISO/FU.iso" PSP_GAME/PIC0.PNG
python "$TOOLS/mhef/examples/psp/data.py" d 2G_NA "$ISO/DATA.BIN" "$ISO/FUDATA.BIN"
rm "$ISO/DATA.BIN"
mkdir -p $FU_DATA
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0012 "$FU_DATA/ICON0.PNG"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0014 "$FU_DATA/ICON0_MI.PNG"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0025 "$FU_DATA/demo.tmh"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0036 "$FU_DATA/gallery.tmh"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0046 "$FU_DATA/title_loop.pmf"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0047 "$FU_DATA/title_loop_g.pmf"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0048 "$FU_DATA/game_opening_man.pmf"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0049 "$FU_DATA/game_opening_woman.pmf"
python "$TOOLS/mhff/psp/data.py" x "$ISO/FUDATA.BIN" 0050 "$FU_DATA/endroll.pmf"
rm "$ISO/FUDATA.BIN"
# Resize ISO PNGs and PMFs to match P2G
dd if=/dev/random bs=1 count=1112 >> "$ISO/ICON0.PNG"
dd if=/dev/random bs=1 count=29910 >> "$ISO/PIC0.PNG"
dd if=/dev/random bs=1K count=7730 >> "$FU_DATA/title_loop.pmf"
dd if=/dev/random bs=1K count=416 >> "$FU_DATA/title_loop_g.pmf"
dd if=/dev/random bs=1K count=4 >> "$FU_DATA/game_opening_man.pmf"
dd if=/dev/random bs=1K count=8 >> "$FU_DATA/game_opening_woman.pmf"
dd if=/dev/random bs=1K count=472 >> "$FU_DATA/endroll.pmf"
fi
# Extract files from MHP2G
if [ ! -f "$ISO/P2GDATA.BIN" ]; then
source "$WORKDIR/env/bin/activate"
7z e "$ISO/P2G.iso" PSP_GAME/USRDIR/DATA.BIN
7z e "$ISO/P2G.iso" PSP_GAME/SYSDIR/EBOOT.BIN
7z e "$ISO/P2G.iso" PSP_GAME/PARAM.SFO
python "$TOOLS/mhef/examples/psp/data.py" d 2G_JP "$ISO/DATA.BIN" "$ISO/P2GDATA.BIN"
rm "$ISO/DATA.BIN"
fi
mkdir -p $OVL_DIR
if [ ! -f "$BIN_DIR/BOOT.BIN" ]; then
"$DECEBOOT/deceboot" "$ISO/EBOOT.BIN" "$BIN_DIR/BOOT.BIN"
fi
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0015 "$DATA_DIR/str_tbl.pac"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0017 "$DATA_DIR/demo.tmh"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0043 "$OVL_DIR/demo_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0044 "$OVL_DIR/edit_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0045 "$OVL_DIR/cont_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0046 "$OVL_DIR/option_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0049 "$OVL_DIR/install_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0050 "$OVL_DIR/lobby_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0053 "$OVL_DIR/arcade_task.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0056 "$OVL_DIR/game_sub.ovl"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 0059 "$DATA_DIR/guild.tmh"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 6594 "$DATA_DIR/SV_SHYUK.at3"
python "$TOOLS/mhff/psp/data.py" x "$ISO/P2GDATA.BIN" 6598 "$DATA_DIR/SN_LBY_0.at3"
# Truncate the files because mhff adds extra data at the end on single file extractions...
truncate --size=64512 "$OVL_DIR/arcade_task.ovl"
truncate --size=2816 "$OVL_DIR/cont_task.ovl"
truncate --size=6528 "$OVL_DIR/demo_task.ovl"
truncate --size=36352 "$OVL_DIR/edit_task.ovl"
truncate --size=926848 "$OVL_DIR/game_task.ovl"
truncate --size=12800 "$OVL_DIR/install_task.ovl"
truncate --size=722560 "$OVL_DIR/lobby_task.ovl"
truncate --size=6400 "$OVL_DIR/option_task.ovl"
cd "$WORKDIR"
# Patch P2G DATA.BIN with English patched files, then extract
if [ ! -f "$FUC_EN/quest_str.pac" ]; then
mkdir -p "$FUC_EN"
xdelta3 -d -s "$ISO/P2GDATA.BIN" "$PATCH/english.xdelta" "$ISO/ENPATCH.BIN"
sed 's/"//g' "$DATA_DIR/files_en.csv" | while IFS=, read ID FILE; do python "$TOOLS/mhff/psp/data.py" x "$ISO/ENPATCH.BIN" "$ID" "$FUC_EN/$FILE"; done
rm "$ISO/ENPATCH.BIN"
fi
# Download event quests from server
if [ ! -f "$DATA_DIR/quests/m60001.mib" ]; then
mkdir "$DATA_DIR/quests"
cd "$DATA_DIR/quests"
sed 's/"//g' "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do wget --user-agent="Capcom Portable Browser v1.3 for MH_Portable_2nd_G" --referer="http://viper.capcom.co.jp/psp/MHP2G/DL_MENU.PHP" "http://viper.capcom.co.jp/psp/MHP2G/QUEST/$QID"; done
# Decrypt them
source "$WORKDIR/env/bin/activate"
for f in *.mib; do python "$TOOLS/mhef/examples/psp/quest.py" d 2G_JP "$f" "$f.dec"; done
for f in *.dec; do mv "$f" "${f%.dec}"; done
fi
echo "DONE"