/*
	Function to spawn random vehicle from provided array
*/

params ["_pools", "_pos", "_dir", "_side", "_count"];

private _typeIndex = floor (random count _pools);
private _spawnType = _pools # _typeIndex;
private _spawnPos = [_pos, 10, 50] call BIS_fnc_findSafePos;
private _groupUnits = [];
private _returnData = [];

private _group = createGroup _side;
private _vehicle = [_spawnPos, _dir, _spawnType, _side] call BIS_fnc_spawnVehicle;

private _spawnedVehicle = _vehicle # 0;
private _crew = _vehicle # 1;
private _spawnedGroup = _vehicle # 2;

{
	[_x] joinSilent _group;
} forEach units _spawnedGroup;

private _crewCount = count _crew;
private _cargoCount = _count - _crewCount;

private _cargoGroup = [_spawnPos, _cargoCount, _side] call F90_fnc_spawnGroup;
private _cargoUnits = _cargoGroup # 1;

{
	_x moveInCargo _spawnedVehicle;
	[_x] joinSilent _group;	
} forEach _cargoUnits;

{
	_groupUnits pushback _x;
} forEach units _group;

_returnData = [[_spawnedVehicle, _crew, _group], _groupUnits];
_returnData;