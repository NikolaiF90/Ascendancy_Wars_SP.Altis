/*
	Stores metadata (information about the save itself).
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveMetadata", format["Saving metadata (Information about the save itself) into slot %1",_slot]] call F90_fnc_debug;

private _metadataArray = [];

_metadataArray pushBack ["systemTime", systemTime];

["metadata", _metadataArray, _slot] call F90_fnc_saveData;