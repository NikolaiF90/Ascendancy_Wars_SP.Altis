/*
	Function to find parking spot
	
	SYNTAX:
		[house] call F90_fnc_findParking;
	PARAMETERS:
		house - Object to find for parking
	RETURN:
		Nothing
*/
params ["_house"];

private 
[
	"_hasCar",
	"_spawnCheck",
	"_hasParking",
	"_nearbyRoads", 
	"_parking", 
	"_connectedRoads", 
	"_parkingExit", 
	"_parkingDirection", 
	"_houseDirection",
	"_parkingPosition",
	"_posX",
	"_posY"
];

_spawnCheck = _house getVariable ["Ambient_SpawnCheck", false];
_hasParking = _house getVariable ["Ambient_HasParking", false];
_hasCar = _house getVariable ["Ambient_HasCar", false];

["findParking", format["%1 : spawnCheck = %2, hasParking = %3, hasCar = %4", _house, _spawnCheck, _hasParking, _hasCar]] call F90_fnc_debug;

if (!_spawnCheck) then
{
	_house setVariable ["Ambient_SpawnCheck", true];
	_house setVariable ["Ambient_HasCar", false];
	_house setVariable ["Ambient_HasParking", false];
	if (Ambient_ParkingSpawnChance < floor random 100) exitWith {};
	
	_nearbyRoads = _house nearRoads 30;
	if (count _nearbyRoads == 0) exitWith {};
	_parking = _nearbyRoads # 0;

	if (count (_parking nearEntities ["car", 10]) > 0) exitWith {};

	_connectedRoads = roadsConnectedTo _parking;
	if (count _connectedRoads < 1) exitWith {};

	_parkingExit = _connectedRoads # 0;
	_parkingDirection = [_parking, _parkingExit] call BIS_fnc_dirTo; 
	_parkingPosition = getPosASL _parking;

	_posX = _parkingPosition # 0;
	_posY = _parkingPosition # 1;
	
	_parkingPosition = [_posX -1, _posY -1, 0];

	_house setVariable ["Ambient_HasParking", true];
	_house setVariable ["parkingPosition", _parkingPosition];
	_house setVariable ["parkingDirection", _parkingDirection];

	_spawnCheck = _house getVariable ["Ambient_SpawnCheck", false];
	_hasParking = _house getVariable ["Ambient_HasParking", false];
	_hasCar = _house getVariable ["Ambient_HasCar", false];
	["findParking", format["Parking created for %1 : spawnCheck = %2, hasParking = %3, hasCar = %4", _house, _spawnCheck, _hasParking, _hasCar]] call F90_fnc_debug;
};

if ((_hasParking)&&(!_hasCar)) then 
{
	[_house] spawn F90_fnc_spawnParkedCars;
	_house setVariable ["Ambient_HasCar", true];
	
	_spawnCheck = _house getVariable ["Ambient_SpawnCheck", false];
	_hasParking = _house getVariable ["Ambient_HasParking", false];
	_hasCar = _house getVariable ["Ambient_HasCar", false];
	["findParking", format["Car spawned for %1 : spawnCheck = %2, hasParking = %3, hasCar = %4", _house, _spawnCheck, _hasParking, _hasCar]] call F90_fnc_debug;
};
