/*
	Author: PrinceF90

	Description:
	Function to spawn a group of units and make them patrol an area specified by a marker. It checks if the unit count is zero and exits with an error message if so. It then initializes variables, selects the appropriate unit list and money based on the side parameter, and creates the units based on provided counts. The leader unit is created first then set to patrol the specified area. Additional units are randomly picked.

	Parameter(s):
	0: STRING - _marker: The marker used to define the patrol area.
	1: SIDE - _side: The side of the units to be spawned.
	2: NUMBER - _unitCount: The number of units to be spawned.

	Returns:
	GROUP - The group of units that has been spawned.

	Examples:
	// Spawn a group of 5 units from the west side and make them patrol the "PatrolMarker" area
	["PatrolMarker", west, 5] call F90_fnc_spawnAndPatrolGroup;
*/

params ["_marker", "_side", "_unitCount"];

if (_unitCount == 0) exitWith { [Garrison_Debug, "spawnGroup", "There is no unit in this group", false] call F90_fnc_debug };

private _markerPos = markerPos _marker;
private _spawnPos = [_markerPos, 5, 20] call BIS_fnc_findSafePos;
private _spawnedGroup = createGroup _side;

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
		_leader = [_side, _unitList # 0, _spawnPos, _spawnedGroup, _money, true] call F90_fnc_createUnit;
		[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;
	} else
	{
		[_side, (selectRandom _unitList), _spawnPos, _spawnedGroup, _money, true] call F90_fnc_createUnit;
	};
};

_spawnedGroup;