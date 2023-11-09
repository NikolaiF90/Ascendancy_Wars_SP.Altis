/*
	Function is intended to be called on action parameters of dialog button 
	Spawn soldier of provided class near player 

	SYNTAX:
	[recruit] call F90_fnc_spawnRecruit;

	PARAMETERS:
	0	recruit		=	AWSPRecruit_SelectedRecruit is preferred; or
						array from AWSP_FIARecruits or something related

	RETURN:
	NONE
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
		private _group = createGroup [independent, true];
		private _soldier = _group createUnit [_class, _pos, [], 0, "FORM"];
		[_soldier] join group player;
		if (Revive_Enabled) then 
		{
			_soldier call F90_fnc_addRevive;
		};
		_soldier setVariable ["Milcash", _defaultMoney];
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