<div align="center">

[![LATEST](https://img.shields.io/github/v/release/FUComplete/Patch?label=LATEST&style=for-the-badge)](https://github.com/FUComplete/Patch/releases/latest)[![DLOADS](https://img.shields.io/github/downloads/FUComplete/Patch/total?style=for-the-badge)](https://github.com/FUComplete/Patch/releases)[![Ko-fi](https://img.shields.io/badge/support_me_on_ko--fi-F16061?style=for-the-badge&logo=kofi&logoColor=f5f5f5)](https://ko-fi.com/incognitoman)

<a>
  <p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/5410031/221336968-d4518bd4-b2ec-4e53-9282-ed8dca82856e.svg">
      <img height="150px" src="https://user-images.githubusercontent.com/5410031/221336946-f21aff0f-84b5-4661-92b7-da1a520a46a2.svg">
    </picture>
  </p>
</a>
</div>

***

FUComplete is a modification of the game MHP2G (Portable 2nd G), aiming to be "feature complete" and add/expand to the game while also maintaining crossplay with vanilla players. It also aims to work not only on emulation but also on real hardware like PSP or Vita.

Features:

* MHFU localization ported over and Japanese exclusive content translated to English.
* Able to load any region save without a need to convert.
* All 38 events and 14 challenges are integrated into the game.
* Increased limit on quests in savedata from 6 to 18.
* In-game toggle to switch between built-in (official) events and savedata (custom) quests.
* Modloader support, which makes updating and modding the game "*easier*".
* Configuration file support so you can enable/disable/tweak the features you want.
* Various QoL features such as:
  - Guildhall drink buff
  - Full chest access in the Gathering Hall[^2]
  - Early kill Lao/Shen on Fortress[^4]
  - Faster pickup from supply chests
  - ...and more!

For more details on the changes see [What's Changed](#whats-changed)

# Applying Patch

Make sure you use either a UMD dump or PSN version of `Monster Hunter Portable 2nd G`.

Download the [latest release](https://github.com/FUComplete/Patch/releases/latest).

With the latest release, there is now a new app included to handle patching, configuration, file replacer and quest injection called [FUCTool](https://github.com/FUComplete/FUCTool). Launch it and under the `Patcher` tab press the `Select` button to select your ISO.

In the output window you should see:
  ``` 
  INFO | Checking ISO...
  INFO | Valid ISO file.
  ```
If instead you get:
  ```
  INFO | Checking ISO...
  ERROR | Invalid ISO, your dump should match one of the following md5 hashes:
  ERROR | UMD: 1f76ee9ccbd6d39158f06e6e5354a5bd
  ERROR | PSN: cc39d070b2d2c44c9ac8187e00b75dc4
  ```
Please make sure you select the correct image that matches the above hashes.

Check `Keep patched DATA.BIN outside of the ISO.` if you plan to modify files and use file replacer.

Press the `Patch ISO` button to start the patching process. You'll know its done once you see `INFO | Patching done`

<div align="center">

| <img src="https://user-images.githubusercontent.com/5410031/221740339-9e2baf45-cfba-4798-af37-4a819f0d24d3.png" width="50%"></img> |
|:---:|
| Patching Completed |

</div>

# Frequently Asked Questions

### Why use P2G as a base and not FU? 

* Due to issues with finding translators for the various langauges and having memory limit issues, it was decided to move to P2G as I didn't have to worry about more than one language and I had significantly more memory to play with.

### When I try to patch the game it says "Invalid ISO"?

* Please use a clean dump of `Monster Hunter Portable 2nd G`, either from your UMD or PSN. Your ISO should match one of the following hashes: 
  ```
  UMD - MD5: 1f76ee9ccbd6d39158f06e6e5354a5bd
  PSN - MD5: cc39d070b2d2c44c9ac8187e00b75dc4
  ```

### What are the default settings?

* Default settings are as follows:
  ```
  File replacer:       DISC0
  Save Region:         ULUS10391
  True Raw/Ele/Stat:   Disabled
  Dos Audio:           Disabled
  Field of View:       Default
  Vert Cam Start Pos:  Default
  Minimap Scale:       Default
  HH Tweak:            Disabled
  Lao/Shen Early Kill: Disabled
  ```

### How do I change the default settings?

* Use [FUCTool](https://github.com/FUComplete/FUCTool) to manage `config.bin`. Please check out the tools repo for more information on what each option does.

### Where do I place `config.bin`?

* This depends on if you are on Emulator(PC/Android) or PSP/Vita.
  - If on PC (PPSSPP): Go to `File` → `Open Memory Stick` and you should be in the "root" of the memory stick.
  - If on Android (PPSSPP): By default Android sets the "root" directory at the root of your storage. If you are unsure where it is, go to `Settings` → `System` and scroll down to the `PSP Memory Stick` section.
  - If on PSP/Vita: Go to the root of your memory stick. On Vita for example it's `ux0:/pspemu` and PSP is literally root of of memory card.

| <img src="https://user-images.githubusercontent.com/5410031/221684781-2c7eefe8-8872-435e-8e2f-4682a74c1a40.png"></img> | <img src="https://user-images.githubusercontent.com/5410031/221686090-6c87f3f5-6f2c-4bcd-9310-981f3d5df25c.png"></img> | <img src="https://user-images.githubusercontent.com/5410031/221691384-ae9db9fb-487f-427c-a530-6ba2422ed67c.png"></img> |
|:---:|:---:|:---:|
| PC | Android | PSP/Vita | 

* Once you are at the root, create a folder called `FUC` and place `config.bin` inside that folder. It should look something like this:
  ```
  .
  ├───FUC
  │   └───config.bin
  └───PSP
      ├───GAME
      └───SAVEDATA
          ├───ULES01213
          ├───ULUS10391
          └───ULJM05500
  ```

### How do I use File Replacer?

* Please refer to [FUCTool](https://github.com/FUComplete/FUCTool) repo for more info on how to set it up and make use of it.

### Why do I get "Old savedata detected" on PPSSPP after adding/removing quests from save? Does it cause any problems?

* It won't cause problems, once you save in-game the error message will go away.
* SED is used to handle the encryption side of things which seems to use an older method of save encryption.

### When I run the game on my PSP/Vita, village lags/runs slow... how do I fix this?

* Please set your CPU clock speed to `333/166` by pressing `Select` at VSH menu and changing the option `CPU CLOCK GAME` to `333/166`. 

| <img src="https://user-images.githubusercontent.com/5410031/221753464-6f484bdf-9f77-4be9-af68-74ce12b5f5d6.png" width="50%"></img> |
|:---:|
| VSH Menu |

### Why do my quest files not show up on FUCTool?

* Quest files must be either `.mib` or `.pat` and have to be **decrypted**. 

### Is there info on what the challenge/fiesta quests are? Can't see what the quest details are from the selection screen.

* The `CQUESTS.TXT` file contains info on each challenge/fiesta quest, so refer to that if you would like to know the specifics about them.

# What's Changed

### <ins>FUCTool:</ins>

A new program called `FUCTool` is bundled with the patch to handle various aspects such as patching, updating the configuration file, setting up file replacer and injecting quests. To know more on how to use it please see the [FUCTool](https://github.com/FUComplete/FUCTool) repo.

### <ins>Configuration:</ins>

`config.bin` is the configuration file loaded by the game to set specific features of the patch, these options are:

* File replacer read location
* Save region
* True raw/element/status display
* Dos audio
* Field of view (FoV)
* Vertical snap start position
* Minimap scale
* Hunting Horn tweak
* Early kill Lao/Shen (Fortress)

### <ins>File Replacer:</ins>

File replacer, as its name implies, lets you replace individual files in the game that are stored in `ms0:/FUC/nativePSP`. Think of it like MHWs `nativePC` implementation.

Please refer to the [FUCTool](https://github.com/FUComplete/FUCTool) repo for more information on how to set it up.

### <ins>Changes:</ins>

_**Quality of Life**_
* The 38 events and 14 challenges are now built into the game. Savedata quest store limit has been raised to 18, up from 6.
* The option to toggle Data Install now has a new function: It now switches between the integrated event quests and any quests added to Savedata.
* All Bonus DLC are enabled by default.[^1]
* Easily switch between what region save to load ***(optional/config)***.
* Auto equipment previews in shops enabled by default without the requirement of a data install.
* Faster pickup speed from supply chests.
* Able to buy in bulk to chest the Binoculars, Powercharm, Armorcharm and BBQ Spit. Useful for decoration crafting.
* You can now change your equipment in the Gathering Hall.[^2]
* Status display settings (the settings for enabling/disabling HUD in quest) are now persistent between quests.
* Guildhall table now has a "drink buff" - This means you can get a quick boost to Health and Stamina without leaving the Gathering Hall, based on how many Felyne Chefs you have working in your kitchen. Press 'Circle' to activate while sitting at the table.[^3]
  - For each active chef in your kitchen, receive +10 max HP (max +50 at 5 chefs).
  - For 1-4 active chefs in your kitchen, receive +25 max Stamina (max +50 at 5 chefs).
* Display true raw/element/status of weapons ***(optional/config)***.
* Adjust field of view value ***(optional/config)***.
* Set starting vertical camera position ***(optional/config)***.
* Adjust minimap scale ***(optional/config)***.

_**Gameplay/Mechanic**_
* Any quest with Lao-Shan Lung, Ash Lao-Shan Lung or Shen Gaoren on Fortress have their HP thresholds removed, allowing for a pre area 5 kill. ***(optional/config)***[^4]
* Hunting Horn tweaks ***(optional/config)*** rework the weapon slightly to make it more approachable and rebuff it back to P2/F2 levels.
  - Note mechanics work similar to Frontier, where notes only clear if you sheath your weapon or have a forced sheathed interaction.
  - Left and right swing MV/KO values increased to match P2/F2 values. 31 MV and 18 KO, up from 27 MV and 15 KO.
  - Hilt jab poke attack now does cutting damage instead of impact.
  
_**General/Other**_
* Fixed various localization errors and updated menus to match.
* Increased draw distance of NPCs in village.
* Adjusted item wheel to match FU
* Sharpness indicator and glow now uniform and fixed.
* Fixed draw region of the "!" sprite to display properly.
* Felyne on guildcard no longer has melynx ears.
* Bowgun shells in HUD are now correctly aligned.
* Guildcard elements fixed to avoid string overflows and better alignment.
* Guildhall Shop NPC position fixed, feet no longer clip through the floor and now has a shadow.
* Wandering Chef NPC position fixed, no longer floats in the air and is more visible on game start.
* Dummied strings for non-monsters now display properly when using HPD hack.
* ICON0 updated so you can easily tell the difference between patched/unpatched.
* Use Dos battle themes instead of the default ones ***(optional/config)***.

[^1]: Bonus DLC is as follows: Peddling Granny Items, Trenya's Boat, 3000 Pokke Points, Piggie Fashions (Angel Leotard, Sleep Pig White, Mafumofu Jumpsuit, Famitsu Disguise), Titles, Comrade Skills (Elemental Atk Dragon), Felyne Comrade Armor (Felyne Samurai), Wandering Felyne Chef. 
[^2]: Equipment changing is ***disabled*** in the online Gathering Hall.
[^3]: This does not provide any felyne food skills and you can either drink in hall for a quick boost ***OR*** eat in kitchen... not ***BOTH***.
[^4]: If you play with unpatched players and want a "early" kill, make sure you or another patched player are the first to enter the area. This is because area host is in control of HP mechanics.


# Credits and Thanks

**Hario** for helping with the programming side of things.

**Rozalin** and **ShadyFigure** for translations.

**Codestation** for [mhtools](https://github.com/codestation/mhtools).

**Svanheulen** for [mhff](https://github.com/svanheulen/mhff) and [mhef](https://github.com/svanheulen/mhef).

**AsteriskAmpersand** for [PMO-Importer](https://github.com/AsteriskAmpersand/PMO-Importer).

**Yuzucchi** for insight on some code.

**Capcom** for creating P2G/FU.

**Testers** - Fallingferret, Abbanon, 6thQuill, RecitalMode, Mr.Madness and anyone else I may have missed.

**[MH Modding Discord](https://discord.gg/gJwMdhK)** for putting up with my rants and helping out with figuring out some of the code. Especially a thank you to Silvris, Miralis and Dave uRrr.
