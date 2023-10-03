/*
	Restores mission ID
*/
params ["_slot"];
private ["_tempID"];

["loadMissionID", format["Loading mission ID from slot %1",_slot]] call F90_fnc_debug;

_tempID = [["AWSPMissionID", F90_MISSIONID], _slot] call F90_fnc_loadData;

F90_MISSIONID = _tempID;