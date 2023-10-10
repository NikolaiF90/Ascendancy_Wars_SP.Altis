/*
	Event handler to make a unit incapacitated instead of dying
*/
params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

if (_damage >= 0.99) then 
{
	if !(lifeState _unit == "INCAPACITATED") then 
	{
		[_unit, true] call F90_fnc_setUnitReviveState;
		_unit call F90_fnc_addPlayerHoldRevive;
	};
	_damage = 0;
};
_damage;