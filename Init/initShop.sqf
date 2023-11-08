configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

private _fn_createIcon = 
{
	params ["_side", "_index", "_pos"];

	switch (_side) do 
	{
		case west: 
		{
			private _marker = createMarker ["westweaponshop_" + (str _index), _pos];
			_marker setMarkerType AWSP_BLUFORWeaponIcon;
			_marker setMarkerAlpha 1;
			_marker setMarkerSize [0.5,0.5];
		};
		case east: 
		{
			private _marker = createMarker ["eastweaponshop_" + (str _index), _pos];
			_marker setMarkerType AWSP_OPFORWeaponIcon;
			_marker setMarkerAlpha 1;
			_marker setMarkerSize [0.5,0.5];
		};
		case independent: 
		{
			private _marker = createMarker ["independentweaponshop_" + (str _index), _pos];
			_marker setMarkerType AWSP_GUERWeaponIcon;
			_marker setMarkerAlpha 1;
			_marker setMarkerSize [0.5,0.5];
		};
		case civilian: 
		{
			private _marker = createMarker ["civilianweaponshop_" + (str _index), _pos];
			_marker setMarkerType AWSP_CIVWeaponIcon;
			_marker setMarkerAlpha 1;
			_marker setMarkerSize [0.5,0.5];
		};
	};
};
private _guerShopArray = AWSP_AAFWeaponList + AWSP_NATOUniformList + AWSP_AAFUniformList + AWSP_AAFVestList + AWSP_NATOVestList + AWSP_AAFHeadgearList + AWSP_NATOHeadgearList + AWSP_AAFBackpackList + AWSP_NATOBackpackList;
private _opforShopArray = AWSP_CSATWeaponList + AWSP_CSATUniformList + AWSP_CSATVestList + AWSP_CSATHeadgearList + AWSP_CSATBackpackList;
private _civShopArray = AWSP_CivilianWeaponList + AWSP_CivilianUniformList + AWSP_CivilianVestList + AWSP_CivilianHeadgearList + AWSP_AllBackpackList;

{
	private _shop = _x;
	{
		[_x] call TER_fnc_addShop;
		[_x, AWSP_AllAmmoList] call TER_fnc_addShopCargo;
		[_x, AWSP_AllItemList] call TER_fnc_addShopCargo;
		[_x, AWSP_AllExplosiveList] call TER_fnc_addShopCargo;
		[_x, AWSP_AllGrenadeList] call TER_fnc_addShopCargo;
	} forEach _shop;
} forEach [AWSP_GUERWeaponShops, AWSP_OPFORWeaponShops, AWSP_CIVWeaponShops];

{
	[_x, _guerShopArray] call TER_fnc_addShopCargo;
	[independent, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_GUERWeaponShops;

{
	[_x, _opforShopArray] call TER_fnc_addShopCargo;
	[east, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_OPFORWeaponShops;

{
	
	[_x, _civShopArray] call TER_fnc_addShopCargo;
	[civilian, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_CIVWeaponShops;