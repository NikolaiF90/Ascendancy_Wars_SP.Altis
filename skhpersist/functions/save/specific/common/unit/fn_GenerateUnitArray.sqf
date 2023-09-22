/*
Creates a data array for given _unit.
If the unit _isLeader, then his group will also be added to a resulting array.

Returns a generated data array.
*/

params ["_unit", "_isLeader"];

private _GenerateOrdersArray =
{
    params ["_unit"];

    private _ordersArray = [];

    _ordersArray pushBack ["behaviour", behaviour _unit];
    _ordersArray pushBack ["unitPos", unitPos _unit];

    _ordersArray;
};

private _GenerateGroupOrdersArray =
{
    params ["_leader"];

    private _group = group _leader;

    private _groupOrdersArray = [];

    _groupOrdersArray pushBack ["combatMode", combatMode _group];
    _groupOrdersArray pushBack ["formation", formation _group];
    _groupOrdersArray pushBack ["speedMode", speedMode _group];

    _groupOrdersArray;
};

private _GenerateVehicleArray =
{
    params ["_unit"];

    private _GenerateVehicleRoleArray =
    {
        params ["_unit", "_vehicle"];

        private _vehicleRoleArray = [];

        {
            private _unitInVehicle = _x # 0;

            if (_unit == _unitInVehicle) exitWith
            {
                _vehicleRoleArray = [_x # 1, _x # 2, _x # 3, _x # 4];
            };
        } forEach (fullCrew _vehicle);

        _vehicleRoleArray;
    };

    private _vehicleArray = [];

    _vehicleArray pushBack ["id", [vehicle _unit] call skhpersist_fnc_AddCustomVehicleToSave];
    _vehicleArray pushBack ["role", [_unit, vehicle _unit] call _GenerateVehicleRoleArray];

    _vehicleArray;
};

private _GenerateVariablesArray =
{
    params ["_unit"];

    private _variablesArray = [];

    {
        private _splittedKey = _x splitString '_';

        if (_splittedKey # 0 != 'cba') then
        {
            _variablesArray pushBack [_x, _unit getVariable _x];
        };
    } forEach (allVariables _unit);

    _variablesArray;
};

private _GenerateSkillsArray =
{
    params ["_unit"];

    private _skillsArray = [];

    {
        _skillsArray pushBack [_x, _unit skill _x];
    } forEach [
        "aimingAccuracy",
        "aimingShake",
        "aimingSpeed",
        "commanding",
        "courage",
        "general",
        "reloadSpeed",
        "spotDistance",
        "spotTime"
    ];

    _skillsArray;
};

[format ["Generating unit array for unit %1 (leader: %2).", _unit, _isLeader]] call skhpersist_fnc_LogToRPT;

private _unitArray = [];

_unitArray pushBack ["class", typeOf _unit];
_unitArray pushBack ["generalDamage", damage _unit];
_unitArray pushBack ["damages", getAllHitPointsDamage _unit];
_unitArray pushBack ["posRotation", [_unit] call skhpersist_fnc_GeneratePositionAndRotationArray];
_unitArray pushBack ["loadout", getUnitLoadout _unit];
_unitArray pushBack ["side", side _unit];
_unitArray pushBack ["skills", [_unit] call _GenerateSkillsArray];
_unitArray pushBack ["name", (name _unit) splitString " "];
_unitArray pushBack ["face", face _unit];
_unitArray pushBack ["speaker", speaker _unit];
_unitArray pushBack ["pitch", pitch _unit];
_unitArray pushBack ["rating", rating _unit];
_unitArray pushBack ["stamina", getStamina _unit];
_unitArray pushBack ["fatigue", getFatigue _unit];
_unitArray pushBack ["formationDir", formationDirection _unit];
_unitArray pushBack ["variables", [_unit] call _GenerateVariablesArray];
_unitArray pushBack ["orders", [_unit] call _GenerateOrdersArray];
_unitArray pushBack ["assignedTeam", assignedTeam _unit];

if (vehicle _unit != _unit) then
{
    _unitArray pushBack ["vehicle", [_unit] call _GenerateVehicleArray];
};

if (_isLeader) then
{
    _unitArray pushBack ["group", [_unit] call skhpersist_fnc_GenerateGroupArray];
    _unitArray pushBack ["groupOrders", [_unit] call _GenerateGroupOrdersArray];
};

_unitArray;