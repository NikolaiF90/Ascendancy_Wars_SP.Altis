/*
	Code Description: 
	This function creates a zone icon at the position of the provided marker.
	The type and appearance of the icon depend on the zone type and side parameters. 
	The function returns the created zone icon marker. 
	
	Syntax: 
	[_marker, _zoneType, _side] call F90_fnc_createZoneIcon 
	
	Parameters: 
	- _marker (Marker): The marker object representing the zone. 
	- _zoneType (String): The type of the zone (BASE, OUTPOST, RESOURCE, FACTORY, or AIRPORT). 
	- _side (String): The side of the zone owner (west, east, independent, or civilian). 
	
	Return: 
	- _zoneIcon (Marker): The created zone icon marker.
*/

params ["_marker", "_zoneType", "_side"];

private _iconName = format ["%1_icon", _marker];
private _iconPos = markerPos _marker;
private _zoneIcon = createMarker [_iconName, _iconPos];

switch (_zoneType) do 
{
	case "BASE" : 
	{
		switch (_side) do {
			case west: {_zoneIcon setMarkerType "flag_NATO";};
			case east: {_zoneIcon setMarkerType "flag_CSAT";};
			case independent: {_zoneIcon setMarkerType "flag_EAF";};
			case civilian: {_zoneIcon setMarkerType "flag_Altis";};
		};
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "OUTPOST":
	{
		_zoneIcon setMarkerType "loc_Ruin";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "RESOURCE":
	{
		_zoneIcon setMarkerType "loc_Rock";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "FACTORY":
	{
		_zoneIcon setMarkerType "loc_Power";
		_zoneIcon setMarkerSize [1,1];
	};
	case "AIRPORT":
	{
		_zoneIcon setMarkerType "b_plane";
		_zoneIcon setMarkerSize [1,1];
	};
};

if (_zoneType != "BASE") then 
{
	switch (_side) do 
	{
		case west: 
		{
			_zoneIcon setMarkerColor "colorBLUFOR";
			_zoneIcon setMarkerText format["NATO %1", _zoneType];
		};
		case east:
		{
			_zoneIcon setMarkerColor "colorOPFOR";
			_zoneIcon setMarkerText format["CSAT %1", _zoneType];
			_garrisonSkill = AWSP_OPFORSkill;
		};
		case independent:
		{
			_zoneIcon setMarkerColor "colorGUER";
			_zoneIcon setMarkerText format["AAF %1", _zoneType];
			_garrisonSkill = AWSP_GUERSkill;
		};
		case civilian: 
		{
			_zoneIcon setMarkerColor "colorCIV";
			_zoneIcon setMarkerText format["Civilian %1", _zoneType];
		};
	};
};

[Garrison_Debug,"createIcon",format["Icon created for %1 : %2", _marker, _side],false] call F90_fnc_debug;
_zoneIcon;