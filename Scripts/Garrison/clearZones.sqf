/*
	Code Description: 
	This script clears a specific zone by deleting its trigger and icon. 
	It takes one parameter, "_zoneIndex", which represents the index of the zone to be cleared. 
	The script checks if there are any existing zone triggers and icons. If there are none, it exits and displays a debug message.
	Otherwise, it deletes the trigger and icon associated with the specified zone index.
	The script updates the corresponding arrays to remove the deleted trigger and icon. 
	Finally, it displays a debug message indicating the successful deletion of the trigger and icon. 
	
	Syntax: 
	[parameters] call F90_fnc_clearZone 
	
	Parameters: 
	- _zoneIndex (Number): The index of the zone to be cleared. 
	
	Return: 
	None
*/
params ["_zoneIndex"];

private 
[
	"_zoneTrigger",
	"_zoneIcon"
];

if ((count AWSP_ZoneTrigger == 0) || (count AWSP_ZoneIcons == 0)) exitWith {["clearZones","No zones to clear"] call F90_fnc_debug;};
["clearZones", format["Clearing trigger and icon for zone %1", _zoneIndex]] call F90_fnc_debug;

_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
_zoneIcon = AWSP_ZoneIcons # _zoneIndex;

if !(isNil {_zoneTrigger}) then 
{
	["clearZones", format["Deleting trigger %1 of zone %2",_zoneTrigger, _zoneIndex]] call F90_fnc_debug;
	deleteVehicle _zoneTrigger;
	AWSP_ZoneTrigger set [_zoneIndex, nil];
};
if !(isNil {_zoneIcon}) then 
{
	["clearZones", format["Deleting icon of zone %1", _zoneIndex]] call F90_fnc_debug;
	deleteMarker _zoneIcon;
	AWSP_ZoneIcons set [_zoneIndex, nil];
};

["clearZones", format["Trigger and icon of zone %1 deleted. Done clearing zone", _zoneIndex]] call F90_fnc_debug;