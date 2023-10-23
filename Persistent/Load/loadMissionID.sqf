/*
	Restores mission ID
*/
params ["_slot"];
private ["_tempID"];

["loadMissionID", format["Loading mission ID from slot %1",_slot]] call F90_fnc_debug;

_tempID = ["AWSPMissionID", _slot] call F90_fnc_loadData;
if (isNil "_tempID") then
{
	["loadMissionID","Couldn't load mission ID. A new one will be generated instead"] call F90_fnc_debug;
	_tempID = ["AWSP", 5] call F90_fnc_generateRandomID;
};

F90_MISSIONID = _tempID;
["loadMissionID", format["Done loading mission ID from slot %1. F90_MISSIONID = %2",_slot, F90_MISSIONID]] call F90_fnc_debug;