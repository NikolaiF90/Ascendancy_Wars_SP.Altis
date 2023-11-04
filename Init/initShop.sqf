configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_BASEWeaponList + AWSP_BASEAmmoList + AWSP_BASEItemList] call TER_fnc_addShopCargo;
} forEach AWSP_GUERWeaponShops;