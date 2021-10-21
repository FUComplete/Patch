// Reallocated table for quests... this
// table is the Guild Hall quest ID pages
// str_tbl.pac @ 0x6B000

.org 0x08A32510 // revisit this once str_tbl is finalized


// Pointers for each star
// HR1
.dw 0x08A32540  // 1* 
.dw 0x08A32558  // 2*
.dw 0x08A3256C  // 3*

// HR2
.dw 0x08A3259C  // 4*

// HR3
.dw 0x08A325D4  // 5*

// HR 4
.dw 0x08A32604  // 6*

// HR 5
.dw 0x08A32624  // 7*

// HR 6
.dw 0x08A32660  // 8*

// HR 7
.dw 0x08A326B0  // 9*

// HR 8 
.dw 0x08A326EC  // 10*

// HR 9
.dw 0x08A32734  // 11*

.fill 4

// Quest ID

// HR1
// 1*
.dh 1       // A True Foe - The Giadrome!
.dh 2       // Reckless Bulldrome Hunter
.dh 3       // A Pack of Blangos
.dh 4       // Mountain Herb Picking
.dh 5       // Rarest of the Rare Beasts
.dh 6       // Hunt the Rare Forest Congas!
.dh 7       // A Mushroom Goldrush!
.dh 8       // The Land Shark
.dh 9       // The Giant Enemy Crab
.dh 10      // The Lady Gourmet
.fill 2
.align 4
// 2*
.dh 101     // The Shadow in the Mountains
.dh 102     // The King of the Mountains
.dh 103     // A Swarm of Hermitaurs
.dh 104     // Water Wyvery in the Desert
.dh 105     // Gypceros: Venomous Terror
.dh 106     // Supreme Ruler of the Swamp
.dh 107     // Slay the Great Kut-Ku!
.dh 108     // Eliminate the Rathalos!
.dh 109     // Attack of the Rathian
.fill 2
.align 4
// 3*
.dh 1001    // Gathering - Snowy Mountains
.dh 1002    // Gathering - Jungle Zone
.dh 1003    // Gathering - Desert Zone
.dh 1004    // Giadrome Assault
.dh 1005    // The Mountain Roughrider
.dh 1006    // Slay the Giaprey!
.dh 1007    // Find the Mountain Herbs!
.dh 1008    // Hunt Down the Velocidrome!
.dh 1009    // Blue Menace of the Jungle
.dh 1010    // Cunning Raiders
.dh 1011    // Attack of the Giant Bugs!
.dh 1012    // The Mushroom Hunt!
.dh 1013    // Panning for Goldenfish
.dh 1014    // Hunt the Gendrome!
.dh 1015    // The Land Shark
.dh 1016    // The Lurking Desert Giant
.dh 1017    // Slay the Genprey!
.dh 1018    // Liver of Legend!
.dh 1019    // Gone Fishin'
.dh 1020    // Attack of the Yian Kut-Ku
.dh 1021    // Charge... Charge... Charge!
.dh 1022    // The Mischief-maker
.dh 30001   // Its name is "Mega Kut-Ku"!? (m60023)
.fill 2
.align 4

// HR2
// 4*
.dh 1101    // Gathering - Swamp Zone
.dh 1102    // Gathering - Forest and Hills
.dh 1103    // Gathering - Volcanic Zone
.dh 1104    // The Ruler of the Snow
.dh 1105    // The Shadow in the Cave
.dh 1106    // Red Shadow in the Snow
.dh 1107    // Blango Slaying Tactics
.dh 1108    // The Subterranean Glutton
.dh 1109    // Master of the Giant Lake
.dh 1110    // The Pink Fur Party
.dh 1111    // The Hidden Jungle Clouds
.dh 1112    // The Underwater Terror
.dh 1113    // Evening Hermitaur Sonata
.dh 1114    // The Purple Poison Menace
.dh 1115    // Pincer through the Sky
.dh 1116    // Chase the Poison Gypceros!
.dh 1117    // Trouble in the Forest
.dh 1118    // Seeking the Strange Mask
.dh 1119    // The Ioprey Leader
.dh 1120    // Commander in the Flames
.dh 1121    // Basarios: Unseen Peril
.dh 1122    // A Band of Ceanataurs
.dh 1123    // Great Ore Discovery
.dh 1124    // A Giant Dragon Invades!
.dh 1125    // The Meeting of Daimyo
.dh 1126    // Go Fish Goldenfish!
.fill 2
.align 4

