/*
Applies hitpoint damages to given _entity, based on _hitpointsArray.
*/

params ["_entity", "_hitpointsArray"];

[format ["Applying damages to entity %1.", _entity]] call skhpersist_fnc_LogToRPT;

{
    private _key = _x;
    private _value = (_hitpointsArray # 2) # _forEachIndex;
    _entity setHitPointDamage [_key, _value];
} forEach (_hitpointsArray # 0);