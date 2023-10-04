/*
Loads and applies given _unitData to _unit and assigns it to given _leader (if specified).
*/

params ["_unit", "_unitData", "_leader"];

private _CreateUnitIfDoesntExist =
{
    params ["_unit", "_class", "_side"];
    
    if (isNil { _unit }) then
    {
        _unit = (createGroup _side) createUnit [_class, [0, 0, 0], [], 0, "FORM"];
    };
    
    _unit;
};

private _RemoveOtherUnitsFromGroup =
{
    params ["_unit"];
    
    {
        if (_unit != _x) then
        {
            deleteVehicle _x;
        };
    } forEach (units _unit);
};

private _JoinUnitToLeaderIfSpecified =
{
    params ["_unit", "_leader"];
    
    if (!isNil "_leader") then
    {
        [_unit] joinSilent _leader;
    };
};

private _LoadUnitsInGroup =
{
    params ["_leader", "_group"];
    
    {
       [_x, _leader] call F90_fnc_loadUnitsInGroup;
    } forEach _group;
};

private _LoadOrders =
{
    params ["_unit", "_ordersArray"];

    private _behaviour = [_ordersArray, "behaviour"] call skhpersist_fnc_GetByKey;
    private _unitPos = [_ordersArray, "unitPos"] call skhpersist_fnc_GetByKey;

    _unit setBehaviour _behaviour;
    _unit setUnitPos _unitPos;
};

private _LoadGroupOrders =
{
    params ["_unit", "_groupOrdersArray"];

    private _group = group _unit;

    if (leader _group == _unit) then 
    {
        private _combatMode = [_groupOrdersArray, "combatMode"] call skhpersist_fnc_GetByKey;
        private _formation = [_groupOrdersArray, "formation"] call skhpersist_fnc_GetByKey;
        private _speedMode = [_groupOrdersArray, "speedMode"] call skhpersist_fnc_GetByKey;

        _group setCombatMode _combatMode;
        _group setFormation _formation;
        _group setSpeedMode _speedMode;
    };
};

private _AddUnitToAssignedVehicleIfNecessary =
{
    params ["_unit", "_vehicleArray"];

    if (isNil { _vehicleArray }) exitWith { 0 };

    private _FindAssignedVehicleInArray =
    {
        params ["_id"];
        private _instance = objNull;

        {
            if (_x getVariable "PSave_UnitAssignmentID" == _id) exitWith { _instance = _x };
        } forEach PSave_CustomVehiclesToSave;

        _instance;
    };

    private _vehicleAssignmentId = [_vehicleArray, "id"] call skhpersist_fnc_GetByKey;
    private _roleArray = [_vehicleArray, "role"] call skhpersist_fnc_GetByKey;

    private _vehicleInstance = [_vehicleAssignmentId] call _FindAssignedVehicleInArray;
         
    if (!isNull _vehicleInstance && (_roleArray != "")) then
    {
        private _role = _roleArray # 0;

        switch (_role) do
        {
            case "driver":
            {
                _unit moveInDriver _vehicleInstance;
            };
            case "gunner":
            {
                _unit moveInGunner _vehicleInstance;
            };
            case "cargo":
            {
                private _cargoIndex = _roleArray # 1;
                _unit moveInCargo [_vehicleInstance, _cargoIndex];
            };
            case "commander":
            {
                _unit moveInCommander _vehicleInstance;
            };
            case "turret":
            {
                private _turretPath = _roleArray # 2;
                _unit moveInTurret [_vehicleInstance, _turretPath];
            };
        };
    };
};

private _LoadVariables =
{
    params ["_unit", "_variablesArray"];

    {
        _unit setVariable [_x, nil];
    } forEach (allVariables _unit);

    {
        private _key = _x # 0;
        private _value = _x # 1;

        if(isNil "_value") then 
        {
            _unit setVariable [_key, nil];
        }else
        {
            _unit setVariable [_key, _value];
        };
    } forEach _variablesArray;
};

