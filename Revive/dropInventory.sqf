/*
	Function that drops weapons, gear, and items from a unit
 
	SYNTAX: 
	[unit] call F90_fnc_dropInventory

	PARAMETERS: 
	- _unit: Object - The unit from which the items will be removed. 

	RETURN: 
	None
*/
params ["_unit"];

private ["_primaryWeapon", "_secondaryWeapon", "_handgun", "_vest", "_backpack", "_headGear", "_goggles", "_items", "_weapons", "_inventory"];

_primaryWeapon = primaryWeapon _unit;
_secondaryWeapon = secondaryWeapon _unit;
_handgun = handgunWeapon _unit;
_vest = vest _unit;
_backpack = backpack _unit;
_headGear = headgear _unit;
_goggles = goggles _unit;
_items = itemsWithMagazines _unit;

_weapons = [_primaryWeapon, _secondaryWeapon, _handgun];
_inventory = [_vest, _backpack, _headGear, _goggles] + _items;

{
	if (_x != "") then 
	{
		_unit removeWeapon _x;
		sleep 0.1;
		private _weaponHolder = "WeaponHolderSimulated" createVehicle position _unit;
		_weaponHolder addWeaponCargoGlobal [_x, 1];
		_weaponHolder setPos (_unit modelToWorld [0,0.2,1.2]);
		_weaponHolder disableCollisionWith _unit;
		private _dir = random (360);
		private _speed = 1.5;
		_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir), 4];
	};
} forEach _weapons;

removeHeadgear _unit:
removeGoggles _unit;
removeVest _unit;
removeBackpack _unit;
removeAllAssignedItems _unit;

{
	if (_x != "") then 
	{
		sleep 0.1;
		private _weaponHolder = "WeaponHolderSimulated" createVehicle position _unit;
		_weaponHolder addItemCargoGlobal [_x, 1];
		_weaponHolder setPos (_unit modelToWorld [0,0.2,1.2]);
		_weaponHolder disableCollisionWith _unit;
		private _dir = random (360);
		private _speed = 1.5;
		_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir), 4];
	};
} forEach _inventory;