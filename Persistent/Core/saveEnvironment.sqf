/*
	Stores environment info, such as date, time, weather etc.
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveEnvironment", format ["Saving environment info to save slot %1.", _slot]] call F90_fnc_debug;

private _environment = [];

_environment pushBack ["date", date];
_environment pushBack ["rain", rain];
_environment pushBack ["fog", fog];
_environment pushBack ["overcast", overcast];

["environment", _environment, _slot] call F90_fnc_saveData;