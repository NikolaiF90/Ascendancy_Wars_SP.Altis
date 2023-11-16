/*
	Code Description: 
	This script spawns a group of units at a specified marker position. 
	It takes several parameters, including "_marker" for the marker object, "_side" for the side of the group, and "_unitCount" for the number of units in the group. 
	The script finds a safe position near the marker to spawn the group and creates a new group object. 
	It spawns a temporary group at the safe position and joins each unit to the spawned group. 
	If the "Revive_Enabled" variable is true, the script adds revive functionality to each unit. 
	The script sets the skill level for each unit based on the side of the group. 
	The units are stored in an array, and the leader of the group is determined. 
	The leader is then set to patrol the area around the marker. The script returns the spawned group object. 
	
	Syntax: 
	[parameters] call F90_fnc_spawnGroup 
	
	Parameters: 
	- _marker (Marker): The marker object representing the spawn position. 
	- _side (Side): The side of the group. 
	- _unitCount (Number): The number of units in the group. 
	
	Return: 
	- _spawnedGroup (Group): The group object representing the spawned group. 
*/

params ["_marker", "_side", "_unitCount"];

private _markerPos = markerPos _marker;
private _spawnPos = [_markerPos, 5, 20] call BIS_fnc_findSafePos;
private _spawnedGroup = createGroup _side;
private _groupSkill = 0;

private _groupArray = [];
private _unitList = [];
private _leader = nil;
private _money = nil;

switch (_side) do {
	case west: 
	{
		_unitList = AWSP_WestUnits;
		_money = ECONOMY_DefaultBLUFORMoney;
	};
	case east: 
	{
		_unitList = AWSP_EastUnits;
		_money = ECONOMY_DefaultOPFORMoney;
	};
	case independent: 
	{
		_unitList = AWSP_IndependentUnits;
		_money = ECONOMY_DefaultGUERMoney;
	};
};

for "_i" from 1 to _unitCount do 
{
	if (isNil {_leader}) then 
	{
		_leader = _spawnedGroup createUnit [_unitList # 0, _spawnPos, [], 0, "FORM"];
	} else
	{
		private _unit = _spawnedGroup createUnit [(_unitList # floor random (count _unitList)), _spawnPos, [], 0, "FORM"];
	};
};

switch (_side) do 
{
	case east: {_groupSkill = AWSP_OPFORSkill;};
	case independent: {_groupSkill = AWSP_GUERSkill;};
	case west : {_groupSkill = AWSP_BLUFORSkill;};
};

{
//	[_x] joinSilent _spawnedGroup;
	if (Revive_Enabled) then 
	{
		_x call F90_fnc_addRevive;
	};
	_x setSkill _groupSkill;
	_x setVariable ["Milcash", _money];
} forEach units _spawnedGroup;

[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;

_spawnedGroup;