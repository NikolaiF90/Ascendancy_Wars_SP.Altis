[Persistent_Debug, "initDialogSaveSystem", "Initializing dialog save system", false] call F90_fnc_debug;

// Number of loading slots (default = 9, ALPHA through INDIA).
TriggerSaveSystem_SaveSlots = 9;

// Next save slot to be used.
TriggerSaveSystem_NextSaveSlot = 1;

// Create empty slot array as reference for fn_createSaveSlot
AWSP_SaveSlots = [];

// Save game slots.
[] call F90_fnc_createSaveSlot;

PSave_AfterSaveEH pushBack { params ["_slot"]; [StartMenuList_SelectedList] call F90_fnc_updateSlotList; };

[Persistent_Debug, "initDialogSaveSystem", "Done initializing dialog save system", false] call F90_fnc_debug;