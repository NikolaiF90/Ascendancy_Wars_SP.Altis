configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

{
	[_x] call TER_fnc_addShop;
} forEach AWSP_GUERWeaponShops;