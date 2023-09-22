# ArmA 3 - Persistent Save System

## Goal

The goal is to create a reliable and modifiable persistent save / load system, which can work both standalone and alongside vanilla save system.

## But why?

Vanilla save system is great when it's used for saving missions, which you'll complete in at most a couple of hours.

The problem is that long scenarios, such as Ravage or Antistasi, may be played indefinitely. Vanilla save system is not prepared to handle such situations and there are many issues, when a player uses original saving functionality to keep his progress. Some examples:

- **ArmA 3 updates make the save incompatible** (this can be easily fixed when a minor version is changed by decompiling > updating version > recompiling a save file, but with a major version update I wasn't able to do this workaround, the game always crashed while loading).
- After time, **there's a lot of garbage in a save file**. You accidentally touched a building with your vehicle? Don't worry, ArmA's save system got you covered! All 0.00001 damages will be kept in the save file.
- Examples of problems while playing Ravage:
  - Actions such as searching for loot or sleeping slowly stop working.
  - Game lag gradually increases in time, until it becomes very noticeable.
  - Weird stuff happens, such as bandit cars with dead units spawn on the road. When you try to enter, bodies disappear, so no loot for you.
  - After time, saving takes a looong time to finish, same with loading.

## What about Antistasi's persistent save system?

It's awesome and this one works on the same principle, i.e. by using profileNamespace to keep the data. Huge thanks for the idea to Antistasi team. You can checkout the original at https://github.com/A3Antistasi/A3-Antistasi/tree/master/A3-Antistasi/statSave.

So, Antistasi save system is great, but it's not too easy to extend or even use in your mission. This project tries to do something similar, but more mission-maker-friendly and easier to use in any scenario, with more possibilities to add custom stuff to the save file.

## Can I backup my saves?

Yes. The best idea is to use a separate profile for each long-term scenario. All it takes to make a backup is to copy the YourProfileName.vars.ArmA3Profile to a safe location.

Remember, that this file contains **all** stored variables, also by other missions! That's why you should consider using a separate profile, just to make sure that you won't lose progress in another scenario after restoring a backup.

## Can I help?

Sure! If you can help with development or testing and reporting bugs, let me know on Discord.

## Can I use this in my own scenario?

Yes, but keep in mind, that only stable releases are safe to use, other may contain bugs. Also, a contribution would be really nice! :)

## Contact

Discord: https://discord.gg/sMNZaUxW

