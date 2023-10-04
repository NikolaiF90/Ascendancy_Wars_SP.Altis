["dialogLoad", "Loading previously saved game"] call F90_fnc_debug;
F90_MissionStarted = true;

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if(StartMenuList_SelectedList == -1) then {StartMenuList_SelectedList = 0}; 

[StartMenuList_SelectedList] call F90_fnc_loadGame;