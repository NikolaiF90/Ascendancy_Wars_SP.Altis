/*
	Function to spawn groups with x number of units where x should be provided
*/

params ["_pos", "_count", "_side"];


private _group = createGroup _side;
private _groupUnits = [];
private _returnData = [];
private _spawnPos = [_pos, 5, 20] call BIS_fnc_findSafePos;

private _spawnedGroup = [_spawnPos, _side, _count] call BIS_fnc_spawnGroup;

{
	[_x] joinSilent _group;
} forEach units _spawnedGroup;

{
	_groupUnits pushBack _x;
} forEach units _group;

_returnData = [_group, _groupUnits];
["spawnGroup", format["returnData = %1", _returnData]] call F90_fnc_debug;

_returnData;