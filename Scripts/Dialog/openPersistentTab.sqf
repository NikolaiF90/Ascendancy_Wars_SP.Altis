if(F90_Debug)then
{
	diag_log "[F90 openPersistentTab] Player opened PersistentTab";
};

createDialog "startMenu";

StartMenuList_SelectedList = [StartMenu_ListBox] call F90_fnc_getSelectedList;
if (isNil "StartMenuList_SelectedList")then{StartMenuList_SelectedList=0};
[StartMenuList_SelectedList, 1] call F90_fnc_updateSlotList;