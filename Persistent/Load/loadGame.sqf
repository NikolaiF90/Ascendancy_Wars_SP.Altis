/*
	Loads the game state on given save _slot.
*/

params ["_slot"];

[format ["Loading data from slot %1", _slot]] call skhpersist_fnc_LogToRPT;

PSave_LoadInProgress = true;
PSave_NextVehicleId = 1;

{
	[_x, [_slot]] call skhpersist_fnc_CallFunctionFromFileOrCode;
} forEach PSave_BeforeLoadEH;

[_slot] call F90_fnc_loadVehicles; // has to be called before loading units and player
[_slot] call F90_fnc_loadMissionID;
[_slot] call skhpersist_fnc_LoadCustomUnits;
[_slot] call F90_fnc_loadPlayer;
[_slot] call F90_fnc_loadPlayerInfo;
[_slot] call skhpersist_fnc_LoadCustomContainers;
[_slot] call skhpersist_fnc_LoadCustomVariables;
[_slot] call skhpersist_fnc_LoadEnvironmentInfo;
[_slot] call F90_fnc_loadMapMarkers;
[_slot] call F90_fnc_loadGarrison;

{
	[_x, [_slot]] call skhpersist_fnc_CallFunctionFromFileOrCode;
} forEach PSave_AfterLoadEH;

PSave_LoadInProgress = false;

hint format ["Persistent load done from slot %1", _slot];
["loadGame", format ["Persistent load done from slot %1", _slot]] call F90_fnc_debug;

// Start the game 

[] call F90_fnc_initCDARS;

{
	[_forEachIndex] call F90_fnc_clearZones;
	[_x, false] spawn F90_fnc_createZone;
} forEach AWSP_Zones;