["dialogSave", "Saving game"] call F90_fnc_debug;
private ["_slotText", "_saveTime"];

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (StartMenuList_SelectedList == -1)then{StartMenuList_SelectedList = 0};

private _slot = StartMenuList_SelectedList;
doneSaving = false;

_saveTime = [] call F90_fnc_generateSaveTime;
_slotText = format ["Slot %1: Saved on %2", _slot, _saveTime];
AWSP_SaveSlots set [_slot, _slotText];

profileNameSpace setVariable ["F90_AWSP_Savelist", AWSP_SaveSlots];
[_slot] call F90_fnc_saveGame;

waitUntil {doneSaving};
doneSaving = false;

[] call F90_fnc_updateSlotList;