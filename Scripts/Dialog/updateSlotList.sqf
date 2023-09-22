/*
	updateList by PrinceF90 v1.0
	a script to update a list based on given parameters 
	
	[] call F90_fnc_updateList;

	0	idc 	= idc of the list box to be updated;
*/

params ["_slot","_type"];

private _listID = StartMenu_ListBox;
lbClear _listID;

private _slotArray = profileNameSpace getVariable ["F90_AWSP_Savelist",AWSP_SaveSlots];

switch (_type) do 
{
	case 1:	// init  
	{
		{
			lbAdd [_listID, _x];
		} forEach _slotArray;
	};
	case 2: // loading or saving
	{
		private _slotName = format ["Slot %1: Saved on %2", _slot, AWSP_SaveTime];
		AWSP_SaveSlots set [_slot, _slotName];
		profileNameSpace setVariable ["F90_AWSP_Savelist", AWSP_SaveSlots];
		{
			lbAdd [_listID, _x];
		} forEach _slotArray;
	};
};