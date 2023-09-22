/*
Restores player data.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading player data from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _unitData = ["player", _slot] call skhpersist_fnc_LoadData;
[player, _unitData, nil] call skhpersist_fnc_LoadUnitData;