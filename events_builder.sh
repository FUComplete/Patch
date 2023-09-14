#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
PYENV="$WORKDIR/env"
TOOLS="$WORKDIR/tools"
ISO="$WORKDIR/iso"
DATA_DIR="$WORKDIR/data"
DLC="$WORKDIR/data/quests"
BUILD_DIR="$WORKDIR/build"
# ---------------------------------------
# Download event quests from server
# ---------------------------------------
if [ ! -f "$DATA_DIR/quests/m60001.mib" ]; then
mkdir "$DATA_DIR/quests"
cd "$DATA_DIR/quests"
sed 's/"//g' "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do wget --user-agent="Capcom Portable Browser v1.3 for MH_Portable_2nd_G" --referer="http://viper.capcom.co.jp/psp/MHP2G/DL_MENU.PHP" "http://viper.capcom.co.jp/psp/MHP2G/QUEST/$QID"; done
# Decrypt them
source "$PYENV/bin/activate"
for f in *.mib; do python "$TOOLS/mhef/examples/psp/quest.py" d 2G_JP "$f" "$f.dec"; done
for f in *.dec; do mv "$f" "${f%.dec}"; done
fi
# Build EventQstTable
cp "$DATA_DIR/event_tbl.bin" "$BUILD_DIR"
sed -n -e 1,38p "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do dd conv=notrunc bs=1 if="$DLC/$QID" of="$BUILD_DIR/event_tbl.bin" seek=$BLOCK; done
# Build ArenaQstTable
cp "$DATA_DIR/challenge_tbl.bin" "$BUILD_DIR"
sed -n -e 39,52p "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do dd conv=notrunc bs=1 if="$DLC/$QID" of="$BUILD_DIR/challenge_tbl.bin" seek=$BLOCK; done
# Patch challenge/event to EN and add to the end
echo "EN Patching Events"
xdelta3 -ds "$BUILD_DIR/event_tbl.bin" "$DATA_DIR/event_en.xdelta" "$BUILD_DIR/event_tbl_en.bin"
xdelta3 -ds "$BUILD_DIR/challenge_tbl.bin" "$DATA_DIR/challenge_en.xdelta" "$BUILD_DIR/challenge_tbl_en.bin"
rm "$BUILD_DIR/event_tbl.bin"
rm "$BUILD_DIR/challenge_tbl.bin"
mkdir -p "$BUILD_DIR/audio"
cp "$ISO/clean_droot/sound/stream/others/SN_LBY_0.at3" "$BUILD_DIR/6598"
cp "$ISO/clean_droot/sound/stream/others/SV_SHYUK.at3" "$BUILD_DIR/6594"
dd conv=notrunc bs=1 if="$BUILD_DIR/challenge_tbl_en.bin" of="$BUILD_DIR/6598" seek=221328
dd conv=notrunc bs=1 if="$BUILD_DIR/event_tbl_en.bin" of="$BUILD_DIR/6594" seek=1392144
rm "$BUILD_DIR/event_tbl_en.bin"
rm "$BUILD_DIR/challenge_tbl_en.bin"
echo "DONE"