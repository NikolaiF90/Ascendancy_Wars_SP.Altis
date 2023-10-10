/*
	Function to spawn groups with x number of units where x should be provided
*/

params ["_marker", "_side", "_groupSize", "_skill"];

private ["_spawnSize"];
private _returnArray= [];
private _unitsInGroup = [];
private _markerPos = markerPos _marker;
private _spawnPos = [_markerPos, 5, 20] call BIS_fnc_findSafePos;
private _spawnedGroup = createGroup _side;

if (typeName _groupSize == "ARRAY") then 
{
	_spawnSize = floor random [1, _groupSize # 0, _groupSize # 1];
} else 
{
	_spawnSize = _groupSize;
};


private _tempGroup = [_spawnPos, _side, _spawnSize] call BIS_fnc_spawnGroup;

_groupSize = _spawnSize;
{
	[_x] joinSilent _spawnedGroup;
	_x call F90_fnc_addRevive;
} forEach units _tempGroup;

{
	_x setSkill _skill;	
	_unitsInGroup pushBack _x;
} forEach units _spawnedGroup;
private _leader = _unitsInGroup # 0;

[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;

_returnArray = [_spawnedGroup, _groupSize];
_returnArray;