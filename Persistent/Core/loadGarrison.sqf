/*
Restores zones data.
Data is loaded from given save _slot.
*/

params ["_slot"];
private ["_tempZones"];

["loadGarrison", format["Loading garrisons data from slot %1",_slot]] call F90_fnc_debug;
_tempZones = [["AWSPZones", AWSP_Zones], _slot] call F90_fnc_loadData;

for "_i" from 0 to (count AWSP_Zones) -1 do 
{
	AWSP_Zones deleteAt 0;
};
AWSP_Zones = _tempZones;

private _zoneIndex = -1;
{
	_zoneIndex = _zoneIndex + 1;
	[_zoneIndex] call F90_fnc_clearZones;
}forEach AWSP_Zones;

_zoneIndex = -1;
{
	_zoneIndex = _zoneIndex + 1;
	["loadGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
	null = [_x, false, _zoneIndex] execVM "Init\initZone.sqf";
} forEach AWSP_Zones;

["loadGarrison", "Done loading garrison data from file."] call F90_fnc_debug;
