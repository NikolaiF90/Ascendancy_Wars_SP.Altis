/*
Stores data for marked containers.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving custom containers to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _containers = [];

{
    private _container = _x;
    private _containerArray = [];
    
    _containerArray pushBack ["class", typeOf _container];
    _containerArray pushBack ["cargo", [_container] call skhpersist_fnc_GenerateCargoArray];
    _containerArray pushBack ["posRotation", [_container] call skhpersist_fnc_GeneratePositionAndRotationArray];
        
    _containers pushBack _containerArray;

} forEach PSave_CustomContainersToSave;

["containers", _containers, _slot] call skhpersist_fnc_SaveData;