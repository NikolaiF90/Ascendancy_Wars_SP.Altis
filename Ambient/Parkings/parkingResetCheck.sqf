/*
	Function to check if given parking should be resetted
*/
params ["_house"];

private 
[
	"_spawnCheck",
	"_hasParking",
	"_hasCar"
];

_spawnCheck = _house getVariable "Ambient_SpawnCheck";

if (!_spawnCheck) exitWith
{
	[Ambient_Debug, "parkingResetCheck", format["%1 has not been checked", _house], true] call F90_fnc_debug;
};

if ((player distance _house) > Ambient_HouseScannerRadius) then 
{
	_house setVariable ["Ambient_SpawnCheck", false];
	_house setVariable ["Ambient_HasParking", false];
	_house setVariable ["Ambient_HasCar", false];

	private _houseIndex = Ambient_CheckedHouses find _house;
	Ambient_CheckedHouses deleteAt _houseIndex;

	_spawnCheck = _house getVariable "Ambient_SpawnCheck";
	_hasParking = _house getVariable "Ambient_HasParking";
	_hasCar = _house getVariable "Ambient_HasCar";
	[Ambient_Debug, "parkingResetCheck", format["Resetting %1 : spawnCheck = %2, hasParking = %3, hasCar = %4", _house, _spawnCheck, _hasParking, _hasCar], false] call F90_fnc_debug;
};