private _LoadSkills =
{
    params ["_unit", "_skillsArray"];

    {
        _unit setSkill [_x # 0, _x # 1];
    } forEach _skillsArray;
};

[format ["Loading unit data for unit %1.", _unit]] call skhpersist_fnc_LogToRPT;

private _class = [_unitData, "class"] call skhpersist_fnc_GetByKey;
private _side = [_unitData, "side"] call skhpersist_fnc_GetByKey;
private _group = [_unitData, "group"] call skhpersist_fnc_GetByKey;
private _orders = [_unitData, "orders"] call skhpersist_fnc_GetByKey;
private _groupOrders = [_unitData, "groupOrders"] call skhpersist_fnc_GetByKey;
private _generalDamage = [_unitData, "generalDamage"] call skhpersist_fnc_GetByKey;
private _damages = [_unitData, "damages"] call skhpersist_fnc_GetByKey;
private _posRotation = [_unitData, "posRotation"] call skhpersist_fnc_GetByKey;
private _skills = [_unitData, "skills"] call skhpersist_fnc_GetByKey;
private _name = [_unitData, "name"] call skhpersist_fnc_GetByKey;
private _face = [_unitData, "face"] call skhpersist_fnc_GetByKey;
private _speaker = [_unitData, "speaker"] call skhpersist_fnc_GetByKey;
private _pitch = [_unitData, "pitch"] call skhpersist_fnc_GetByKey;
private _rating = [_unitData, "rating"] call skhpersist_fnc_GetByKey;
private _stamina = [_unitData, "stamina"] call skhpersist_fnc_GetByKey;
private _fatigue = [_unitData, "fatigue"] call skhpersist_fnc_GetByKey;
private _formationDir = [_unitData, "formationDir"] call skhpersist_fnc_GetByKey;
private _variables = [_unitData, "variables"] call skhpersist_fnc_GetByKey;
private _vehicle = [_unitData, "vehicle"] call skhpersist_fnc_GetByKey;
private _assignedTeam = [_unitData, "assignedTeam"] call skhpersist_fnc_GetByKey;
        
_unit = [_unit, _class, _side] call _CreateUnitIfDoesntExist;
_unit setVariable ["BIS_enableRandomization", false];

[_unit] call _RemoveOtherUnitsFromGroup;
[_unit, _leader] call _JoinUnitToLeaderIfSpecified;
[_unit, _group] call _LoadUnitsInGroup;
[_unit, _orders] call _LoadOrders;
[_unit, _groupOrders] call _LoadGroupOrders;
[_unit, _variables] call _LoadVariables;
[_unit, _skills] call _LoadSkills;

_unit setDamage _generalDamage;
[_unit, _damages] call skhpersist_fnc_ApplyDamages;
[_unit, _posRotation] call skhpersist_fnc_ApplyPositionAndRotation;

_unit setFatigue _fatigue;
_unit setFormDir _formationDir;
_unit setStamina _stamina;
_unit assignTeam _assignedTeam;

if (rating _unit > _rating) then
{
    _unit addRating -(rating _unit - _rating);
}
else
{
    _unit addRating (_rating - rating _unit);
};

[_unit, _vehicle] spawn _AddUnitToAssignedVehicleIfNecessary;

[_unit, _unitData] spawn {
    params ["_unit", "_unitData"];

    private _RestoreUnitsName =
    {
        params ["_unit", "_nameArray"];
        
        private _firstName = "";
        private _surname = "";
        private _joinedNames = "";
        
        if (count _nameArray == 1) then
        {
            _surname = _nameArray # 0;
            _joinedNames = _surname;
        }
        else
        {
            _firstName = _nameArray # 0;
            _surname = _nameArray # 1;
            _joinedNames = format ["%1 %2", _firstName, _surname];
        };
        
        _unit setName [_joinedNames, _firstName, _surname];
    };
    
    private _name = [_unitData, "name"] call skhpersist_fnc_GetByKey;
    private _face = [_unitData, "face"] call skhpersist_fnc_GetByKey;
    private _speaker = [_unitData, "speaker"] call skhpersist_fnc_GetByKey;
    private _pitch = [_unitData, "pitch"] call skhpersist_fnc_GetByKey;
    private _loadout = [_unitData, "loadout"] call skhpersist_fnc_GetByKey;
    
    [_unit, _name] call _RestoreUnitsName;
    
    _unit setFace _face;
    _unit setSpeaker _speaker;
    _unit setPitch _pitch;
    _unit setUnitLoadout _loadout; // goggles weren't restored correctly when outside spawn
};

_unit;