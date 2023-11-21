configureShopDone = false;
[] call F90_fnc_configureShop;
waitUntil {configureShopDone};

[Shop_Debug, "initShop", "Initializing Shop System", false] call F90_fnc_debug;

Shop_VehicleMenuShown = false;

// Weapon Icon
private _fn_createWeaponIcon = 
{
	params ["_side", "_index", "_pos"];
	[Shop_Debug, "initShop", "Creating shop icon", false] call F90_fnc_debug;
	
	private _markerName = (str _side) + "weaponshop_" + (str _index);
	private _marker = createMarker [_markerName, _pos];
	_marker setMarkerType (switch (_side) do
	{
		case west: {AWSP_BLUFORWeaponIcon};
		case east: {AWSP_OPFORWeaponIcon};
		case independent: {AWSP_GUERWeaponIcon};
		case civilian: {AWSP_CIVWeaponIcon};
	});
	_marker setMarkerAlpha 1;
	_marker setMarkerSize [0.5,0.5];

	[Shop_Debug, "initShop", format ["Created icon %1 at %2", _markerName, _pos], false] call F90_fnc_debug;
};

// Vehicle Icon
private _fn_createVehicleIcon = 
{
	params ["_side", "_index", "_pos"];
	[Shop_Debug, "initShop", "Creating shop icon", false] call F90_fnc_debug;
	
	private _markerText = (str _side) + " " + Shop_VehicleText;
	private _markerName = _markerText + (str _index);
	private _marker = createMarker [_markerName, _pos];
	_marker setMarkerType (switch (_side) do
	{
		case west: {Shop_BLUFORVehicleIcon};
		case east: {Shop_OPFORVehicleIcon};
		case independent: {Shop_GUERVehicleIcon};
		case civilian: {Shop_CIVVehicleIcon};
	});
	_marker setMarkerText _markerText;
	_marker setMarkerAlpha 1;
	_marker setMarkerSize [0.5,0.5];

	[Shop_Debug, "initShop", format ["Created icon %1 at %2", _markerName, _pos], false] call F90_fnc_debug;
};

private _weaponShopArrays = 
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

		[_side, _index, _pos] call _fn_createWeaponIcon;
	} forEach _shopList;
} forEach _weaponShopArrays;

private _allVehicleShops = [Shop_BLUFORVehicleShops] + [Shop_OPFORVehicleShops] + [Shop_GUERVehicleShops] + [Shop_CIVVehicleShops];
{
	private _shops = _x;
	private _sideIndex = _forEachIndex;

	{
		private _shop = _x;
		private _pos = position _shop;
		private _index = _forEachIndex;
		private _side = switch (_sideIndex) do 
		{
			case 0: {west};
			case 1: {east};
			case 2: {independent};
			case 3: {civilian};
		};
		
		[_shop, _side] call F90_fnc_addVehicleShop;
		[_side, _index, _pos] call _fn_createVehicleIcon;
		
	} forEach _shops;
} forEach _allVehicleShops;

[Shop_Debug, "initShop", "Done initializing Shop System", false] call F90_fnc_debug;