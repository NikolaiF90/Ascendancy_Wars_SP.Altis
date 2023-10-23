/*
	Code Description: 
	This function generates an empty zone at the provided marker's position. 
	It determines the type of the zone based on specific keywords found in the marker name, such as "outpost", "resource", "factory", or "airport". 
	The generated zone will have its marker alpha set to 0, making it invisible. 
	
	Syntax: 
	[marker] call F90_fnc_generateZone 
	
	Parameters: 
	- _marker (Marker): The marker object representing the zone. 
	
	Return: 
	- _returnData (Array): An array containing the marker object, position, and zone type. 
*/
params ["_marker", "_side", "_zoneIndex"];

private ["_returnData", "_zoneOwner", "_pos", "_zoneType", "_isBase", "_isOutpost", "_isResource", "_isFactory", "_isAirport", "_trigger"];

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
_returnData;