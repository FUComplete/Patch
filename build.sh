#!/bin/bash
WORKDIR="$( cd "$( dirname "$0" )" && pwd )"
PYENV="$WORKDIR/env"
TOOLS="$WORKDIR/tools"
ISO="$WORKDIR/iso"
DATA_DIR="$WORKDIR/data"
DLC="$WORKDIR/data/quests"
FU_DATA="$DATA_DIR/fu"
FUC_EN="$DATA_DIR/en"
BIN_DIR="$WORKDIR/binary"
OVL_DIR="$WORKDIR/binary/overlay"
PATCHES="$WORKDIR/patches"
BUILD_DIR="$WORKDIR/build"
# If build directory exists, remove it.
rm -rf "$BUILD_DIR"
# Create build directory 
mkdir -p "$BUILD_DIR/overlay"
# Build EventQstTable
cp "$DATA_DIR/event_tbl.bin" "$BUILD_DIR"
sed -n -e 1,38p "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do dd conv=notrunc bs=1 if="$DLC/$QID" of="$BUILD_DIR/event_tbl.bin" seek=$BLOCK; done
# Build ArenaQstTable
cp "$DATA_DIR/challenge_tbl.bin" "$BUILD_DIR"
sed -n -e 39,52p "$DATA_DIR/qid.lst" | while IFS=, read QID BLOCK; do dd conv=notrunc bs=1 if="$DLC/$QID" of="$BUILD_DIR/challenge_tbl.bin" seek=$BLOCK; done

if [ $1 = "en" ]; then
echo "EN Patching"
# Patch challenge/event to EN and add to the end
xdelta3 -ds "$BUILD_DIR/event_tbl.bin" "$PATCHES/event_en.xdelta" "$BUILD_DIR/event_tbl_en.bin"
xdelta3 -ds "$BUILD_DIR/challenge_tbl.bin" "$PATCHES/challenge_en.xdelta" "$BUILD_DIR/challenge_tbl_en.bin"
rm "$BUILD_DIR/event_tbl.bin"
rm "$BUILD_DIR/challenge_tbl.bin"
mkdir "$BUILD_DIR/audio"
cp "$DATA_DIR/SN_LBY_0.at3" "$BUILD_DIR/audio"
cp "$DATA_DIR/SV_SHYUK.at3" "$BUILD_DIR/audio"
dd conv=notrunc bs=1 if="$BUILD_DIR/challenge_tbl_en.bin" of="$BUILD_DIR/audio/SN_LBY_0.at3" seek=221328
dd conv=notrunc bs=1 if="$BUILD_DIR/event_tbl_en.bin" of="$BUILD_DIR/audio/SV_SHYUK.at3" seek=1392144
# Apply code changes
"$WORKDIR/armips" "$WORKDIR/main.asm"
# Copy english translated files
mkdir -p "$BUILD_DIR/quests" && find data/en -type f \( -iname \*.mib \) | xargs cp -t "$BUILD_DIR/quests"
mkdir -p "$BUILD_DIR/text" && find data/en -type f \( -iname \*.pac -o -iname \*.bin \) | xargs cp -t "$BUILD_DIR/text"
mkdir -p "$BUILD_DIR/pmf" && find data/fu -type f \( -iname \*.pmf \) | xargs cp -t "$BUILD_DIR/pmf"
mkdir -p "$BUILD_DIR/gfx" && find data/fu -type f \( -iname \*.PNG -o -iname \*.tmh \) | xargs cp -t "$BUILD_DIR/gfx"
# Apply credits/nekofix 
xdelta3 -dfs "$FU_DATA/demo.tmh" "$PATCHES/credits_en.xdelta" "$BUILD_DIR/gfx/demo.tmh"
xdelta3 -dfs "$DATA_DIR/guild.tmh" "$PATCHES/nekofix.xdelta" "$BUILD_DIR/gfx/guild.tmh"
# Modify the PARAM.SFO and copy ISO related files
sed 's/MONSTER HUNTER PORTABLE 2nd G/MONSTER HUNTER FREEDOM UNITE COMPLETE DEV/g' "$ISO/PARAM.SFO" > "$BUILD_DIR/PARAM.SFO"
truncate --size=472 "$BUILD_DIR/PARAM.SFO"
cp "$ISO/ICON0.PNG" "$BUILD_DIR"
cp "$ISO/PIC0.PNG" "$BUILD_DIR"
cp "$ISO/P2GDATA.BIN" "$BUILD_DIR/DATA.BIN"
cp "$ISO/P2G.iso" "$BUILD_DIR/FUC_EN.ISO"
fi

