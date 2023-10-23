if (isNil "MILCASH_PLAYER") then 
{
	ctrlSetText [StartMenu_MoneyText, StartMenu_MoneyTextPrefix + "0"];
}else 
{
	ctrlSetText [StartMenu_MoneyText, StartMenu_MoneyTextPrefix + str MILCASH_PLAYER];
};

if (isNil "RANK_PLAYER") then 
{
	ctrlSetText [StartMenu_RankText, StartMenu_RankTextPrefix + "PRIVATE"];
}else 
{
	ctrlSetText [StartMenu_RankText, StartMenu_RankTextPrefix + RANK_PLAYER];
};

if (isNil "MILCASH_GUER") then 
{
	ctrlSetText [StartMenu_ResourceText, StartMenu_ResourceTextPrefix + "0"];
}else 
{
	ctrlSetText [StartMenu_ResourceText, StartMenu_ResourceTextPrefix + str MILCASH_GUER];
};