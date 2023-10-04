/*
Restores zones data.
Data is loaded from given save _slot.
*/

params ["_slot"];
private ["_tempZones"];

["loadGarrison", format["Loading garrisons data from slot %1",_slot]] call F90_fnc_debug;

_tempZones = ["AWSPZones", _slot] call F90_fnc_loadData;
if (isNil "_tempZones") then 
{
	["loadGarrison","Couldn't load garrisons. A new one will be generated instead"] call F90_fnc_debug;
	private _allyOutpostData = [independent,"Outpost"] call F90_fnc_generateGarrison;
	private _eastOutpostData = [east,"Outpost"] call F90_fnc_generateGarrison;
	private _eastResourceData = [east,"Resource"] call F90_fnc_generateGarrison;
	private _eastFactoryData = [east,"Factory"] call F90_fnc_generateGarrison;
	private _eastAirportData = [east,"Airport"] call F90_fnc_generateGarrison;
	_tempZones = 
	[
		//	OUTPOSTS
		["outpost_0", _allyOutpostData],
		["outpost_1", _eastOutpostData],
		["outpost_2", _eastOutpostData],
		["outpost_3", _eastOutpostData],
		["outpost_4", _eastOutpostData],
		["outpost_5", _eastOutpostData],
		["outpost_6", _eastOutpostData],
		["outpost_7", _eastOutpostData],

		//	RESOURCES
		["resource_0", _eastResourceData],
		["resource_1", _eastResourceData],
		["resource_2", _eastResourceData],
		["resource_3", _eastResourceData],
		["resource_4", _eastResourceData],
		["resource_5", _eastResourceData],
		["resource_6", _eastResourceData],
		["resource_7", _eastResourceData],
		["resource_8", _eastResourceData],

		//	FACTORIES
		["factory_0", _eastFactoryData],
		["factory_1", _eastFactoryData],

		//	AIRPORTS 
		["airport_0", _eastAirportData],
		["airport_1", _eastAirportData],
		["airport_2", _eastAirportData]
	];
};

for "_i" from 0 to (count AWSP_Zones) -1 do 
{
	AWSP_Zones deleteAt 0;
};
AWSP_Zones = _tempZones;

["loadGarrison", format ["AWSP_ZoneTrigger = %1", AWSP_ZoneTrigger]] call F90_fnc_debug;
private _zoneIndex = -1;
{
	_zoneIndex = _zoneIndex + 1;
	["loadGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
	[_zoneIndex] call F90_fnc_clearZones;
	null = [_x, false, _zoneIndex] execVM "Init\initZone.sqf";
} forEach AWSP_Zones;

["loadGarrison", "Done loading garrison data from file."] call F90_fnc_debug;
