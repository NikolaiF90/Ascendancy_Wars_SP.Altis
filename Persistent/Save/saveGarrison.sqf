/*
	Save all garrisons so that it stays the same on next login
*/

params ["_slot"];

["saveGarrison", format["Saving garrisons data to slot %1",_slot]] call F90_fnc_debug;

["AWSPZones", AWSP_Zones, _slot] call F90_fnc_saveData;
