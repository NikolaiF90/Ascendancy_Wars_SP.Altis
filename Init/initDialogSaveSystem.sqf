if(F90_Debug)then
{
	diag_log "[F90 initDialogSaveSystem] Initializing dialog save system...";
};

// Number of loading slots (default = 9, ALPHA through INDIA).
TriggerSaveSystem_SaveSlots = 9;

// Next save slot to be used.
TriggerSaveSystem_NextSaveSlot = 1;

// Create empty slot array as reference for fn_createSaveSlot
AWSP_SaveSlots = [];
//[] call skhpersist_fnc_UpdateRadioTriggers;

// Save game slots.
[] call F90_fnc_createSaveSlot;

PSave_AfterSaveEH pushBack { params ["_slot"]; [StartMenuList_SelectedList,2] call F90_fnc_updateSlotList; };

if(F90_Debug)then
{
	diag_log "[F90 initDialogSaveSystem] Done initializing dialog save system";
};