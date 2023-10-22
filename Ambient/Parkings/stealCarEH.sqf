/*
	Event handler that should be triggered if player has stolen a car
*/
params ["_vehicle", "_role", "_unit", "_turret"];

_vehicle setFuel random 1;

if (_role == "driver") then 
{
	_vehicle setVariable ["hasOwner", true];
	[_vehicle] call F90_fnc_addVehiclesToSave;
};