/*
	Author: PrinceF90 
 
	Description: 
	This script is used to recruit a soldier in a game scenario. It checks if the player has enough money to recruit the soldier and spawns the recruit at a safe position if the conditions are met. If the player does not have enough money or has not selected a soldier to recruit, appropriate hints are displayed. 
	
	Parameter(s): 
	0: ARRAY - An array containing information about the soldier to be recruited. 
	1: OBJECT - The player's unit. 
	
	Returns: 
	None

	Examples:
	[["Soldier1","B_Soldier_F",1000],player] call F90_fnc_spawnRecruit;
*/
params ["_recruit", "_unit"];

private _defaultMoney = ECONOMY_DefaultGUERMoney;

if (count _recruit == 1) then 
{
	private _soldier = _recruit # 0;
	private _class = _soldier # 1;
	private _price = _soldier # 2;
	private _money = ["GETMONEY", _unit] call F90_fnc_economyHandler;

	if (_money >= _price) then 
	{
		["DEDUCTMONEY", [_unit, _price]] call F90_fnc_economyHandler;
		//	Spawn recruit
		private _pos = [player, 1, 25] call BIS_fnc_findSafePos;
		private _group = group player;
		private _soldier = [independent, _class, _pos, _group, _defaultMoney] call F90_fnc_createUnit;
	} else 
	{
		hint "You do not have enough milcash to recruit this soldier";
	};
} else 
{
	if (count _recruit <= 0) then 
	{
		hint "Please select a soldier to recruit first";
	} else 
	{
		hint "Something is wrong with the script. Tips: Check if selected soldier array has only one element";
	};
};