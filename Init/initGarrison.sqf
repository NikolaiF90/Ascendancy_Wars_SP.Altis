/*
	Code Description: 
	This script initializes garrison data. It configures garrisons, sets up zone markers, generates zones based on the markers, and creates the zones. 
	The script does not return any value. 
	
	Syntax: 
	[parameters] call F90_fnc_initGarrison 
	
	Parameters: 
	None 
	
	Return: 
	None 
*/
["initGarrison", "Initializing garrisons data.."] call F90_fnc_debug;

configureGarrisonDone = false;
[] call F90_fnc_configureGarrison;
waitUntil {configureGarrisonDone};

AWSP_Zones = [];
AWSP_ZoneTrigger = [];
AWSP_ZoneIcons = [];

AWSP_ZoneMarkers = 
[
	"respawn_guerrila",

	"outpost_0",
	"outpost_1",
	"outpost_2",
	"outpost_3",
	"outpost_4",
	"outpost_5",
	"outpost_6", 
	"outpost_7",

	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4",
	"resource_5",
	"resource_6",
	"resource_7",
	"resource_8",

	"factory_0",
	"factory_1",

	"airport_0",
	"airport_1",
	"airport_2"
];

{
	private _zone = [_x, east, _forEachIndex] call F90_fnc_generateZone;
	AWSP_Zones set [_forEachIndex, _zone];
} forEach AWSP_ZoneMarkers;

private _ldfBase = ["respawn_guerrila", independent, 0] call F90_fnc_generateZone;
AWSP_Zones set [0, _ldfBase];

{
	[_forEachIndex] call F90_fnc_clearZones;
	[_x, false] spawn F90_fnc_createZone;
} forEach AWSP_Zones;