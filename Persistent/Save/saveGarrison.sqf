/*
	Save all garrisons so that it stays the same on next login
*/

params ["_slot"];

[Persistent_Debug, "saveGarrison", format["Saving garrisons data to slot %1",_slot], false] call F90_fnc_debug;

private ["_marker","_side"];
["AWSPZones", AWSP_Zones, _slot] call F90_fnc_saveData;
{
	_marker = _x # 1;
	_side = _x # 4;
	[Persistent_Debug, "saveGarrison", format["Saved data = %1(%2)",_marker,_side], false] call F90_fnc_debug;
} forEach AWSP_Zones;

// Convert zone triggers into saveable data
private _zoneTriggers  = [];
//	Safer than using forEach, as we wanted to keep the data in orders
for "_i" from 0 to (count AWSP_ZoneTrigger)-1 do 
{
	private _trigger = AWSP_ZoneTrigger # _i;
	private _triggerData = [_trigger] call F90_fnc_generateTriggerData;
	_zoneTriggers pushBack _triggerData;
};

["ZoneTriggers", _zoneTriggers, _slot] call F90_fnc_saveData;