// HR3
// 5*
.dh 1201    // Absolute Power
.dh 1202    // The Tigrex's Roar
.dh 1203    // The Runaway Diablos
.dh 1204    // The Fierce Black Horn
.dh 1205    // Valor in the Swamp Zone
.dh 1206    // Terror of the Gravios
.dh 1207    // The King's Domain
.dh 1208    // Attack of the Rathalos
.dh 1209    // The Queen's Descent
.dh 1210    // The Cherry Blossom Rathian
.dh 1211    // The Legenday Kirin
.dh 1212    // The Red and Green Wyverns
.dh 1213    // Attack of the Wind Dragon
.dh 1214    // A Sun with Fangs
.dh 1215    // Emperor of Flame
.dh 1216    // The Elder Dragon of Mist
.dh 1217    // Towards the Silence
.dh 1218    // The Approaching Gaoren
.dh 1219    // Two Little Shadows
.dh 1220    // A Horde of Congalalas
.dh 30002   // Laurel, Please (m60025)
.dh 30003   // Triumvirate of the Sands (m60024)
.fill 2
.align 4

// HR4
// 6*
.dh 2001    // Gathering - Snowy Mountains
.dh 2002    // Gathering - Jungle Zone
.dh 2003    // Gathering - Desert Zone
.dh 2004    // A True Foe - The Giadrome!
.dh 2005    // Reckless Bulldrome Hunter
.dh 2006    // Flanked by Velocidrome
.dh 2007    // Aim for the Jungle Crab
.dh 2008    // The Poison Fanged Duo
.dh 2009    // Pursuit of the Sand Wyvern
.dh 2010    // Ultimate Crab Dinner
.dh 2011    // Trapped by Yian Kut-Ku
.dh 2012    // Conga Counterattack!
.dh 2013    // The Beating of Royal Wings
.dh 30004   // 2 Colors of Meow - Sm. Arena (m60033)
.fill 2
.align 4

// HR5
// 7*
.dh 2101    // Gathering - Swamp Zone
.dh 2102    // Gathering - Forest and Hills
.dh 2103    // Gathering - Volcanic Zone
.dh 2104    // Two Roars in the Snow
.dh 2105    // The King of the Mountains
.dh 2106    // The Electrified Wyvern
.dh 2107    // Red Shadow in the Swampland
.dh 2108    // The Poison Gas
.dh 2109    // Dual Plesioth
.dh 2110    // Attack of the Rathian
.dh 2111    // Water Wyvern in the Desert
.dh 2112    // The Underwater Terror
.dh 2113    // An Evening Soaked in Poison
.dh 2114    // Supreme Ruler of the Swamp
.dh 2115    // The Purple Poison Menace
.dh 2116    // Eliminate the Rathalos!
.dh 2117    // The Shogun's Encampment
.dh 2118    // Basarios: Unseen Peril
.dh 2119    // Envoy to Disaster
.dh 2120    // Loa-Shan Lung Draws Near!
.dh 2121    // Meeting of the Blangongas
.dh 2122    // The White Brute
.dh 2123    // Pricy Mushrooms, Shaka!
.dh 2124    // The Big Dirt Nap
.dh 2125    // Twin Walls of the Jungle
.dh 2126    // The Meeting of Sea and Air
.dh 2127    // Red Lightning, Violet Blade
.dh 30005   // Baby Boom! Flocking to Sleep (m60026)
.dh 30006   // Jungle Hunt! (m60027)
.fill 2
.align 4

