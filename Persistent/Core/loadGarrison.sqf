/*
Restores player data.
Data is loaded from given save _slot.
*/

params ["_slot"];

["saveGarrison", format["Loading garrisons data from slot %1",_slot]] call F90_fnc_debug;

AWSP_Outposts = ["outposts", _slot] call F90_fnc_loadData;
AWSP_Resources = ["resources", _slot] call F90_fnc_loadData;
AWSP_FactoriesCSAT = ["factories", _slot] call F90_fnc_loadData;
AWSP_Airports = ["airports", _slot] call F90_fnc_loadData;

{
	[_x, false] call F90_fnc_initZone;	
} forEach AWSP_Outposts;

{
	[_x, false] call F90_fnc_initZone;	
} forEach AWSP_Resources;

{
	[_x, false] call F90_fnc_initZone;	
} forEach AWSP_Factories;

{
	[_x, false] call F90_fnc_initZone;	
} forEach AWSP_Airports;

["loadGarrison", "Done loading garrison data from file."] call F90_fnc_debug;
