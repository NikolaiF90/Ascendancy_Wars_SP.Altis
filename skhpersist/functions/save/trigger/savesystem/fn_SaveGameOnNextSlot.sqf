/*
Saves game on next slot specified by TriggerSaveSystem_NextSaveSlot.
*/

[format ["Saving game on next save slot (%1).", TriggerSaveSystem_NextSaveSlot]] call skhpersist_fnc_LogToRPT;

[TriggerSaveSystem_NextSaveSlot] call skhpersist_fnc_SaveGame;