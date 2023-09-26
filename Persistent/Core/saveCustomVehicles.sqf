/*
	Stores data for marked vehicles.
	Data is saved to given save _slot.
*/

params ["_slot"];

private _GenerateTurretArray =
{
    params ["_vehicle"];

    private _turretsArray = [];

    {
        _turretsArray pushBack _x;
    } forEach (magazinesAllTurrets _vehicle);

    _turretsArray;
};  

["saveCustomVehicles", format ["Saving custom vehicles to save slot %1.", _slot]] call F90_fnc_debug;

private _vehicles = [];

{
    private _vehicle = _x;
    private _vehicleArray = [];
    
    _vehicleArray pushBack ["class", typeOf _vehicle];
    _vehicleArray pushBack ["fuel", fuel _vehicle];
    _vehicleArray pushBack ["generalDamage", damage _vehicle];
    _vehicleArray pushBack ["damages", getAllHitPointsDamage _vehicle];
    _vehicleArray pushBack ["cargo", [_vehicle] call F90_fnc_generateCargoData];
    _vehicleArray pushBack ["posRotation", [_vehicle] call F90_fnc_generatePositioningData];
    _vehicleArray pushBack ["turrets", [_vehicle] call _GenerateTurretArray];
    _vehicleArray pushBack ["materials", getObjectMaterials _vehicle];
    _vehicleArray pushBack ["textures", getObjectTextures _vehicle];
    _vehicleArray pushBack ["id", _vehicle getVariable "PSave_ID"];

    _vehicles pushBack _vehicleArray;

} forEach PSave_CustomVehiclesToSave;

["vehicles", _vehicles, _slot] call F90_fnc_saveData;