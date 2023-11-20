/*
	Code Description: 
	This script restores zone data from a saved slot. 
	It loads the garrisons, zone triggers, and zone icons from the specified slot. 
	It then updates the corresponding global variables with the loaded data. 
	Next, it clears the existing zones and recreates them using the updated data.
	
	Syntax: 
	[parameters] call F90_fnc_loadGarrison 
	
	Parameters: 
	- _slot (Any): The slot from which to load the zone data. 
	
	Return: 
	None 
*/

params ["_slot"];
private ["_tempZones", "_tempZoneTrigger", "_tempZoneIcons", "_zoneTriggers"];

configureGarrisonDone = false;
[] call F90_fnc_configureGarrison;
waitUntil {configureGarrisonDone};

AWSP_Zones = [];
AWSP_ZoneTrigger = [];
AWSP_ZoneIcons = [];

[Persistent_Debug, "loadGarrison", format["Loading garrisons data from slot %1",_slot], false] call F90_fnc_debug;

_tempZones = ["AWSPZones", _slot] call F90_fnc_loadData;
AWSP_Zones = _tempZones + [];

_zoneTriggers = ["ZoneTriggers", _slot] call f90_fnc_loadData;
for "_i" from 0 to (count _zoneTriggers)-1 do 
{
	private _data = _zoneTriggers # _i;
	private _trigger = [_data] call F90_fnc_loadTriggerData;
	AWSP_ZoneTrigger set [_i, _trigger];
};

[Persistent_Debug, "loadGarrison", "Done loading garrison data from file.", false] call F90_fnc_debug;
