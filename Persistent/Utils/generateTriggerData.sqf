/*
	Generate an array of data for given trigger
*/
params ["_trigger"];

["generateTriggerData", format["Generating data for trigger %1", _trigger]] call F90_fnc_debug;

private _triggerData = [];

_triggerData pushBack ["position", getPosASL _trigger];
_triggerData pushBack ["area", triggerArea _trigger];
_triggerData pushBack ["activation", triggerActivation _trigger];
_triggerData pushBack ["timeout", triggerTimeout _trigger];
_triggerData pushBack ["statements", triggerStatements _trigger];

private _groupCount = _trigger getVariable ["Zone_GroupCount", 0];
_triggerData pushback ["groupCount", _groupCount];
["DEBUG", format ["groupCount saved = %1", _groupCount]] call F90_fnc_debug;
private _cachedGroup = _trigger getVariable ["Zone_CachedGroup", []];
_triggerData pushBack ["cachedGroup", _cachedGroup];

_triggerData;