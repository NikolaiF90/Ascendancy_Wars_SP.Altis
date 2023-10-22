/*
	Function Description: 
	Function that finds the garrisons within a specified range from a given list of garrisons. 
	It creates an array with the nearest garrisons and returns it as the output. 
	
	Syntax: 
	[_range, _garrisonList, _blacklist] call F90_fnc_findNearestGarrisons; 
	
	Parameters: 
	- _range: The range within which to find the nearest garrisons. 
	- _garrisonList: The list of garrisons to search from. 
	- _blacklist: Optional. A list of garrisons to exclude from the search. 
	
	Return: 
	The function returns an array of nearest garrisons. If no garrisons are found within the specified range, it returns an empty array. 
*/
params ["_range", "_garrisonList", "_blacklist"];

private _nearestGarrisons = [];

_garrisonList = _garrisonList - _blacklist;
{
	private _distance = _x # 5;
	if (_distance <= _range) then 
	{
		_nearestGarrisons pushBack _x;
	};
} forEach _garrisonList;

_nearestGarrisons;
