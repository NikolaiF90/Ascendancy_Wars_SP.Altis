/*
Stores player data.
*/

params ["_slot"];

[format ["Saving player data to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _playerArray = [player, true] call skhpersist_fnc_GenerateUnitArray;
["player", _playerArray, _slot] call skhpersist_fnc_SaveData;