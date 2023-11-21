/*
	Author: PrinceF90 
 
	Description: 
	Function to add specified object as a vehicle shop.
	
	Parameter(s): 
	0: OBJECT - _object: The object to which the action is added. 
	1: SIDE - _owner: The side of the shop. 
	
	Returns: 
	None 
	
	Examples: 
	private _shop = "Land_RepairDepot_01_tan_F" createVehicle [0,0,0];
	[_shop, west] call F90_fnc_addVehicleShop;
*/
params ["_object", "_owner"];

_object setVariable ["Owner", _owner];
_object addAction ["Purchase Vehicle", 
{
	params ["_target", "_caller", "_actionId", "_arguments"]; 

	if (dialog) then {closeDialog 2};
	Shop_VehicleMenuShown = createDialog "vehicleShopMenu";

	if (isNil {VehicleShop_Buyer}) then 
	{
		VehicleShop_Buyer = _caller;
	};

	private _owner = _target getVariable "Owner";

	if (isNil {VehicleShop_Items}) then 
	{
		VehicleShop_Items = switch (_owner) do 
		{
			case west: { Shop_BLUFORVehiclesOnShop };
			case east: { Shop_OPFORVehiclesOnShop };
			case independent: { Shop_GUERVehiclesOnShop };
			case civilian: { Shop_CIVVehiclesOnShop };
		};
	};

	private _itemsClassList = [];
	private _itemsNameList = [];
	private _itemsPriceList = [];

	// Just to be safe, its better to use for loops instead of forEach 
	for "_i" from 0 to (count VehicleShop_Items)-1 do 
	{
		private _vehicle = VehicleShop_Items # _i;
		private _itemClass = _vehicle # 0;
		private _itemName = _vehicle # 1;
		private _itemPrice = _vehicle # 2; // Lets not bother about price first

		_itemsClassList pushback _itemClass;
		_itemsNameList pushBack _itemName;
		_itemsPriceList pushBack _itemPrice;
	};
	
	VehicleShop_SelectedList = [VehicleShop_ListBox] call F90_fnc_getSelectedList;
	
	// If player haven't selected anything, make the first item in the list as the default one
	if (VehicleShop_SelectedList == -1)then{VehicleShop_SelectedList = 0}; 
	[VehicleShop_ListBox, _itemsNameList] call F90_fnc_updateListbox;
	[VehicleShop_ListBox, _itemsPriceList] spawn F90_fnc_updateVehiclePrice;
	[VehicleShop_Buyer, VehicleShop_MoneyText] call F90_fnc_updateMoneyText;
}, nil, 5, false, true, "" , "true", 10];