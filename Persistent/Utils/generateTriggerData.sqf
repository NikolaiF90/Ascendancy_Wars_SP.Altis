/*
	Author: PrinceF90 
 
	Description: 
	This code analyzes the given trigger and generates data related to its position, area, activation, timeout, statements, group count, and cached group. 
	
	Parameter(s): 
	0: OBJECT - _trigger: The trigger object to be analyzed. 
	
	Returns: 
	ARRAY: An array containing various data related to the trigger. 
	
	Examples: 
	// Analyzing a trigger named _myTrigger
	_triggerData = [_myTrigger] call F90_fnc_generateTriggerData; // _triggerData = [["position", [1234,5678,0]], ["area", [0,0,0]], ["activation", "ANY"], ["timeout", 0], ["statements", []], ["groupCount", 0], ["cachedGroup", []]]
*/
params ["_trigger"];

[Persistent_Debug,"generateTriggerData", format["Generating data for trigger %1", _trigger],false] call F90_fnc_debug;

private _triggerData = [];

_triggerData pushBack ["position", getPosASL _trigger];
_triggerData pushBack ["area", triggerArea _trigger];
_triggerData pushBack ["activation", triggerActivation _trigger];
_triggerData pushBack ["timeout", triggerTimeout _trigger];
_triggerData pushBack ["statements", triggerStatements _trigger];

private _groupCount = _trigger getVariable ["Zone_GroupCount", 0];
_triggerData pushback ["groupCount", _groupCount];
private _cachedGroup = _trigger getVariable ["Zone_CachedGroup", []];
_triggerData pushBack ["cachedGroup", _cachedGroup];

_triggerData;