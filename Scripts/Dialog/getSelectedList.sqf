/*
	getSelectedList by PrinceF90 v1.0

	A function to get what the player clicked from the list box provided

	[idc] call F90_fnc_getSelectedList;

	0	idc = idc of the listbox to get the data from 
*/

_listID = _this # 0;

_selected = lbCurSel _listID;

_selected ;