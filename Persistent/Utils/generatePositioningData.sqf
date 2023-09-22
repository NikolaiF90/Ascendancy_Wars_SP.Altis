/*
	Creates a position / rotation array for given _entity.

	Returns a generated position / rotation array.
*/

params ["_entity"];

["generatePositioningData", format ["Generating position and rotation array for entity %1.", _entity]] call F90_fnc_debug;

[
    getPosATL _entity,
    getDir _entity
];