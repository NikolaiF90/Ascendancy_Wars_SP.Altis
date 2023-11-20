/*
	Author: PrinceF90 
 
	Description: 
	This function is used to create a unit and add it to a specified group. It performs various checks on the input parameters to ensure they are valid. It sets the unit's group, skill, revive capability, and money. It then returns the created unit. 
	
	Parameter(s): 
	0: SIDE - _side: The side of the unit to be created. 
	1: STRING - _type: The classname of the unit to be created. 
	2: ARRAY - _position: The position where the unit will be placed. 
	3: GROUP - _group: The group that the unit will be added to. 
	4: SCALAR - (optional) _money: The amount of money the unit will have. Default is ECONOMY_DefaultCIVMoney. 
	5: BOOL - (optional) _isSilent: Determines if the unit joining the group will be done silently. Default is false. 
	
	Returns: 
	OBJECT - The created unit. 
	
	Examples: 
	// Create a unit of side "west", with classname "B_Soldier_F", positioned at [0,0,0], and add it to the group "MyGroup" 
	[west, "B_Soldier_F", [0,0,0], _myGroup] call F90_fnc_createUnit;
*/


params ["_side", "_type", "_position", "_group", "_money", "_isSilent"];

if (isNil {_side}) exitWith {[AWSP_Debug, "createUnit", "F90_fnc_createUnit doesn't accept empty parameters.", true] call F90_fnc_debug};
if !(typeName _side == "SIDE") exitWith {[AWSP_Debug, "createUnit", "Error type name _side. Expected typename = 'SIDE'.", true] call F90_fnc_debug};
if (isNil {_type}) exitWith {[AWSP_Debug, "createUnit", "You need to include the unit classname when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _type == "STRING") exitWith {[AWSP_Debug, "createUnit", "Error type name _type. Expected typename = 'STRING(CLASSNAME)'.", true] call F90_fnc_debug};
if (isNil {_position}) exitWith {[AWSP_Debug, "createUnit", "You need to include the unit position when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _position == "ARRAY") exitWith {[AWSP_Debug, "createUnit", "Error type name _position. Expected typename = 'ARRAY(POSITION_3D)'.", true] call F90_fnc_debug};
if (isNil {_group}) exitWith {[AWSP_Debug, "createUnit", "You need to include a group for the unit when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _group == "GROUP") exitWith {[AWSP_Debug, "createUnit", "Error type name _group. Expected typename = 'GROUP'.", true] call F90_fnc_debug};

if (isNil {_money}) then {_money = ECONOMY_DefaultCIVMoney} else {_money = _money};
if (isNil {_isSilent}) then {_isSilent = false} else {_isSilent = _isSilent};

private _defaultGroup = createGroup [_side,true];
private _unit = _defaultGroup createUnit [_type, _position, [], 0, "FORM"];

if (_isSilent) then 
{
	[_unit] joinSilent _group;
} else 
{
	[_unit] join _group;
};

if (Revive_Enabled) then
{
	_unit call F90_fnc_addRevive;
};
_unit setVariable ["Milcash", _money];

private _unitSkill = switch (_side) do 
{
	case east: { AWSP_OPFORSkill };
	case independent: { AWSP_GUERSkill };
	case west : { AWSP_BLUFORSkill };
};
_unit setSkill _unitSkill;

_unit setVariable ["IsScriptSpawned", true];
[AWSP_Debug, "createUnit", format ["Created unit %1 at %2", _unit, _position], false] call F90_fnc_debug;

_unit;