/*
	Stores data for marked units.
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveCustomUnits",format ["Saving custom units to save slot %1.", _slot]] call F90_fnc_debug;

private _units = [];

{
    _units pushBack ([_x, true] call F90_fnc_generateUnitData);
} forEach PSave_CustomUnitsToSave;

["units", _units, _slot] call F90_fnc_saveData;