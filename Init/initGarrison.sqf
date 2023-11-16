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
configureGarrisonDone = false;
[] call F90_fnc_configureGarrison;
waitUntil {configureGarrisonDone};

[Garrison_Debug, "initGarrison", "Initializing garrisons data..", true] call F90_fnc_debug;

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

for "_i" from 0 to (count AWSP_ZoneMarkers) -1 do 
{
	private _marker = AWSP_ZoneMarkers # _i;
	private _side = east;

	private _zoneData = [];
	if (_i == 0) then 
	{
		_zoneData = ["respawn_guerrila", independent, _i] call F90_fnc_generateZone;
	}else 
	{
		_zoneData = [_marker, east, _i] call F90_fnc_generateZone;
	};

	AWSP_Zones set [_i, _zoneData];
};

{
	[_forEachIndex] call F90_fnc_clearZones; // Delete default zones
	[_x, false] call F90_fnc_createZone;
} forEach AWSP_Zones;

AWSP_WestUnits = 
[
	"B_Soldier_TL_F",
	"B_soldier_LAT_F",
	"B_Soldier_F",
	"B_Soldier_GL_F",
	"B_engineer_F",
	"B_medic_F",
	"B_soldier_AR_F",
	"B_Soldier_A_F"
];

AWSP_EastUnits = 
[
	"O_Soldier_TL_F",
	"O_Soldier_LAT_F",
	"O_Soldier_F",
	"O_Soldier_GL_F",
	"O_engineer_F",
	"O_medic_F",
	"O_Soldier_AR_F",
	"O_Soldier_A_F"
];

AWSP_IndependentUnits = 
[
	"I_Soldier_TL_F",
	"I_soldier_F",
	"I_Soldier_AA_F",
	"I_Soldier_GL_F",
	"I_engineer_F",
	"I_medic_F",
	"I_Soldier_AR_F",
	"I_Soldier_A_F"
];