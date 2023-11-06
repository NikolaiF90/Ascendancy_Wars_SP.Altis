configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_AAFWeaponList + AWSP_AAFAmmoList + AWSP_AAFItemList] call TER_fnc_addShopCargo;
} forEach AWSP_GUERWeaponShops;

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_CSATWeaponList + AWSP_AAFAmmoList + AWSP_AAFItemList] call TER_fnc_addShopCargo;
} forEach AWSP_CIVWeaponShops;