/*
	Author: PrinceF90 
 
	Description: 
	Function to create a new unit based on an existing unit, transferring certain variables and attributes, and performing additional actions on the new unit. 
	
	Parameter(s): 
	0: OBJECT - _oldUnit: The existing unit that will be replaced. 
	1: ARRAY - _spawnPos: The position where the new unit will be spawned. 
	
	Returns: 
	OBJECT - _newUnit: The newly created unit. 
	
	Examples: 
	// Example 1: Create a new unit to replace the existing unit "soldier1" at a specific position. 
	_soldier1 = player; 
	_spawnPos = getMarkerPos "spawnMarker"; 
	_newSoldier = [_soldier1, _spawnPos] call F90_fnc_cloneUnit; 
	
	// Example 2: Replace an AI unit with a new unit at the current player's position. 
	_oldAI = nearestObject [player, "AI"]; 
	_newUnit = [_oldAI, player] call F90_fnc_cloneUnit;
*/
params ["_oldUnit", "_spawnPos"];

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

private _LoadVariables =
{
    params ["_unit", "_variablesArray"];

    {
        _unit setVariable [_x, nil];
    } forEach (allVariables _unit);

    {
        private _key = _x # 0;
        private _value = _x # 1;

        if !(isNil "_value") then 
        {
            _unit setVariable [_key, _value];
        };
    } forEach _variablesArray;
};

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

private _class = typeOf _oldUnit;
private _side = side _oldUnit;
private _name = (name _oldUnit) splitString " ";
private _face = face _oldUnit;
private _speaker = speaker _oldUnit;
private _pitch = pitch _oldUnit;
private _rating = rating _oldUnit;
private _variables = [_oldUnit] call _GenerateVariablesArray;
private _assignedTeam = assignedTeam _oldUnit;
private _milcash = _oldUnit getVariable "Milcash";

private _newUnit = (createGroup _side) createUnit [_class, _spawnPos, [], 0, "FORM"];
_newUnit setVariable ["BIS_enableRandomization", false];
[_newUnit, _variables] call _LoadVariables;
[_newUnit, _name] call _RestoreUnitsName;

_newUnit setFace _face;
_newUnit setSpeaker _speaker;
_newUnit setPitch _pitch;
_newUnit assignTeam _assignedTeam;
_newUnit setVariable ["Milcash", _milcash];

if (rating _newUnit > _rating) then
{
    _newUnit addRating -(rating _newUnit - _rating);
}
else
{
    _newUnit addRating (_rating - rating _newUnit);
};

detach _newUnit;
_newUnit switchmove "";
_newUnit enablesimulation true;

if (_oldUnit == commanderX) then 
{
	commanderX = _newUnit;
	_newUnit addAction ["<t color='#2DC2DD'>Info Tab</t>", {params ["_target", "_caller", "_actionId", "_arguments"]; [_caller] call F90_fnc_openInfoTab;}, nil, 6, false, true, "", "true", -1, true];
};
_newUnit;