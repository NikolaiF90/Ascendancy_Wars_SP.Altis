/*
	Function to check if given vehicle should be despawned
*/
params ["_vehicle"];

private _hasOwner = _vehicle getVariable ["hasOwner", false];

if(_hasOwner) exitWith {};

if (player distance _vehicle > Ambient_ParkingDespawnDistance) then 
{
	deleteVehicle _vehicle;
	Ambient_SpawnedCars = Ambient_SpawnedCars - [_vehicle];
};