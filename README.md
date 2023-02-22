<div align="center">
<h1>FUComplete</h1>
</div>

FUComplete is a modification of the game MHP2G (Portable 2nd G). It supports both official PSP hardware and emulation.

It's able to natively load savedata from MHF2 and MHFU (Freedom 2 and Freedom Unite) without any save conversion. It can also translate the game's language from Japanese into English using MHFU's localization data, which allows users who do not understand Japanese to enjoy the previously JP-exclusive features, such as:

* "Standard" control layout (X/O are swapped, meaning O = Accept / X = Cancel)
* Uncensored, original blood effects (In MHF2/MHFU, the blood effects were scaled down)
* Original Japanese version of the [Snowy Mountains battle theme](https://youtu.be/_8b8huJne1I)
* 10 Japanese-exclusive downloadable quests (English translations with FUComplete)
* Japanese-exclusive poogie costume

FUComplete also brings many QoL improvements, including:

* All DLC (Event Quests, Challenge Quests, Bonus Material) is embedded into the game at the same time
* Cross-play compatibility with vanilla/unmodded versions of MHP2G/MHFU
* Equipment preview is auto-enabled, so no more Data Install!
* Several bonus cheats (some of which are only compatible with emulators, see below for more information)

There is also an optional patch called `DosAudio`, which swaps several battle themes with ones featured in MH2Dos (Monster Hunter 2 Dos) - more information below.

# Applying the Patch

Download the [latest patch](https://github.com/FUComplete/Patch/releases/latest).

Make sure you use either a UMD dump or PSN version of Portable 2nd G. The hashes should be one of the following:

```
UMD - MD5: 1f76ee9ccbd6d39158f06e6e5354a5bd
PSN - MD5: cc39d070b2d2c44c9ac8187e00b75dc4
```

Drag and drop your ISO of P2G onto the `FUComplete` app. It'll start the patching process.

You'll be asked which langauge you want the patch in, `EN` (English) or `JP` (Japanese). 

If you choose `EN` you'll additionally be asked which region savedata to load, either `US` (ULUS10391) or `EU` (ULES01213). 

After that it will ask if you would like to install optional patches, answer Y or N if you want to apply them or not.

# Building

Dependencies *(Ubuntu/Debian)*:
* build-essential
* python3
* python-is-python3
* python3-venv
* xdelta3
* p7zip-full
* [UMD-Replace](https://www.romhacking.net/utilities/891/)
* [DecEboot](https://www.romhacking.net/utilities/1225/)

Dump your copies of Freedom Unite and Portable 2nd G, rename them to `FU.iso` and `P2G.iso` respectively and place them in a folder called `iso`.

Place the UMD-Replace and DecEboot archives in a folder called `tools` ***(Do not extract them, just place them in the directory as is)***.

Run `./setup.sh` and wait for it to finish... once finished then run either `./build.sh en` or `./build.sh jp` depending on which language you are building for.

The patched image will be located in `build/FUC_(EN/JP).iso`.


# Optional Cheat Codes

You will find these codes in the `ULJM05500.ini` included in the release and updates to them [here](https://github.com/FUComplete/Patch/wiki/Enhancements-and-BonusDLC). To use these either merge the file into your existing cheats file or place it in `memstick/PSP/Cheats` if on PPSSPP and enable cheats.

### Guildhall QoL

This code ONLY works on an emulator, as it's unstable on real hardware. What this code does is give you some "Quality of Life" improvements to the Guildhall. It has the following changes:

- Full chest access. This is the same chest that's in your home except now you have full access to it in the Guildhall. (**OFFLINE ONLY**)
- The NPC by the questboard in the Guildhall now allows you to create/improve your equipment. (**OFFLINE ONLY**)
- The felyne between the table and Treshi in the Guildhall now has a custom peddler shop menu. This menu is separate from the Peddling Granny outside the hall, and doesn't share her random discount sales or rotating items. This means that if you want item cycling or random discount sales, the original Peddling Granny is required. It is the combination of all peddler tables into one static table. (**ONLINE/OFFLINE**)

The reason why the new smithy/full chest codes are offline only is due to a limitation of the game, which can lead to crashing or unintended results.

### HUD off above 40 HP

A port of the Portable 3rd code that turns off your HUD when HP is above 40. HUD will reappear when below 40 or when pressing the L trigger.

### Minimap Scaled 75%/50%

Changes the "scale" of the minimap to either 75% or 50% of its original size. Only have either the 75% OR 50% enabled, not both. Also have them enabled before playing to prevent issues.

### True Raw/Ele/Status

"Debloats" the Raw, Element and Status values of all weapons. Similar feature like in Portable 3rd where you had the true value listed.

# FAQ

### Why use P2G as a base and not FU? 

Due to issues with finding translators for the various langauges and having memory limit issues, it was decided to move to P2G as I didn't have to worry about more than one language and I had significantly more memory to play with.

### When I try to patch the game it says "Invalid ISO"?

Please use a clean dump of P2G, either from your UMD or PSN. Your ISO should match one of the following hashes: 
```
UMD - MD5: 1f76ee9ccbd6d39158f06e6e5354a5bd
PSN - MD5: cc39d070b2d2c44c9ac8187e00b75dc4
```

### What does the `DosAudio` patch change?

The patch changes the following battle themes:
* [Jungle](https://youtu.be/wP1Tiq74gWs)
* [Desert](https://youtu.be/Hjf1QfiTBbY)
* [Swamp](https://youtu.be/ZRQT-QYB0_I)
* [Snowy Mountain](https://youtu.be/7T0Vp7okMhE)
* [Volcano](https://youtu.be/vHSCNxTjX1c)
* [Tower](https://youtu.be/f5ZNBm9EuEc)

### Is there info on what the challenge/fiesta quests are? Can't see what the quest details are from the selection screen.

The `CQUESTS.TXT` file contains info on each challenge/fiesta quest, so refer to that if you would like to know the specifics about them.

### I used the Guildhall QoL code and I can't access smithy/full chest in hall?

With the way the game works with Adhoc play, If a player changes equipment in the Guildhall there's a very high chance of a crash... Even if the player manages to get to the point of embarking on a quest, when it validates what gear the player had it will visually show you having switched... But will still have the gear you had on when you initially joined the Guildhall. For this reason, smithy/full chest are blocked from online play and are OFFLINE ONLY.

# Credits and Thanks

**Hario** for helping with the programming side of things.

**Rozalin** and **ShadyFigure** for translations.

**Codestation** for [mhtools](https://github.com/codestation/mhtools).

**Svanheulen** for [mhff](https://github.com/svanheulen/mhff) and [mhef](https://github.com/svanheulen/mhef).

**AsteriskAmpersand** for [PMO-Importer](https://github.com/AsteriskAmpersand/PMO-Importer).

**Yuzucchi** for insight on some code.

**Capcom** for creating P2G/FU.
