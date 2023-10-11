/*
	Applies position and rotation _array to given _entity.
*/

params ["_entity", "_array"];

private _posATL = _array # 0;
private _dir = _array # 1;

_entity setPosATL _posATL;
_entity setDir _dir;