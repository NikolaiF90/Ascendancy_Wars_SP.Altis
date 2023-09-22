if(F90_Debug)then
{
	diag_log "[F90 startLoadGame] Loading previously saved game";
};

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (isNil "StartMenuList_SelectedList")exitWith{};

[StartMenuList_SelectedList] call skhpersist_fnc_LoadGame;