/*
Creates a position / rotation array for given _entity.

Returns a generated position / rotation array.
*/

params ["_entity"];

[format ["Generating position and rotation array for entity %1.", _entity]] call skhpersist_fnc_LogToRPT;

[
    getPosATL _entity,
    getDir _entity
];