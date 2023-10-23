/*
	Restores player data.
	Data is loaded from given save _slot.
*/

params ["_slot"];

["loadPlayer", format ["Loading player data from save slot %1.", _slot]]call F90_fnc_debug;

private _unitData = ["player", _slot] call F90_fnc_loadData;
[player, _unitData, objNull] call F90_fnc_loadUnitData;