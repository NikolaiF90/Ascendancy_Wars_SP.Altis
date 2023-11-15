/*
	Author: PrinceF90 
 
	Description: 
	Function to populates a list box (_listID) with save slots retrieved from a profile namespace variable (_slotArray). If the _slotArray variable is not defined, it uses the default save slots (AWSP_SaveSlots). 
	
	Parameter(s): 
	0: SCALAR - _listID: The idc of the list box to populate with save slots. 
	
	Returns: 
	None 
	
	Examples: 
	// Example 1: 
	["exampleListBox"] call F90_fnc_updateSlotList; 
	
	// Example 2: 
	["anotherListBox"] call F90_fnc_updateSlotList;
*/
params ["_listID"];

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