// HR6
// 8*
.dh 2201    // Land of the Tremors
.dh 2202    // The Rajang in the Snow
.dh 2203    // The Tigrex's Roar
.dh 2204    // Pink Dance in the Jungle
.dh 2205    // The Runaway Diablos
.dh 2206    // The Fierce Black Horn
.dh 2207    // Four Horns
.dh 2208    // Rajang of the Mountain Flames
.dh 2209    // Terror of the Gravios
.dh 2210    // Black Rock in the Swamp
.dh 2211    // A Troublesom Pair
.dh 2212    // Blue Sky, Pink Earth
.dh 2213    // Attack of the Rathalos
.dh 2214    // Deny the Silver Rathalos
.dh 2215    // Find the Golden Phantom
.dh 2216    // The Fleeting Shadow
.dh 2217    // The Frozen Dictator
.dh 2218    // The Elder Dragon of Wind
.dh 2219    // The War on Immolation
.dh 2220    // Emperor of Flame
.dh 2221    // The Elder Dragon of Mist
.dh 2222    // Towards the Silence
.dh 2223    // Legendary Black Dragon
.dh 2224    // The End Times
.dh 2225    // The Approaching Gaoren
.dh 2226    // Rise to the Summit
.dh 2227    // Ancestral Dragon
.dh 2228    // Wyvern of the Wind
.dh 2229    // Born of Darkness
.dh 2230    // Two Queens
.dh 2231    // One-Horned Demon King
.dh 2232    // Phantasmic Battle
.dh 2233    // Furious Beauties
.dh 2234    // Fight of the Throne
.dh 2235    // Hotter than Hell Itself
.dh 2236    // Desert Unifier
.dh 30007   // Aquatic Festival (m60028)
.dh 30008   // The Big Daddy (m60029)
.dh 30009   // JUMP: Flame Emeror's Return (JDLC1) (m60036)
.fill 2
.align 4

// HR7
// 9*
.dh 3001    // G-Lvl Gathering - Grt Forest
.dh 3002    // G-Lvl Gathering - Old Jungle
.dh 3003    // G-Lvl Gathering - Old Desert
.dh 3004    // G-Lvl Gathering - Old Swamp
.dh 3005    // G-Lvl Gathering - Snowy Mts.
.dh 3006    // Shakalaka Showdown!
.dh 3007    // The Beating of Royal Wings
.dh 3008    // The Big Dirt Nap
.dh 3009    // Hypno, Hypno!
.dh 3010    // Trapped by Yian Kut-Ku
.dh 3011    // Giant Crab of the Old Jungle
.dh 3012    // Daimyo of Sengoku Fame
.dh 3013    // Wag the Dog!
.dh 3014    // Old Jungle Lightning
.dh 3015    // Red Shadow in the Snow
.dh 3016    // Tales from the Old Swamp
.dh 3017    // Eyes in the Underground Lake
.dh 3018    // Giant Green Waves of Verdure
.dh 3019    // Prodigal Pack Attack!
.dh 3020    // Pelagus Pride
.dh 3021    // Trickster!
.dh 3022    // Stealing the Jungle!
.dh 3023    // Old Swamp, Shrouded in Mist
.dh 3024    // Subspecies Three!
.dh 3025    // Predators of the Swamp
.dh 30010   // Porky Panic Party! (m60020)
.dh 30011   // Expunge the Funk! (m60013)
.dh 30012   // Super Hypnocatrice Brawl (m60021)
.fill 2
.align 4

