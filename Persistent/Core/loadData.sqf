/*
Retrieves a value for given _key from profileNamespace for save on given _slot.

Returns value of given _key on given save _slot.
*/
params ["_key", "_slot"];

["loadData", format ["Loading data for key %1 on save slot %2.", _key, _slot]] call F90_fnc_debug;

private _keyToFind = format ["%1.%2.%3", PSave_SaveGamePrefix, _slot, _key];
profileNamespace getVariable _keyToFind;