/*
	Author: PrinceF90 
 
	Description: 
	Function to analyzes a specified marker and determines its type based on the presence of certain keywords in the marker name. It then sets the marker's alpha value to 0 and returns relevant data about the marker and its type. 
	
	Parameters: 
		0: OBJECT - The _marker parameter representing the marker to be analyzed. 
		1: SIDE - The _side parameter representing the side associated with the marker. 
		2: SCALAR - The _zoneIndex parameter representing the index of the zone. 
	
	Returns: 
		ARRAY - An array containing the following data: 
			- _zoneIndex: The index of the zone. 
			- _marker: The analyzed marker. 
			- _pos: The position of the marker. 
			- _zoneType: The determined type of the marker. 
			- _side: The side associated with the marker. 
	
	Examples: 
		// Example usage of the script 
		_zoneData = [_marker, _side, _zoneIndex] call F90_fnc_generateZone; 
*/
params ["_marker", "_side", "_zoneIndex"];

private ["_returnData", "_zoneOwner", "_pos", "_zoneType", "_isBase", "_isOutpost", "_isResource", "_isFactory", "_isAirport"];

_pos = markerPos _marker;
_isBase = ["respawn",_marker] call BIS_fnc_inString;
_isOutpost = ["outpost",_marker] call BIS_fnc_inString;
_isResource = ["resource",_marker] call BIS_fnc_inString;
_isFactory = ["factory",_marker] call BIS_fnc_inString;
_isAirport = ["airport",_marker] call BIS_fnc_inString;

if (_isBase) then
{
	_zoneType = "BASE";
};
if (_isOutpost) then
{
	_zoneType = "OUTPOST";
};
if (_isResource) then
{
	_zoneType = "RESOURCE";
};
if (_isFactory) then
{
	_zoneType = "FACTORY";
};
if (_isAirport) then
{
	_zoneType = "AIRPORT";
};

_marker setMarkerAlpha 0;
_returnData = [_zoneIndex, _marker, _pos, _zoneType, _side];

[Garrison_Debug, "generateZone", format ["Done generating data for %1", _marker], true] call F90_fnc_debug;
_returnData;