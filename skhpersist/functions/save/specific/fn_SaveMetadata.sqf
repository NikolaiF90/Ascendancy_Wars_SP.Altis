/*
Stores metadata (information about the save itself).
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving metadata to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _metadataArray = [];

_metadataArray pushBack ["systemTime", systemTime];

["metadata", _metadataArray, _slot] call skhpersist_fnc_SaveData;