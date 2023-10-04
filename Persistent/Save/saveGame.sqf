/*
	Performs a persistent save on provided _slot.
*/

params ["_slot"];

PSave_SaveInProgress = true;

{
	[_x, [_slot]] call F90_fnc_compileCode;
} forEach PSave_BeforeSaveEH;

["saveGame", format ["Saving data on slot %1", _slot]] call F90_fnc_debug;

[_slot] call F90_fnc_clearSave;
["saveGame", "Done clearing save"] call F90_fnc_debug;

[_slot] call F90_fnc_saveMissionID;
[_slot] call F90_fnc_saveMetadata;
[_slot] call F90_fnc_savePlayer;
[_slot] call F90_fnc_savePlayerInfo;
[_slot] call F90_fnc_saveCustomContainers;
[_slot] call F90_fnc_saveCustomUnits;
[_slot] call F90_fnc_saveCustomVariables;
[_slot] call F90_fnc_saveCustomVehicles;
[_slot] call F90_fnc_saveEnvironment;
[_slot] call F90_fnc_saveMapMarkers;
[_slot] call F90_fnc_saveGarrison;

{
	[_x, [_slot]] call F90_fnc_compileCode;
} forEach PSave_AfterSaveEH;

saveProfileNamespace;

PSave_SaveInProgress = false;
doneSaving = true;
hint format ["Persistent save done on slot %1.", _slot];
["saveGame", format ["Done saving data into slot %1", _slot]] call F90_fnc_debug;