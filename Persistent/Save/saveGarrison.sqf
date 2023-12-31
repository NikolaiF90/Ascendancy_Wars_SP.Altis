/*
	Save all garrisons so that it stays the same on next login
*/

params ["_slot"];

[Persistent_Debug, "saveGarrison", format["Saving garrisons data to slot %1",_slot], false] call F90_fnc_debug;

private _AWSPZones = AWSP_Zones + [];
["AWSPZones", _AWSPZones, _slot] call F90_fnc_saveData;

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