params ["_unit"];

private _money = ["GETMONEY", _unit] call F90_fnc_economyHandler;
ctrlSetText [StartMenu_MoneyText, StartMenu_MoneyTextPrefix + str _money];

if (isNil {RANK_PLAYER}) then 
{
	ctrlSetText [StartMenu_RankText, StartMenu_RankTextPrefix + "PRIVATE"];
}else 
{
	ctrlSetText [StartMenu_RankText, StartMenu_RankTextPrefix + RANK_PLAYER];
};

if (isNil {MILCASH_GUER}) then 
{
	ctrlSetText [StartMenu_ResourceText, StartMenu_ResourceTextPrefix + "0"];
}else 
{
	ctrlSetText [StartMenu_ResourceText, StartMenu_ResourceTextPrefix + str MILCASH_GUER];
};