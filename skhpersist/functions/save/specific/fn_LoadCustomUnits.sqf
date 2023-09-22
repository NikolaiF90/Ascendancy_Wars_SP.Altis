/*
Restores data for units marked in editor.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading custom units from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _units = ["units", _slot] call skhpersist_fnc_LoadData;

{
    private _leader = leader group _x;

    {
        if (_x != _leader) then
        {
            deleteVehicle _x;
        };
    } forEach (units _leader);

    deleteVehicle _leader;
} forEach PSave_CustomUnitsToSave;

[PSave_CustomUnitsToSave] call skhpersist_fnc_ClearArray;

{
    private _unit = [nil, _x, nil] call skhpersist_fnc_LoadUnitData;
    [_unit] call skhpersist_fnc_AddCustomUnitToSave;
} forEach _units;