/*
	Author: PrinceF90 
 
	Description: 
	Function to handles the process of purchasing a vehicle by the player. It retrieves the selected vehicle from the vehicle list, checks if the player has enough money to buy it, deducts the price from the player's money and creates the vehicle. 
	
	Parameter(s): 
	0: ARRAY - _listBox: control containing the selected vehicle index 
	1: OBJECT - _buyer: Buyer's object (player) 
	
	Returns: 
	None 
	
	Examples: 
	[] call F90_fnc_purchaseVehicle;
*/
params ["_listBox", "_buyer"];

if (isNil {_listBox}) then {_listBox = VehicleShop_ListBox} else {_listBox = _listBox};
if (isNil {_buyer}) then {_buyer = VehicleShop_Buyer} else {_buyer = _buyer};

private _selectedList = [_listBox] call F90_fnc_getSelectedList;

// If player haven't selected anything, make the first item in the list as the default one
if (_selectedList == -1)then{_selectedList = 0}; 

private _itemsClassList = [];
private _itemsNameList = [];
private _itemsPriceList = [];

// Just to be safe, its better to use for loops instead of forEach 
for "_i" from 0 to (count VehicleShop_Items)-1 do 
{
	private _vehicle = VehicleShop_Items # _i;
	private _itemClass = _vehicle # 0;
	private _itemName = _vehicle # 1;
	private _itemPrice = _vehicle # 2; 

	_itemsClassList pushback _itemClass;
	_itemsNameList pushBack _itemName;
	_itemsPriceList pushBack _itemPrice;
};

private _selectionClass = _itemsClassList # _selectedList;
private _selectionPrice = _itemsPriceList # _selectedList;
private _money = ["GETMONEY", _buyer] call F90_fnc_economyHandler;

if (_money >= _selectionPrice) then 
{
	["DEDUCTMONEY", [_buyer, _selectionPrice]] call F90_fnc_economyHandler;

	private _spawnPos = [_buyer, 0, 100, 5] call BIS_fnc_findSafePos;
	_selectionClass createVehicle _spawnPos;
	"SmokeShellGreen" createVehicle _spawnPos;

	[Shop_Debug, "purchaseVehicle", format ["%1 spawned at %2", _selectionClass, _spawnPos], true] call F90_fnc_debug;

	if (Shop_VehicleMenuShown) then 
	{
		closeDialog 2;
	};
} else 
{
	hint "You do not have enough money to buy that.";
};
