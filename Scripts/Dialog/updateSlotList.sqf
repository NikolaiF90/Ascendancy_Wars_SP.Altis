/*
	updateList by PrinceF90 v1.0
	a script to update a list based on given parameters 
	
	[] call F90_fnc_updateList;

	0	idc 	= idc of the list box to be updated;
*/

private _listID = StartMenu_ListBox;
lbClear _listID;

private _slotArray = profileNameSpace getVariable "F90_AWSP_Savelist";
if (isNil "_slotArray") then 
{
	AWSP_SaveSlots = AWSP_SaveSlots;
} else 
{
	AWSP_SaveSlots = _slotArray;
};

{
	lbAdd [_listID, _x];
} forEach AWSP_SaveSlots;