/*
	Save player infomations like MILCASH_PLAYER, RANK_PLAYER, and MILCASH_BLUFOR(for now blufor resources will be saved here)
*/

params ["_slot"];

["savePlayerInfo", format["Saving player informations to slot %1",_slot]] call F90_fnc_debug;

["RankPlayer", RANK_PLAYER, _slot] call F90_fnc_saveData;
["MilcashBlufor", MILCASH_BLUFOR, _slot] call F90_fnc_saveData;