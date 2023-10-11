/*
    Applies hitpoint damages to given _entity, based on _hitpointsArray.
*/

params ["_entity", "_hitpointsArray"];

{
    private _key = _x;
    private _value = (_hitpointsArray # 2) # _forEachIndex;
    _entity setHitPointDamage [_key, _value];
} forEach (_hitpointsArray # 0);