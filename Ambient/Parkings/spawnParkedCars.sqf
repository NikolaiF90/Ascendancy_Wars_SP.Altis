/*
	Function to spawn empty cars at suitable parking spaces

	SYNTAX:
		[house] call F90_fnc_spawnParkedCars;	
	PARAMETERS:
		house - object to spawn parked cars;
	RETURN:
		None
*/
params ["_house"];

private 
[
	"_parkingPosition",
	"_parkingDirection",
	"_car",
	"_spawnedCar"
];

_parkingPosition = _house getVariable "parkingPosition";
_parkingDirection = _house getVariable "parkingDirection";
_car = selectRandom Ambient_CivilianCarList;

if (floor random 100 < Ambient_WreckSpawnChance) then 
{
	_car = selectRandom Ambient_WreckedCarList;
};

_spawnedCar = _car createVehicle _parkingPosition;
_spawnedCar setDir _parkingDirection;

_spawnedCar addEventHandler ["GetIn", F90_fnc_stealCarEH];
Ambient_SpawnedCars pushBack _spawnedCar;