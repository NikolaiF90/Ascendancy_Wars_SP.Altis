/*
Stores environment info, such as date, time, weather etc.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving environment info to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _environment = [];

_environment pushBack ["date", date];
_environment pushBack ["rain", rain];
_environment pushBack ["fog", fog];
_environment pushBack ["overcast", overcast];

["environment", _environment, _slot] call skhpersist_fnc_SaveData;