# Known Issues
* None currently

# Version History
* 1.7.4a 
    * Fixed allied unit surrendering when revived by player
    * Code optimization
    * Airport garrison preference increased from min 5 units per group to 6 units per group
* 1.7.3a
    * CDARS improved
        - If enemy reinforcement group count is more than 1, only 1 group will be counted as the garrison (if succesfully recaptured) and the other will be counted as replenish.
        - Replenishing troops won't despawn if player is near.
    * Bugfixed and code optimization
        - Enemy can now replenish their zone properly.

* 1.7.2a
    * New System : Conflict Dynamics and Adversarial Response System (CDARS)
        - Ability to dynamically track and manage player bounties based on their actions.
        - Enemy's reaction and actions are intricately tied to the player's choices and achievements.
        - CDARS not only quantifies the player's impact on the enemy's perception but also ensures that even passive actions or inactions are taken into account.
        - Reinforcement system also counted as CDARS

* 1.7.1a
    * New Feature: Reinforcement System
        - Implemented a dynamic reinforcement system to enhance gameplay. 
        - When the enemy calls for reinforcements, nearby zones capable of providing backup are identified. 
        - Zones with only one group of garrisons will not provide backup. 
        - The zone under attack will request reinforcements from other zones until a suitable provider is found. 
        - Garrisons are deducted from the backup provider, determining the size of the spawned reinforcement team. 
        - This new feature adds a realistic aspect to the gameplay, ensuring that units do not magically appear. 
    * Added skill for BLUFOR
    * Time multiplier can now be adjusted from inside initVars.sqf
    * Code optimization and bugfix
        - From now on, a captive unit can't capture a zone
* 1.7.0a
    * Reworked whole zoning and garrison system
        - Garrison System now works perfectly with Revive System.
        - Incapacitated units doesn't count as garrison, therefore they won't despawn.
        - Dead units no more disappeared after capturing zone, allowing player to loot them.
        - Enemy no more disappearing after capturing zone.
        - Zone capturing is no more limited to players. Now AI can also capture zones.
    * Code optimization and bugfixes
        - Fixed a bug where surrendering enemy is still giving orders
        - Removed old unused codes
        - Fixed unable to save stolen vehicle
        - Fixed the game unable to load properly if unit is not in a vehicle
        - The game will not tring to save a vehicle if unit not in one
* 1.6.3a
    * Revived enemy units will now surrender. They will drop all of their weapons, items and gear. 
    * Bugfixes and code optimization icluding addition of script explaination
* 1.6.2a
    * Incapacitated units will now bleedout and die if not being revived after certain time
    * Bugfixes and code optimization
* 1.6.1a
    * Stolen cars will now persistent across saves
    * Code optimization
    * Minor bugfix
* 1.6.0a
    * Now cars have chance to be spawned in towns
* 1.5.1a
    * Minor bugfixes
* 1.5.0a
    * Added revive system
* 1.4.0a
    * Added civilian disguise system
        - Now player can disguise as civilian and enemies
        - Entering enemy bases is now possible as long as you disguise as enemy, but be careful not to do anything suspicious
    * Added civilian recruitment
* 1.3.1a
    * Fixed bugs related to loading and saving
    * Now player can delete unused saves
    * Restrict players from playing the mission. Not until choice(start new game or load) has been made. This is to avoid unnecessary persistent related bugs.
    * Optimized scripts
* 1.3.0a
    * Now captured zones(outposts,resources,factories and etc) will be persistent across saves
    * A lot of bugs has been fixed
* 1.2.3a
    * Fixed amount of garrison keep on decreasing everytime player enter the zone
* 1.2.2a
    * Fixed a bug where if a player enter a zone twice, the zone info doesn't shown properly
    * Added a new notification if a player captured or loss a zone
* 1.2.1a
    * Light vehicle, tanks, statics will no longer appear at enemy garrison. This will be added in the future
    * Fixed garrisoned soldier not appearing after player re-entered enemy zones
* 1.2.0a
    * Reworked soldier spawning system
* 1.1.0a
    * Various bug fixes and optimizations
    * Fix not being able to properly load player group
* 1.0.0a
    * Initial Release
