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

if !(isNil {AWSP_Zones}) then 
{
	for "_i" from 0 to (count AWSP_Zones) -1 do 
	{
		[_i] call F90_fnc_clearZones;
	};
};

{
	deleteVehicle _x;
} forEach allDead;

//	Delete injured units (if any) on load game
//	Delete non script spawned units (e.g zeus spawned)
{
	private _unit = _x;
	private _isScriptSpawned = _unit getVariable "IsScriptSpawned";

	if (isNil {_isScriptSpawned}) then 
	{
		deleteVehicle _unit;
	};
	
	if (captive _unit && (lifeState _unit == "INCAPACITATED")) then 
	{
		deleteVehicle _unit;
	};
} forEach allUnits - [commanderX];

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
[Persistent_Debug, "loadGame", format ["Persistent load done from slot %1", _slot], true] call F90_fnc_debug;

// Start the game 
F90_MissionStarted = true;

if (dialog) then 
{
	closeDialog 2;
};
[] spawn F90_fnc_showLoadingScreen;

// ZAGS
{
	[_x, false] call F90_fnc_createZone;
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