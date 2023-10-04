/*
	Stores data for marked containers.
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveCustomContainers", format ["Saving custom containers to save slot %1.", _slot]] call F90_fnc_debug;

private _containers = [];

{
    private _container = _x;
    private _containerArray = [];
    
    _containerArray pushBack ["class", typeOf _container];
    _containerArray pushBack ["cargo", [_container] call F90_fnc_generateCargoData];
    _containerArray pushBack ["posRotation", [_container] call F90_fnc_generatePositioningData];
        
    _containers pushBack _containerArray;

} forEach PSave_CustomContainersToSave;

["containers", _containers, _slot] call F90_fnc_saveData;