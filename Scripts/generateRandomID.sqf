/*
	Function to generate random ID 
	Prefix is based on given _prefix
	Digit count is based on given _count -1. Meaning if provided count is 5, the function will generate 6 digits random ID. the last digit is float value
	e.g ["Prefix", 5] call F90_fnc_generateRandomID
	will return "Prefix123456.12345"
*/
params ["_prefix", "_count"];
["generateRandomID", "Generating random ID"] call F90_fnc_debug;

private _currentString = _prefix;

for "_i" from 1 to _count do 
{
	private _rand = floor random 9;
	_currentString = _currentString + str _rand;
};

private _lastNum = random 9;
_currentString = _currentString + str _lastNum;
["generateRandomID", format["Random ID generated. Result = %1", _currentString]] call F90_fnc_debug;

_currentString;

