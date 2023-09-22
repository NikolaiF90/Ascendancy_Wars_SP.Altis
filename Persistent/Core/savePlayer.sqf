/*
	Stores player data.
*/

params ["_slot"];

["savePlayer", format["Saving player data to slot %1",_slot]] call F90_fnc_debug;

private _playerData = [player, true] call F90_fnc_generateUnitData;
diag_log format["SIDE = %1", _playerData # 5];
["player", _playerData, _slot] call F90_fnc_saveData;