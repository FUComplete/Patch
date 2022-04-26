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

# Patching

Download the [latest patch](https://github.com/FUComplete/Patch/releases/latest).

Make sure you use either a UMD dump or PSN version of Portable 2nd G. The hashes should be one of the following:

```
UMD - MD5: 1f76ee9ccbd6d39158f06e6e5354a5bd
PSN - MD5: cc39d070b2d2c44c9ac8187e00b75dc4
```

Drag and drop your ISO of P2G onto the `FUComplete` app. It'll start the patching process.

You'll be asked which langauge you want the patch in, `EN` (English) or `JP` (Japanese).</br>After that it will ask if you would like to install optional patches, answer Y or N if you want to apply them or not.

After that is done the next steps depend on if you selected English or Japanese.

If you want all the Challenge/Fiesta quests:

1. Go to your savedata folder and find your save.
    - If English - `ULUS10391`
    - If Japanese - `ULJM05500`
    - If you see `ULES01213` rename the folder to `ULUS10391`.
    - If you do not see either of these, please make a character to generate a save.
2. Copy the `MHP2NDG.BIN` and place it in the same folder with `QInject`.
3. Drag and drop the `MHP2NDG.BIN` onto `QInject`, select 1 for `EN` or 2 for `JP`
4. Once done copy your new `MHP2NDG.BIN` into the save folder overwriting the old one.

If you want to restore your previously stored DLC, repeat the steps, only this time choose "Restore" option.

# Building

You will need [armips](https://github.com/Kingcom/armips) to build the project... you will also need to extract the files from DATA.BIN using [mhff](https://github.com/IncognitoMan/mhff) and [this organization script](https://gist.github.com/IncognitoMan/5606104bd3f4ab79c0e4e2f791acbda5).

Create a directory named `binary` and copy `BOOT.BIN` and the `overlay` folder from DATA.BIN extraction to it. also copy `str_tbl.pac` from `message_jpn` to `data` directory.

Create `build/overlay` directory.

Run `armips main.asm` to build.

*If you would like to build for `JP` language, run `armips main.asm -definelabel jp 0`.*

# Codes

You will find these codes in the `ULJM05500.ini` included in the release and updates to them [here](https://github.com/FUComplete/Patch/wiki/Enhancements-and-BonusDLC). To use these either merge the file into your existing cheats file or place it in `memstick/PSP/Cheats` if on PPSSPP and enable cheats.

### Guildhall QoL

This code ONLY works on emulator, its unstable on real hardware. What this code does if give you some "Quality of Life" improvements to Guildhall. It has the following changes:

- Full chest access. This is the same chest thats in your home except now you have full access to it in Guildhall (**OFFLINE ONLY**)
- The NPC by the questboard in guildhall now allows you to create/improve your equipment. (**OFFLINE ONLY**)
- The felyne between the table and Treshi in guildhall now has a new peddler shop menu. This menu is separate from granny peddler outside the hall and doesnt affect when items go on sale or the table rotations themselves. It is the combination of all peddler tables into one static table. (**ONLINE/OFFLINE**)

The reason why the new smithy/full chest codes are offline only is due to a limitation of the game which can lead to crashing or unintended results.

### HUD off above 40 HP

A port of the Portable 3rd code that turns off your HUD when HP is above 40. HUD will reappear when below 40 or when pressing the L trigger.

### Bonus DLC

Unlocks all "Bonus" content. There's 2 codes depending on which language you chose on the patch. `EN` for English patched, `JP` for Japanese patched. 

Do note that you only want to have this enabled when at main menu, and only going between main menu and options menu as it hooks some specific prompts to avoid save corruption. So follow these steps:

1. Enable the code when at "Main" menu.
2. Go into "Options" menu and change any setting, exit out of options menu and confirm saving settings.
3. When back at "Main" menu turn off the code, go back into "Options" menu and revert the settings back to your preferred.

To confirm that it applied the bonus DLC, go to Download   and confirm to connect, at the "following Bonus content is saved" prompt it should list some of it as being saved.

### Minimap Scaled 75%/50%

Changes the "scale" of the minimap to either 75% or 50% of its original size. Only have either the 75% OR 50% enabled, not both. Also have them enabled before playing to prevent issues.

### True Raw/Ele/Status

"Debloats" the Raw, Element and Status values of all weapons. Similar feature like in Portable 3rd where you had the true value listed. There's 2 versions depending on which language you patched, if English choose `EN` else if Japanese choose `JP`.

### Enable Cross-play

This is specific to HunsterVerse. This allows cross-play between FUComplete and unmodded versions of the game. There are some things to note:

1. When the code is enabled, you can play with FU/P2G players however the event quests in each section are removed from listing to avoid issues with unpatched clients.
2. The only quests outside of the ones that came with the game that do work with unmodded versions are the challenge quests. This is because they are added to your save and thus are treated as valid "DLC" quests.

Please check [here](https://github.com/FUComplete/Patch/wiki/Enhancements-and-BonusDLC#enable-cross-play) for the code or see pins on HunsterVerse.

# FAQ

### Why use P2G as a base and not FU? 

Due to issues with finding translators for the various langauges and having memory limit issues, it was decided to move to P2G as I didnt have to worry about more than one language and I had significantly more memory to play with.

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

### I went to the "Events" tab and there are no event quests? Where are they?

Each event quest is stored in their respective "★" rank. So if a quest was 8★, it'll be in the 8★ page. Please refer to the wiki for a list of the event quests.

### Is there info on what the challenge/fiesta quests are? Can't see what the quest details are from the selection screen.

The `CQUESTS.TXT` file contains info on each challenge fiesta quest so refer to that if you would like to know the specifics about them.

### Why can't my P2G save load (`EN`)? Why can't my FU save load (`JP`)?

For `EN`, to easily allow FU players to migrate to this patch the savedata decrypt and encrypt method was change to match that of FUs.

For `JP`, there's really no reason to use FU saves when the Japanese language is set... 

### I have "Data Install" enabled and get "Install Data is corrupted". 

There is some sort of check going on that doesnt validate the new larger files, so it is recommended to have the Data Install feature turned OFF.

### Why can't I join other players/halls and am put into a weirdly named game/hall?

Due to the way the patch works, there's compatibility issues with crossplay between unpatched and patched versions of the game. As of 1.1 there will will be a code provided to HunsterVerse to allow crossplay.

### I used the Guildhall QoL code and I can't access smithy/full chest in hall?

With the way the game works with adhoc play, If a player changes equipment in hall theres a very high chance of a crash... Even if the player manages to get to the point of embarking on a quest, when it validates what gear the player had it will visually show you having switched... but will still have the gear you had on when you initially joined the hall. For this reason smithy/full chest are blocked from online play and are OFFLINE ONLY.

# Credits and Thanks

**Hario** for helping with the programming side of things.

**Rozalin** and **ShadyFigure** for translations.

**Codestation** for [mhtools](https://github.com/codestation/mhtools).

**Svanheulen** for [mhff](https://github.com/svanheulen/mhff) and [mhef](https://github.com/svanheulen/mhef).

**AsteriskAmpersand** for [PMO-Importer](https://github.com/AsteriskAmpersand/PMO-Importer).

**Yuzucchi** for insight on some code.

**Capcom** for creating P2G/FU.

