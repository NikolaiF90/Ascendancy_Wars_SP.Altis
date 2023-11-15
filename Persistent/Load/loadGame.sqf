/*
	Author: PrinceF90 
 
	Description: 
	Function to load saved game data and initializing various aspects of the game. It loads data from a specified slot, calls functions to load vehicles, units, player information, map markers, garrison, CDARS data, and other custom data. It also handles the cleanup of dead units, shows a loading screen, and initializes certain game features. 
	
	Parameter(s): 
		0: NUMBER - _slot: The slot number from which to load the game data. 
	
	Returns: 
		None 
	
	Examples: 
		// Example 1: Load game data from slot 1 
		private _slot = 1; 
		[_slot] call F90_fnc_loadGame; 
	
		// Example 2: Load game data from slot 2 
		private _slot = 2; 
		[_slot] call F90_fnc_loadGame;
*/

params ["_slot"];

[Persistent_Debug, "loadGame", format ["Loading data from slot %1", _slot], false] call F90_fnc_debug;

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
[_slot] call F90_fnc_loadCDARSData;

{
	[_x, [_slot]] call skhpersist_fnc_CallFunctionFromFileOrCode;
} forEach PSave_AfterLoadEH;

PSave_LoadInProgress = false;

hint format ["Persistent load done from slot %1", _slot];
[Persistent_Debug, "loadGame", format ["Persistent load done from slot %1", _slot], false] call F90_fnc_debug;

// Start the game 
F90_MissionStarted = true;

{
	deleteVehicle _x;
} forEach allDead;

{
	deleteVehicle _x;
} forEach allUnits - [commanderX];

if (dialog) then 
{
	closeDialog 2;
};
[] spawn F90_fnc_showLoadingScreen;

// ZAGS
{
	[_forEachIndex] call F90_fnc_clearZones;
	[_x, false] spawn F90_fnc_createZone;
} forEach AWSP_Zones;

// CDARS
[] spawn 
{
	while {true} do 
	{	
		// Activity Handler 
		if (CDARS_GUERActivity > 0) then 
		{
			CDARS_GUERActivity = CDARS_GUERActivity - 5;
			if (CDARS_GUERActivity < 0) then 
			{
				CDARS_GUERActivity = 0;
			};
		};
		["DEFAULT"] spawn F90_fnc_eastCommanderHandler;
		sleep (CDARS_ActivityIntervals * 60);
	};
};