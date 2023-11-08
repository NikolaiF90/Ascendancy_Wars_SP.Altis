configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

_fn_createIcon = 
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

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_AAFWeaponList + AWSP_AAFAmmoList + AWSP_AAFItemList + AWSP_AAFUniformList + AWSP_AllArmorList + AWSP_AllHeadgearList] call TER_fnc_addShopCargo;
	[independent, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_GUERWeaponShops;

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_CSATWeaponList + AWSP_AAFAmmoList + AWSP_AAFItemList + AWSP_CSATUniformList + AWSP_AllArmorList + AWSP_AllHeadgearList] call TER_fnc_addShopCargo;
	[east, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_OPFORWeaponShops;

{
	[_x] call TER_fnc_addShop;
	[_x, AWSP_CivilianWeaponList + AWSP_AAFAmmoList + AWSP_AAFItemList + AWSP_CivilianUniformList + AWSP_AllArmorList + AWSP_AllHeadgearList] call TER_fnc_addShopCargo;
	[civilian, _forEachIndex, position _x] call _fn_createIcon;
} forEach AWSP_CIVWeaponShops;