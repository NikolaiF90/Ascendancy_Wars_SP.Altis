/*
Restores data of vehicles marked by player.
Data is loaded from given save _slot.
*/

params ["_slot"];

private _ClearTurretMagazines =
{
    params ["_vehicle"];

    {
        private _turretPath = _x;

        {
            _vehicle removeMagazinesTurret [_x, _turretPath];
        } forEach (_vehicle magazinesTurret  _turretPath)
    } forEach (allTurrets _vehicle);
};

private _ApplyTurrets =
{ 
    params ["_vehicle", "_turretArray"];

    [_vehicle] call _ClearTurretMagazines;

    {
        private _class = _x # 0;
        private _turretPath = _x # 1;
        private _ammo = _x # 2;

        _vehicle addMagazineTurret [_class, _turretPath, _ammo];
    } forEach _turretArray;
};

private _ApplyMaterials =
{ 
    params ["_vehicle", "_materialsArray"];

    {
        _vehicle setObjectMaterial [_forEachIndex, _x];
    } forEach _materialsArray;
};

private _ApplyTextures =
{ 
    params ["_vehicle", "_texturesArray"];

    {
        _vehicle setObjectTexture [_forEachIndex, _x];
    } forEach _texturesArray;
};

[format ["Loading custom vehicles from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _vehicles = ["vehicles", _slot] call skhpersist_fnc_LoadData;

{
    deleteVehicle _x;
} forEach PSave_CustomVehiclesToSave;

[PSave_CustomVehiclesToSave] call skhpersist_fnc_ClearArray;

{
    private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
    private _fuel = [_x, "fuel"] call skhpersist_fnc_GetByKey;
    private _generalDamage = [_x, "generalDamage"] call skhpersist_fnc_GetByKey;
    private _damages = [_x, "damages"] call skhpersist_fnc_GetByKey;
    private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;
    private _posRotation = [_x, "posRotation"] call skhpersist_fnc_GetByKey;
    private _turretArray = [_x, "turrets"] call skhpersist_fnc_GetByKey;
    private _materialsArray = [_x, "materials"] call skhpersist_fnc_GetByKey;
    private _texturesArray = [_x, "textures"] call skhpersist_fnc_GetByKey;
    private _id = [_x, "id"] call skhpersist_fnc_GetByKey;
    
    private _vehicle = _class createVehicle [0, 0, 0];
    [_vehicle, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;
    _vehicle setFuel _fuel;
    _vehicle setDamage _generalDamage;
    [_vehicle, _damages] call skhpersist_fnc_ApplyDamages;
    [_vehicle, _cargo] call skhpersist_fnc_ApplyCargo;
    [_vehicle, _turretArray] call _ApplyTurrets;
    [_vehicle, _materialsArray] call _ApplyMaterials;
    [_vehicle, _texturesArray] call _ApplyTextures;
    _vehicle setVariable ["PSave_ID", PSave_NextVehicleId];
    PSave_NextVehicleId = PSave_NextVehicleId + 1;
    _vehicle setVariable ["PSave_UnitAssignmentID", _id];
    
    [_vehicle, PSave_CustomVehiclesToSave] call skhpersist_fnc_MarkForSave;
} forEach _vehicles;