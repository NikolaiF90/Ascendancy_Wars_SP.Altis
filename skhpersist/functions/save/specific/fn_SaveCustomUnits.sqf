/*
Stores data for marked units.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving custom units to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _SaveVehicleInfo =
{

};

private _units = [];

{
    _units pushBack ([_x, true] call skhpersist_fnc_GenerateUnitArray);
} forEach PSave_CustomUnitsToSave;

["units", _units, _slot] call skhpersist_fnc_SaveData;