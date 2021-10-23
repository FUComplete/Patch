# FUComplete Patch

This modification of P2G currently does the following:

* Ported localization from FU
* Built-in event quests along with translated japanese exclusive events/items
* Restored Dos audio (optional) 
* Loading of FU/F2 saves without conversion

...and because it's based on P2G means you also get:

* "Standard" control layout
* Uncensored blood
* Japanese exclusive poogie

# Applying Patch

**Please make sure your ISO matches the following hash:** 
```
MD5:    1F76EE9CCBD6D39158F06E6E5354A5BD
SHA-1:  951D1A360EEC83AF294A7A51EC4BBA08F8633A6E 
```
**If it doesn't, please redump your UMD.**

Download the [latest patch](https://github.com/FUComplete/Patch/releases/latest).

Drag and drop your ISO onto the `FUComplete.exe`, it will start patching the game. Answer `y` or `n` when asked about optional patches.

# Building

You will need [armips](https://github.com/Kingcom/armips) to build the project... you will also need to extract the files from DATA.BIN using [mhff](https://github.com/IncognitoMan/mhff) and [this organization script](https://gist.github.com/IncognitoMan/5606104bd3f4ab79c0e4e2f791acbda5).

Create a directory named `binary` and copy `BOOT.BIN` and the `overlay` folder from DATA.BIN extraction to it. also copy `str_tbl.pac` from `message_jpn` to `data` directory.

Create `build/overlay` directory.

Run `armips main.asm` to build. 

# Miscellaneous

Check [here](https://github.com/FUComplete/Patch/wiki/Enhancements-and-BonusDLC) for resized minimap hack and bonus dlc enable cheats.

# FAQ

### Why use P2G as a base and not FU? 

Due to issues with finding translators for the various langauges and having memory limit issues, it was decided to move to P2G as I didnt have to worry about more than one language and I had significantly more memory to play with.

### When I try to patch the game it says "Invalid ISO"?

Please use a clean **UMD** dump of P2G. If your ISO hash matches the following:
```
MD5:    CC39D070B2D2C44C9AC8187E00B75DC4 
SHA-1:  9CD281818ACDEDB18AC133BDFB738561BBA57AC1
```
Then you are trying to patch the PSN version of the game.

### I went to the Event tab and there are no event quests? where are they?

Each event quest is stored in their respective "★" rank. So if a quest was 8★, it'll be in the 8★ page. Please refer to the wiki for a list of the event quests.

### Why can't my P2G save load?

I modified the savedata decryption/encryption to use FU. If you want to use your P2G save on the patch, please convert your save to FU. 

### Why can't I join other players/halls and am put into a weirdly named game/hall?

Due to the way the patch works there's compatibility issues with unpatched and patched versions in multiplayer. To avoid these issues I have changed the game/hall to a new one. 

**So in order to play online, both sides need to be on the patch.**

# Credits and Thanks

**Hario** for helping with the programming side of things.

**Rozalin** and **ShadyFigure** for translations.

**Codestation** for [mhtools](https://github.com/codestation/mhtools).

**Svanheulen** for [mhff](https://github.com/svanheulen/mhff) and [mhef](https://github.com/svanheulen/mhef).

**AsteriskAmpersand** for [PMO-Importer](https://github.com/AsteriskAmpersand/PMO-Importer).

**Yuzucchi** for insight on some code.

**Capcom** for creating P2G/FU.

