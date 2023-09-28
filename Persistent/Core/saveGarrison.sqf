/*
	Save all garrisons so that it stays the same on next login
*/

params ["_slot"];

["saveGarrison", format["Saving garrisons data to slot %1",_slot]] call F90_fnc_debug;

["outposts", AWSP_Outposts, _slot] call F90_fnc_saveData;
["resources", AWSP_Resources, _slot] call F90_fnc_saveData;
["factories", AWSP_Factories, _slot] call F90_fnc_saveData;
["airports", AWSP_Airports, _slot] call F90_fnc_saveData;
