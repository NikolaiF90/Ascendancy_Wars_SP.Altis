/*
	Author: PrinceF90
 
	Description: 
	This function is used to create a unit (almost the same as default createUnit command). It performs various actions such as creating a unit, setting the money the unit hold, making the unit reviveable and setting the unit's skill level. 
	
	Parameters: 
	0: SIDE - The side/faction of the unit. 
	1: STRING - The classname of the unit. 
	2: ARRAY - The position where the unit will be created. 
	3: GROUP - The group to which the unit will be joined. 
	4: NUMBER - (Optional) The amount of money to assign to the unit. If not provided, it defaults to a predefined value. 
	
	Returns: 
	UNIT - The created unit. 
*/
// EXAMPLE : [west, "B_Soldier_F", position player, _group, 5000] call F90_fnc_createUnit;

params ["_side", "_type", "_position", "_group", "_money"];

if (isNil {_side}) exitWith {[AWSP_Debug, "createUnit", "F90_fnc_createUnit doesn't accept empty parameters.", true] call F90_fnc_debug};
if !(typeName _side == "SIDE") exitWith {[AWSP_Debug, "createUnit", "Error type name _side. Expected typename = 'SIDE'.", true] call F90_fnc_debug};
if (isNil {_type}) exitWith {[AWSP_Debug, "createUnit", "You need to include the unit classname when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _type == "STRING") exitWith {[AWSP_Debug, "createUnit", "Error type name _type. Expected typename = 'STRING(CLASSNAME)'.", true] call F90_fnc_debug};
if (isNil {_position}) exitWith {[AWSP_Debug, "createUnit", "You need to include the unit position when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _position == "ARRAY") exitWith {[AWSP_Debug, "createUnit", "Error type name _position. Expected typename = 'ARRAY(POSITION_3D)'.", true] call F90_fnc_debug};
if (isNil {_group}) exitWith {[AWSP_Debug, "createUnit", "You need to include a group for the unit when executing F90_fnc_createUnit", true] call F90_fnc_debug};
if !(typeName _group == "GROUP") exitWith {[AWSP_Debug, "createUnit", "Error type name _group. Expected typename = 'GROUP'.", true] call F90_fnc_debug};

if (isNil {_money}) then {_money = ECONOMY_DefaultCIVMoney} else {_money = _money};

private _defaultGroup = createGroup [_side,true];
private _unit = _defaultGroup createUnit [_type, _position, [], 0, "FORM"];

[_unit] join _group;

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
[AWSP_Debug, "createUnit", format ["Created unit %1 at %2", _unit, _position], false] call F90_fnc_debug;

_unit;