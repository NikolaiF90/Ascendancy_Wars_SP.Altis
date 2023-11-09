/*
	Restores player informations like milcash and rank.
	Data is loaded from given save _slot.
*/

params ["_slot"];

["loadPlayerInfo", format["Loading player informations from slot %1",_slot]] call F90_fnc_debug;

if (!isNil "RANK_PLAYER") then 
{
	private _tempRankPlayer = [["RankPlayer", "PRIVATE"], _slot] call F90_fnc_loadData;
	RANK_PLAYER = _tempRankPlayer;
};

if (!isNil "MILCASH_BLUFOR") then 
{
	private _tempMilcashBlufor = [["MilcashBlufor", 10000], _slot] call F90_fnc_loadData;
	MILCASH_BLUFOR = _tempMilcashBlufor;
};

["loadPlayerInfo", "Done loading player informations from file."] call F90_fnc_debug;
