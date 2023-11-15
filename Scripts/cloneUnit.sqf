/*
	Author: PrinceF90 
 
	Description: 
	Function to create a new unit based on an existing unit, transferring certain variables and attributes, and performing additional actions on the new unit. 
	
	Parameter(s): 
	0: OBJECT - _oldUnit: The existing unit that will be replaced. 
	
	Returns: 
	OBJECT - _newUnit: The newly created unit. 
	
	Examples: 
	// Example 1: Create a new unit to replace the existing unit "soldier1" at a specific position. 
	_soldier1 = player; 
	_newSoldier = [_soldier1] call F90_fnc_cloneUnit; 
	
	// Example 2: Replace an AI unit with a new unit at the current player's position. 
	_oldAI = nearestObject [player, "AI"]; 
	_newUnit = [_oldAI] call F90_fnc_cloneUnit;
*/
params ["_oldUnit"];

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

private _class = typeOf _oldUnit;
private _side = side _oldUnit;
private _newUnit = (createGroup _side) createUnit [_class, [0,0,0], [], 0, "FORM"];
_newUnit setVariable ["BIS_enableRandomization", false];

private _variables = [_oldUnit] call _GenerateVariablesArray;
[_newUnit, _variables] call _LoadVariables;

private _name = name _oldUnit;
_newUnit setName _name;
private _face = face _oldUnit;
_newUnit setFace _face;
private _speaker = speaker _oldUnit;
_newUnit setSpeaker _speaker;
private _pitch = pitch _oldUnit;
_newUnit setPitch _pitch;
private _assignedTeam = assignedTeam _oldUnit;
_newUnit assignTeam _assignedTeam;
private _milcash = _oldUnit getVariable "Milcash";
_newUnit setVariable ["Milcash", _milcash];

private _rating = rating _oldUnit;
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