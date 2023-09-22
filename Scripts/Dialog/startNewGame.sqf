["startNewGame", "Starting a new game"] call F90_fnc_debug;

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (isNil "StartMenuList_SelectedList")then{StartMenuList_SelectedList=0};

doneSaving = false;
[] call F90_fnc_generateSaveTime;
[StartMenuList_SelectedList] call F90_fnc_saveGame;

waitUntil {doneSaving};
doneSaving = false;
[StartMenuList_SelectedList, 2] call F90_fnc_updateSlotList;