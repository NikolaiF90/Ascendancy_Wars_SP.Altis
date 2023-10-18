/*
	Code Description: 
	This function generates a garrison preference for a zone based on the provided zone type. 
	It takes one parameter, "_zoneType", which represents the type of the zone. 
	The function determines the number of groups and the size of each group based on the zone type. 
	The group count and group size are stored in an array, "_preference", and returned as the result. 
	
	Syntax: 
	[parameters] call F90_fnc_getPreference 
	
	Parameters: 
	- _zoneType (String): The type of the zone for which the garrison preference is generated. 
	
	Return: 
	- _preference (Array): An array containing the garrison preference for the zone. The array has two elements: 
	- Element 0: The number of groups for the garrison. 
	- Element 1: An array representing the group size. 
				-The first index is the usual unit count per group
				-The second index is the maximum unit count per group. 
*/
params ["_zoneType"];

private _preference = [];
private _groupCount = 0;
private _groupSize = [];

switch (_zoneType) do 
{
	case "BASE":
	{
		_groupCount = 5;
		_groupSize = [8,12];
	};
	case "OUTPOST":
	{
		_groupCount = 3;
		_groupSize = [5,8];
	};
	case "RESOURCE":
	{
		_groupCount = 2;
		_groupSize = [4,7];
	};
	case "FACTORY":
	{
		_groupCount = 3;
		_groupSize = [4,7];
	};
	case "AIRPORT":
	{
		_groupCount = 4;
		_groupSize = [5,7];
	};
};
_preference pushback _groupCount;
_preference pushback _groupSize;

_preference;