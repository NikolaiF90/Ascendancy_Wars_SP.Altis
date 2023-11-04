/*
	Creates an array of given unit's data.
	If the unit _isLeader, then his group will also be added to a resulting array.

	Returns a generated data array.
*/
params ["_unit", "_isLeader"];

["generateUnitData", format["Generating data for %1 (isLeader = %2)", _unit, _isLeader]] call F90_fnc_debug;

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

private _unitData = [];

_unitData pushBack ["class", typeOf _unit];
_unitData pushBack ["generalDamage", damage _unit];
_unitData pushBack ["damages", getAllHitPointsDamage _unit];
_unitData pushBack ["posRotation", [_unit] call F90_fnc_generatePositioningData];
_unitData pushBack ["loadout", getUnitLoadout _unit];
_unitData pushBack ["side", side _unit];
_unitData pushBack ["skills", [_unit] call _GenerateSkillsArray];
_unitData pushBack ["name", (name _unit) splitString " "];
_unitData pushBack ["face", face _unit];
_unitData pushBack ["speaker", speaker _unit];
_unitData pushBack ["pitch", pitch _unit];
_unitData pushBack ["rating", rating _unit];
_unitData pushBack ["stamina", getStamina _unit];
_unitData pushBack ["fatigue", getFatigue _unit];
_unitData pushBack ["formationDir", formationDirection _unit];
_unitData pushBack ["variables", [_unit] call _GenerateVariablesArray];
_unitData pushBack ["orders", [_unit] call _GenerateOrdersArray];
_unitData pushBack ["assignedTeam", assignedTeam _unit];
_unitData pushBack ["milcash", _unit getVariable "Milcash"];

//	If unit is on vehicle
if (vehicle _unit != _unit) then
{
    private _vehicle = vehicle _unit;
    private _vehicleData = [];
    private _roleData = [];
    private _vehicleCrew = fullCrew vehicle _unit;
    {
        private _selectedUnit = _x # 0;
        if (_unit == _selectedUnit) exitWith
        {
            private _role = _x # 1;
            private _cargoIndex = _x # 2;
            private _turretPath = _x # 3;
            private _personTurret = _x # 4;
            _roleData = [_role, _cargoIndex, _turretPath, _personTurret];
            ["generateUnitData", format ["Role data for %1 generated : %2", _unit, _roleData]] call F90_fnc_debug;
        };
    } forEach _vehicleCrew;
    _vehicleData pushBack ["id", [_vehicle] call F90_fnc_addVehiclesToSave];
    _vehicleData pushBack ["role", _roleData];

    _unitData pushBack ["vehicle", _vehicleData];
};

if (_isLeader) then
{
    _unitData pushBack ["group", [_unit] call F90_fnc_generateGroupData];
    _unitData pushBack ["groupOrders", [_unit] call _GenerateGroupOrdersArray];
};
_unitData;