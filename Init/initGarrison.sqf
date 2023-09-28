/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20
*/
["initGarrison", "Initializing garrisons data.."] call F90_fnc_debug;
null=[] execVM "eos\core\spawn_fnc.sqf";

EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units
AWSP_GarrisonSpawnDistance = 350;
AWSP_HeightLimit = true;

private _allyOutpostData = [independent,"Outpost"] call F90_fnc_generateGarrison;
private _eastOutpostData = [east,"Outpost"] call F90_fnc_generateGarrison;
private _eastResourceData = [east,"Resource"] call F90_fnc_generateGarrison;
private _eastFactoryData = [east,"Factory"] call F90_fnc_generateGarrison;
private _eastAirportData = [east,"Airport"] call F90_fnc_generateGarrison;


AWSP_Outposts = 
[
	["outpost_0", _allyOutpostData],
	["outpost_1", _eastOutpostData],
	["outpost_2", _eastOutpostData],
	["outpost_3", _eastOutpostData],
	["outpost_4", _eastOutpostData],
	["outpost_5", _eastOutpostData],
	["outpost_6", _eastOutpostData],
	["outpost_7", _eastOutpostData]
];

AWSP_Resources = 
[
	["resource_0", _eastResourceData],
	["resource_1", _eastResourceData],
	["resource_2", _eastResourceData],
	["resource_3", _eastResourceData],
	["resource_4", _eastResourceData],
	["resource_5", _eastResourceData],
	["resource_6", _eastResourceData],
	["resource_7", _eastResourceData],
	["resource_8", _eastResourceData]
];

AWSP_Factories = 
[
	["factory_0", _eastFactoryData],
	["factory_1", _eastFactoryData]
];

AWSP_Airports = 
[
	["airport_0", _eastAirportData],
	["airport_1", _eastAirportData],
	["airport_2", _eastAirportData]
];

{
	null = [_x, false] execVM "Init\initZone.sqf";
	["initGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
} forEach AWSP_Outposts;

{
	null = [_x, false] execVM "Init\initZone.sqf";	
	["initGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
} forEach AWSP_Resources;

{
	null = [_x, false] execVM "Init\initZone.sqf";	
	["initGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
} forEach AWSP_Factories;

{
	null = [_x, false] execVM "Init\initZone.sqf";	
	["initGarrison", format ["Initializing zone: %1", _x]] call F90_fnc_debug;
} forEach AWSP_Airports;

["initGarrison", "Done initializing garrison data."] call F90_fnc_debug;