if [ $1 = "jp" ]; then
echo "JP Patching"
# Modify the PARAM.SFO
sed 's/MONSTER HUNTER PORTABLE 2nd G/MONSTER HUNTER PORTABLE 2nd G COMPLETE DEV/g' "$ISO/PARAM.SFO" > "$BUILD_DIR/PARAM.SFO"
truncate --size=472 "$BUILD_DIR/PARAM.SFO"
# Inject both Arena/Event tables
mkdir "$BUILD_DIR/audio"
cp "$DATA_DIR/SN_LBY_0.at3" "$BUILD_DIR/audio"
cp "$DATA_DIR/SV_SHYUK.at3" "$BUILD_DIR/audio"
dd conv=notrunc bs=1 if="$BUILD_DIR/challenge_tbl.bin" of="$BUILD_DIR/audio/SN_LBY_0.at3" seek=221328
dd conv=notrunc bs=1 if="$BUILD_DIR/event_tbl.bin" of="$BUILD_DIR/audio/SV_SHYUK.at3" seek=1392144
# Apply code changes
"$WORKDIR/armips" "$WORKDIR/main.asm" -definelabel jp 0
# Create directories
mkdir -p "$BUILD_DIR/text"
mkdir -p "$BUILD_DIR/gfx"
# Trim str_tbl.pac
xdelta3 -dfs "$DATA_DIR/str_tbl.pac" "$PATCHES/str_tbl_trim.xdelta" "$BUILD_DIR/text/str_tbl.pac"
# Apply credits/nekofix 
xdelta3 -dfs "$DATA_DIR/demo.tmh" "$PATCHES/credits.xdelta" "$BUILD_DIR/gfx/demo.tmh"
xdelta3 -dfs "$DATA_DIR/guild.tmh" "$PATCHES/nekofix.xdelta" "$BUILD_DIR/gfx/guild.tmh"
cp "$ISO/P2GDATA.BIN" "$BUILD_DIR/DATA.BIN"
cp "$ISO/P2G.iso" "$BUILD_DIR/FUC_JP.ISO"
fi

# Inject files into DATA.BIN, thanks Hario
DATAbin="$BUILD_DIR/DATA.BIN"
MHFFd="$TOOLS/mhff/psp/data.py"
IN_OVERLAY=(./build/overlay/*)
IN_QUESTS=(./build/quests/*)
IN_AUDIO=(./build/audio/*)
IN_TEXT=(./build/text/*)
IN_PMF=(./build/pmf/*)
IN_GFX=(./build/gfx/*)

echo "${#IN_OVERLAY[*]} overlay files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_OVERLAY[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done

echo "${#IN_AUDIO[*]} audio files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_AUDIO[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done

echo "${#IN_TEXT[*]} text files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_TEXT[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done

if [ $1 = "en" ]; then
echo "${#IN_PMF[*]} pmf files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_PMF[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done
fi

echo "${#IN_GFX[*]} gfx files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_GFX[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done

if [ $1 = "en" ]; then
echo "${#IN_QUESTS[*]} quest files found."
while IFS=',' read -ra array; do
    id_arr+=("${array[0]}")
    path_arr+=("${array[1]}")
done < "$DATA_DIR/index.csv"
csize=${#id_arr[@]}
search_csv () {
    for ((i=0; i<$csize; i++))
    do
        bname=$(basename ${path_arr[${i}]})
        if [ $1 == $bname ]
        then
            fid=${id_arr[${i}]}
            break
        fi
    done
}
for f in "${IN_QUESTS[@]}"
do
    iname=$(basename $f)
    search_csv $iname
    if [ ! $fid == "" ]
    then
        echo "replacing $f"
        python $MHFFd r "$DATAbin" $fid "$f"
    else
        echo "$f not found."
    fi
done
fi

# Replace files in ISO
if [ $1 = "en" ]; then
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_EN.ISO" /PSP_GAME/SYSDIR/EBOOT.BIN "$BUILD_DIR/BOOT.BIN"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_EN.ISO" /PSP_GAME/ICON0.PNG "$BUILD_DIR/ICON0.PNG"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_EN.ISO" /PSP_GAME/PIC0.PNG "$BUILD_DIR/PIC0.PNG"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_EN.ISO" /PSP_GAME/PARAM.SFO "$BUILD_DIR/PARAM.SFO"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_EN.ISO" /PSP_GAME/USRDIR/DATA.BIN "$BUILD_DIR/DATA.BIN"
fi
if [ $1 = "jp" ]; then
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_JP.ISO" /PSP_GAME/SYSDIR/EBOOT.BIN "$BUILD_DIR/BOOT.BIN"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_JP.ISO" /PSP_GAME/PARAM.SFO "$BUILD_DIR/PARAM.SFO"
"$TOOLS/umdreplace" "$BUILD_DIR/FUC_JP.ISO" /PSP_GAME/USRDIR/DATA.BIN "$BUILD_DIR/DATA.BIN"
fi