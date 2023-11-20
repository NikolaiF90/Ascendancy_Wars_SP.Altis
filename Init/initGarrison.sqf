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