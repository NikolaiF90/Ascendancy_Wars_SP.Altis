/*
	Save mission ID
*/

params ["_slot"];

["saveMissionID", format["Saving mission ID to slot %1",_slot]] call F90_fnc_debug;

["AWSPMissionID", F90_MISSIONID, _slot] call F90_fnc_saveData;