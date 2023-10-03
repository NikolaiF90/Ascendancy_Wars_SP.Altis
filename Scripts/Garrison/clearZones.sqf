params ["_zoneIndex"];

private 
[
	"_zoneTrigger",
	"_zoneIcon"
];

["clearZones", format["Clearing trigger and icon for zone %1", _zoneIndex]] call F90_fnc_debug;

_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
_zoneIcon = AWSP_ZoneIcons # _zoneIndex;

if (!isNil "_zoneTrigger") then 
{
	["clearZones", format["Deleting trigger %1 of zone %2",_zoneTrigger, _zoneIndex]] call F90_fnc_debug;
	deleteVehicle _zoneTrigger;
	AWSP_ZoneTrigger set [_zoneIndex, nil];
};
if (!isNil "_zoneIcon") then 
{
	["clearZones", format["Deleting icon of zone %1", _zoneIndex]] call F90_fnc_debug;
	deleteMarker _zoneIcon;
	AWSP_ZoneIcons set [_zoneIndex, nil];
};

["clearZones", format["Trigger and icon of zone %1 deleted. Done clearing zone", _zoneIndex]] call F90_fnc_debug;