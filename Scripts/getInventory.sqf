/*
	Function to get inventory of provided unit
	This function is useful for copying unit loadout
	SYNTAX:
		[unit,uniform] call F90_fnc_getInventory;
	PARAMETERS:
		unit: unit to get inventory from
		uniform: Boolean - true to include uniform 
	RETURN:
		Array of unit's inventory. Uniform, vest and backpacks will be last index of the array
*/
params ["_unit", "_includeUniform"];

private ["_inventory", "_weapons", "_items", "_magazines", "_backpacks"];

_inventory = [];

if (primaryWeapon _unit != "") then 
{
	// PRIMARY
	private _primaryWeapon = primaryWeapon _unit;
	if (_primaryWeapon != "") then 
	{
		_weapons pushBack _primaryWeapon;

		private _attachments = primaryWeaponItems _unit;
		if (count _attachments > 0) then 
		{
			{
				_items pushBack _x;
			} forEach _attachments;
		};

		private _mags = primaryWeaponMagazine _unit;
		if (count _mags > 0) then 
		{
			{
				_magazines pushBack _x;
			} forEach _mags;
		};
	};

	// SECONDARY
	private _secondaryWeapon = secondaryWeapon _unit;
	if (_secondaryWeapon != "") then 
	{
		_weapons pushBack _secondaryWeapon;

		private _attachments = secondaryWeaponItems _unit;
		if (count _attachments > 0) then 
		{
			{
				_items pushBack _x;
			} forEach _attachments;
		};

		private _mags = secondaryWeaponMagazine _unit;
		if (count _mags > 0) then 
		{
			{
				_magazines pushBack _x;
			} forEach _mags;
		};
	};

	// HANDGUN
	private _handgunWeapon = handgunWeapon _unit;
	if (_handgunWeapon != "") then 
	{
		_weapons pushBack _handgunWeapon;

		private _attachments = handgunItems _unit;
		if (count _attachments > 0) then 
		{
			{
				_items pushBack _x;
			} forEach _attachments;
		};

		private _mags = handgunMagazine _unit;
		if (count _mags > 0) then 
		{
			{
				_magazines pushBack _x;
			} forEach _mags;
		};
	};
};

{
	_inventory pushBack _x;
} forEach (itemsWithMagazines _unit);

_inventory;