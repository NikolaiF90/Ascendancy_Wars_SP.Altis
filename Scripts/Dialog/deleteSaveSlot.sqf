StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (StartMenuList_SelectedList == -1)then{StartMenuList_SelectedList = 0};

private _slot = StartMenuList_SelectedList;
["deleteSaveSlot", format["Deleting save slot", _slot]] call F90_fnc_debug;

private _newSlotName = format ["Empty Slot %1", _slot];
AWSP_SaveSlots set [_slot, _newSlotName];

profileNameSpace setVariable ["F90_AWSP_Savelist", AWSP_SaveSlots];
[_slot] call F90_fnc_clearSave;
[] call F90_fnc_updateSlotList;