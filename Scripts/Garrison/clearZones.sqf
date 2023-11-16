/*
	Author: PrinceF90 
 
	Description: 
	This function clears a specific zone by deleting its trigger and icon. 
	
	Parameter(s): 
		0: NUMBER - The index of the zone to be cleared. 
	
	Returns: 
		None 
	
	Examples: 
		// Clear zone with index 2 
		[2] call F90_fnc_clearZones;
*/
params ["_zoneIndex"];

if ((count AWSP_ZoneTrigger == 0) || (count AWSP_ZoneIcons == 0)) exitWith {[Garrison_Debug, "clearZones","No zones to clear", true] call F90_fnc_debug};


private _zoneData = AWSP_Zones # _zoneIndex;
private _zoneName = _zoneData # 1;

private _zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
private _zoneIcon = AWSP_ZoneIcons # _zoneIndex;

if ((isNil {_zoneTrigger})&&(isNil {_zoneIcon})) exitWith {[Garrison_Debug, "clearZones","No zones to clear", true] call F90_fnc_debug};
[Garrison_Debug,"clearZones",format["Now clearing zone %1(%2)", _zoneIndex, _zoneName],true] call F90_fnc_debug;

if !(isNil {_zoneTrigger}) then 
{
	deleteVehicle _zoneTrigger;
	AWSP_ZoneTrigger set [_zoneIndex, nil];
};
if !(isNil {_zoneIcon}) then 
{
	deleteMarker _zoneIcon;
	AWSP_ZoneIcons set [_zoneIndex, nil];
};

[Garrison_Debug, "clearZones", format["Trigger and icon of zone %1(%2) deleted. Done clearing zone", _zoneIndex, _zoneName], true] call F90_fnc_debug;