// HR8
// 10*
.dh 3101    // G-Lvl Gathering - Frst&Hills
.dh 3102    // G-Lvl Gathering - OldVolcano
.dh 3103    // Ever-Present Shadow
.dh 3104    // Assassin of the Swamp
.dh 3105    // Ancient Beauty, Black Beast
.dh 3106    // Lavasioth Sighting!
.dh 3107    // River of Fire
.dh 3108    // Strong Sword, Strong Shield
.dh 3109    // Commander in the Flames
.dh 3110    // Dark-Shelled Ceanataur
.dh 3111    // Under the Gaze of Heaven
.dh 3112    // At Birds' Hill...
.dh 3113    // A King, Robbed in Smoke
.dh 3114    // The King's Domain
.dh 3115    // Her Eternal Majesty
.dh 3116    // The Cherry Blossom Rathian
.dh 3117    // Howling at the Moon
.dh 3118    // The Yian Garuga Twins
.dh 3119    // The King of the Mountains
.dh 3120    // Copper Sands
.dh 3121    // Wild Monk of the Dunes
.dh 3122    // Basarios Season
.dh 3123    // Operation Tropical Storm
.dh 3124    // Save the Great Forest Town!
.dh 3125    // Three Walls
.dh 3126    // A Hunter's Feast
.dh 3127    // Lao-Shan Lung Draws Near!
.dh 30013   // Surrounded in a Sea of Magma (m60022)
.dh 30014   // Two Walls? Dark Winds (m60011)
.dh 30015   // Beasts of the Dunes (m60012)
.dh 30016   // Arena of Blood and Tears (m60017)
.dh 30017   // Amezari Carnival! (JDLC2) (60001)
.dh 30018   // Magazine: Giant Bird Formation (JDLC3) (60009)
.dh 30019   // Famitsu: Cherry Blossom Season (JDLC4) (60003)
.dh 30020   // JUMP: Red Rumble Roundup (JDLC5) (60007)
.fill 2
.align 4

// HR9
// 11*
.dh 3201    // Absolute Power
.dh 3202    // Land of the Tremors
.dh 3203    // Sandstorm Summoner
.dh 3204    // The Fierce Black Horn
.dh 3205    // Black Phalanges 
.dh 3206    // Armored Supremacy 
.dh 3207    // Terror of the Gravios
.dh 3208    // The Dark Cataphracts
.dh 3209    // Explore the Unexplored
.dh 3210    // A Single Beam of Moonlight
.dh 3211    // Descendants of the King
.dh 3212    // Child of Destruction
.dh 3213    // The Final Invitation
.dh 3214    // A Scenic Locale
.dh 3215    // It's Electric
.dh 3216    // Deathmatch on the Dunes!
.dh 3217    // Fire, Electricty, Heat Ray
.dh 3218    // The 3 Masters of the Volcano
.dh 3219    // Diamon Dust
.dh 3220    // Hunter's Funeral
.dh 3221    // Pride on the Line
.dh 3222    // Dragon of Steel
.dh 3223    // The Elder Dragon of Wind
.dh 3224    // A Midnight Audience
.dh 3225    // Emperor of Flame
.dh 3226    // Evaporate into the Night
.dh 3227    // Towards the Silence
.dh 3228    // The Floating Dragon
.dh 3229    // The Approaching Gaoren
.dh 3230    // Legendary Black Dragon
.dh 3231    // The End Times
.dh 3232    // Ancestral Dragon
.dh 3233    // Absolute Zero
.dh 30021   // Tiger of the Desert (60037)
.dh 30022   // Two Cliffs! Dark Hot Winds (60015)
.dh 30023   // Demon's Teardrop Mountain (60016)
.dh 30024   // Dual Twin Horns - Arena (60014)
.dh 30025   // Four Kings of Fire (60018)
.dh 30026   // Twin Terrors (60038)
.dh 30027   // Mountain in the Sky (60010)
.dh 30028   // Hunting God's Free-For-All (60019)
.dh 30029   // High Altitude King (60034)
.dh 30030   // Hunter's Fiesta! (60035)
.dh 30031   // Black Wings of Fate (60030)
.dh 30032   // Scarlet Skies (60031)
.dh 30033   // A White Beam of Light (60032)
.dh 30034   // Maoh: Demon King returns! (JDLC6) (60004)
.dh 30035   // Dengeki G: Ikaduchi Mountain (JDLC7) (60005)
.dh 30036   // Magazine: Tyranny of Tigrex (JDLC8) (60008)
.dh 30037   // Famitsu: Snowstorm Raider (JDLC9) (60002)
.dh 30038   // JUMP: Emperor of Explosions (JDLC10) (60004)
.fill 2
.align 16
