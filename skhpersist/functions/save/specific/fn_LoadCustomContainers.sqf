/*
Restores data for containers marked in editor.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading custom containers from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _containers = ["containers", _slot] call skhpersist_fnc_LoadData;

{
    deleteVehicle _x;
} forEach PSave_CustomContainersToSave;

[PSave_CustomContainersToSave] call skhpersist_fnc_ClearArray;

{
    private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
    private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;
    private _posRotation = [_x, "posRotation"] call skhpersist_fnc_GetByKey;
    
    private _container = _class createVehicle [0, 0, 0];
    [_container, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;
    [_container, _cargo] call skhpersist_fnc_ApplyCargo;
    
    [_container, PSave_CustomContainersToSave] call skhpersist_fnc_MarkForSave;
} forEach _containers;