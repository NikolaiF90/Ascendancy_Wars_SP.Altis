configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

private _fn_createIcon = 
{
	params ["_side", "_index", "_pos"];
	private _marker = createMarker [(str _side) + "weaponshop_" + (str _index), _pos];
	_marker setMarkerType (switch (_side) do
	{
		case west: {AWSP_BLUFORWeaponIcon};
		case east: {AWSP_OPFORWeaponIcon};
		case independent: {AWSP_GUERWeaponIcon};
		case civilian: {AWSP_CIVWeaponIcon};
	});
	_marker setMarkerAlpha 1;
	_marker setMarkerSize [0.5,0.5];
};

private _shopArrays = 
[
	[AWSP_GuerWeaponShops, AWSP_AAFWeaponList + AWSP_AAFAmmoList  + AWSP_AAFUniformList + AWSP_AAFVestList  + AWSP_AAFHeadgearList  + AWSP_AAFBackpackList],
	[AWSP_OPFORWeaponShops, AWSP_CSATWeaponList + AWSP_NATOAmmoList + AWSP_CSATUniformList + AWSP_CSATVestList + AWSP_CSATHeadgearList + AWSP_CSATBackpackList],
	[AWSP_CIVWeaponShops, AWSP_CivilianWeaponList + AWSP_CivilianAmmoList + AWSP_CivilianUniformList + AWSP_CivilianVestList + AWSP_CivilianHeadgearList + AWSP_AllBackpackList],
	[AWSP_BLUFORWeaponShops, AWSP_NATOWeaponList + AWSP_NATOAmmoList + AWSP_NATOUniformList + AWSP_NATOVestList + AWSP_NATOHeadgearList + AWSP_NATOBackpackList]
];

private _universalCargo = AWSP_AllAmmoList + AWSP_AllItemList + AWSP_AllExplosiveList + AWSP_AllGrenadeList;

{
	private _shopList = _x # 0;
	private _shopCargo = _x # 1;
	private _sideIndex = _forEachIndex;

	private _combinedCargo = _shopCargo + _universalCargo;
	
	{
		private _shop = _x;
		private _pos = position _shop;
		private _index = _forEachIndex;
		
		[_shop] call TER_fnc_addShop;
		[_shop, _combinedCargo] call TER_fnc_addShopCargo;

		// Create the icon on map
		private _side = switch (_sideIndex) do 
		{
			case 0: {independent};
			case 1: {east};
			case 2: {civilian};
			case 3: {west};
		};

		[_side, _index, _pos] call _fn_createIcon;
	} forEach _shopList;
} forEach _shopArrays;