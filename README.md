# SWM Modular Modpack – Reborn & Rejuvenation

## Overview

This repository maintains and updates the **SWM Modular Modpack** for both **Pokémon Reborn** and **Pokémon Rejuvenation**.

SWM is a fully modular collection of gameplay enhancements for the Rebornverse.  
Each component is **stand-alone**, allowing players to install only the mods they want.

This project focuses on keeping the mods working on modern versions of both games and making future maintenance easier.

---

## Installation

- For **Pokémon Reborn**, use the mods located in the `ModsReborn` folder.
  - Copy the desired SWM modules into the game’s `patch/Mods` folder.  
- For **Pokémon Rejuvenation**, use the mods located in the `ModsRejuv` folder.
  - Copy the desired SWM modules into the game’s `Data/Mods` folder.



⚠️ Remember to **delete any components you do not want** before launching the game.  
⚠️ Do **not** mix Reborn and Rejuvenation versions of the same mod.

---

## <span style="color:blue"> **Brief summary of each mod component** </span>
**(Please remember to check and delete the components you do not want when you are installing this mod pack!)**
 
<details>

* "**SWM - AAA**": this mod is a trap. It only exists to crash the game for people who dump everything in without reading the Readme.<br />
Please don't warn other players about this - doing so defeats the purpose of this mod.
<br />

* "**SWM - AutoDex**": this mod automatically updates your Pokedex by marking all species and forms in an evolutionary line as seen and captured whenever you catch a new Pokemon.<br />
The evolutionary line of event Pokemon will be updated after the next battle.<br />
Notifications for added entries can be enabled by editing the "SWM - AutoDex.rb" file and setting the global variable "$swm_autoDex_showNotification" at the start to true.
<br />

* "**SWM - ChooseStarter**": while you are in the starter selection room, you can select your starter (as if you wanted to give it an item) and use the "Change starter" option to randomize or choose its species.
<br />

* "**SWM - ConsistentRandomness**": tries to keep random rolls the same every time you reload your save, providing a consistent experience. You can't reload hoping for a lucky crit that didn't happen already, but you can expect that that lucky Toxic hit will happen again if you make the same choices. Also prevents streaks in random rolls: for example, if you get a 6 on a six-sided die, you're guaranteed not to see another 6 in the next 5 rolls, helping keep outcomes balanced without changing the odds.
<br />

* "**SWM - EvOverflow**": if your mon's EV in any stat would go over 252, without breaking the 510 overall limit, then you are offered the choice to improve its IV, at the cost of resetting that EV.<br />
If instead you use friendship berries at 0 EV you are offered the choice to reduce the IV.<br />
Use the password "noevcap" to disable EVs being lowered to make room for new gains when reaching the 510 overall limit.
<br />

* "**SWM - GlamazonShop**": Hi, I’m Jeff Beldum, CEO of glamazon.pkm and renowned specialist in Teleporting Pokemon.<br />
Our new branch in the Reborn region brings the world of online shopping directly to your PC!<br />
No more backtracking to PokeMarts or running out of supplies in the middle of a Gym battle. With Glamazon Shop, you can browse and order items remotely from any store you have access to.<br />
Tired of manually shopping for your most-used items? No problem! Our TopMeUp service ensures you never run out by automating the buying and selling process. Just set the lower and upper limits, and our team will handle the rest!<br />
For a limited time, the service is free of charge for everyone. Sign up today, and let us Teleport your convenience to the next level!
<br />

* "**SWM - ItemRadar**" changes the ItemFinder so that, when activated, it stays on and marks hidden items on the game map.<br />
(Alternative graphics by **Player_Null_Name**  : https://www.rebornevo.com/forums/topic/24930-swm-modular-modpack-e19/?do=findComment&comment=808102 <br />
Alternative graphics by **Xander** : https://www.rebornevo.com/forums/topic/24930-swm-modular-modpack-e19/?do=findComment&comment=835844 <br />
Alternative graphics by **SimplyEmy** : https://www.rebornevo.com/forums/topic/24930-swm-modular-modpack-e19/?do=findComment&comment=971656 <br />
To use them, download the .png image attached to the linked post and use it to replace the mod's default "SWM - ItemRadar.png" file)
<br />

* "**SWM - LearnEggMoves**" lets the move relearner teach any egg move.
<br />

* "**SWM - MiningForRich**": while mining the wall won't collapse, but mining further costs cumulatively more and more money (spent on materials to build a tunnel, of course :P ).
<br />

* "**SWM - NoTMXAnimations**" hides the TM animations for using Cut, Strength, etc, out of battle.
<br />

* "**SWM - PredictRelationshipValues**" makes the move Psychic usable out of combat, and using it lets you know each npc's relationship value.
<br />

* "**SWM - ReusablePremierBalls**": Premier Balls in the vanilla game are kind of boring - they're just normal balls, which makes them just a small discount for buying balls in bulk.<br />
With this mod they become reusable - using them on a wild mon won't actually decrease their number in your bag.<br />
They also act like a decentralized unit: their catch rate is a lot lower than their normal catch rate, but scales linearly with how many you have, with no cap.<br />
(Their catch rate with the mod becomes the same as the vanilla one when you have 50 of them in your bag)
<br />

* "**SWM - SharedPC**" makes the last box in the PC shared amongst savegames: mons you put in it will be there if you start a new game or load a different savegame.<br />
If updating from E18: please note that you have to load up your latest savegame and save once in E19 in order to use the Shared Box in a new game.
<br />

* "**SWM - SnappyMenus**" makes menu transitions instantaneous.
<br />

* "**SWM - TypeBattleAnnouncer**" causes the announcer to say the species and typing of opponent mons about to enter the field instead of their names.
<br />

* "**SWM - TypeBattleIcons**" shows each mon's type in battle.
<br />

</details>

<br />

---

## Notes

- Not all SWM modules exist for both games.
- Some modules may behave differently due to engine differences.
- Contributions, ports, fixes, and missing modules are welcome.

All credit goes to the original creators of the SWM Modular Modpack.  
This repository exists to preserve, maintain, and modernize it for current Rebornverse versions.

