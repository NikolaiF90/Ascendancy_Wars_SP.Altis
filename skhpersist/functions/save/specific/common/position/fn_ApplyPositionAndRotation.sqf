/*
Applies position and rotation _array to given _entity.
*/

params ["_entity", "_array"];

[format ["Applying position and rotation to entity %1.", _entity]] call skhpersist_fnc_LogToRPT;

private _posATL = _array # 0;
private _dir = _array # 1;

_entity setPosATL _posATL;
_entity setDir _dir;