["openPersistentTab", "Player opened PersistentTab"] call F90_fnc_debug;

waitUntil {time > 0};
createDialog "persistentMenu";

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (StartMenuList_SelectedList == -1)then{StartMenuList_SelectedList = 0};
[] call F90_fnc_updateSlotList;
[] call F90_fnc_updatePlayerInfo;