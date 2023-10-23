/*
	Function Description: 
	The provided .sqf code is a function that creates a trigger based on the given "_triggerData" array. 
	It retrieves various properties from the "_triggerData" array, such as position, area, activation, timeout, statements, group count, and cached group. 
	It then uses these properties to configure the created trigger accordingly. 
	
	Syntax: 
	[_triggerData] call F90_fnc_loadTriggerData
	
	Parameters: 
	- "_triggerData": An array containing the necessary data to configure the trigger, including position, area, activation, timeout, statements, group count, and cached group. 
	
	Return: 
	_trigger: Created trigger object
*/
params ["_triggerData"];

private _position = [_triggerData, "position"] call F90_fnc_getByKey;
private _area = [_triggerData, "area"] call F90_fnc_getByKey;
private _activation = [_triggerData, "activation"] call F90_fnc_getByKey;
private _timeout = [_triggerData, "timeout"] call F90_fnc_getByKey;
private _statements = [_triggerData, "statements"] call F90_fnc_getByKey;

private _groupCount = [_triggerData, "groupCount"] call F90_fnc_getByKey;
private _cachedGroup = [_triggerData, "cachedGroup"] call F90_fnc_getByKey;

private _trigger = createTrigger ["EmptyDetector", _position];

private _a = _area # 0;
private _b = _area # 1;
private _isRectangle = _area # 2;
private _c = _area # 3;
_trigger setTriggerArea [_a, _b, _isRectangle, _c];

private _by = _activation # 0;
private _type = _activation # 1;
private _repeating = _activation # 2;
_trigger setTriggerActivation [_by, _type, _repeating];

private _min = _timeout # 0;
private _mid = _timeout # 1;
private _max = _timeout # 2;
private _interruptable = _timeout # 3;
_trigger setTriggerTimeout [_min, _mid, _max, _interruptable];

private _condition = _statements # 0;
private _activation = _statements # 1;
private _deactivation = _statements # 2;
_trigger setTriggerStatements [_condition, _activation, _deactivation];

_trigger setVariable ["Zone_GroupCount", _groupCount];
["DEBUG", format ["groupCount loaded = %1", _groupCount]] call F90_fnc_debug;
_trigger setVariable ["Zone_CachedGroup", _cachedGroup];

_trigger;