/*
	Code Description: 
	A script that manages zones. It handles the spawning and despawning of groups within zones based on player presence, captures, and reinforcements. 
	The script also includes functionality for creating triggers, setting variables, and generating zones. 
	
	Syntax: 
	As this is a script rather than a function, it does not have a specific syntax for calling it.
	Instead, the script needs to be executed within the game scenario or called from another script using the  execVM  command.
	Just in case you still wanted to use it as a function, you should use spawn instead.
	[parameters] spawn F90_fnc_createZone 
	
	Parameters: 
	- _zoneData (Array): An array containing the zone data, including the zone index, marker, position, type, side and size. 
	- _isCapturedZone (Boolean): A boolean value indicating if the zone is captured by a specific attacker group. 
	- _attackerGroup (Group): The attacker group that has captured the zone. It could be an AI group or a player-controlled group. 
	- _respawnGroup (Boolean): Optional. A boolean value determining whether the group associated with the zone should respawn(at start) or not.
	
	Return: 
	None  
*/
params ["_zoneData", "_isCapturedZone", "_attackerGroup"];

private ["_zoneMarker", "_zonePos", "_zoneType", "_zoneSide", "_zoneSize", "_zoneDirection", "_zoneTrigger", "_zoneIcon", "_zonePref", "_groupCount", "_groupSize", "_cachedGroup"];

_zoneIndex = _zoneData # 0;
_zoneMarker = _zoneData # 1;
_zonePos = _zoneData # 2;
_zoneType = _zoneData # 3;
_zoneSide = _zoneData # 4;

_zoneSize = getMarkerSize _zoneMarker;
_zoneDirection = markerDir _zoneMarker;

_safeToCapture = false;

if (count AWSP_ZoneTrigger > _zoneIndex) then 
{
	_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
};

if (isNil {_zoneTrigger}) then 
{
	_zoneTrigger = createTrigger ["EmptyDetector", _zonePos];
	_zoneTrigger setTriggerArea [(Garrison_SpawnDistance + (_zoneSize # 0)), (Garrison_SpawnDistance + (_zoneSize # 1)), _zoneDirection, true, 500];
	_zoneTrigger setTriggerActivation ["ANY", "PRESENT", true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements ["{vehicle _x in thisList && isPlayer _x} count allUnits > 0", "", ""];
	AWSP_ZoneTrigger set [_zoneIndex, _zoneTrigger];
};

_zoneIcon = [_zoneMarker, _zoneType, _zoneSide] call F90_fnc_createIcon;
AWSP_ZoneIcons set [_zoneIndex, _zoneIcon];

_zonePref = [_zoneType] call F90_fnc_getPreference;

if (_isCapturedZone) then 
{
	if (!isNil "_attackerGroup") then 
	{
		if (_attackerGroup != group player) then 
		{
			_groupCount = 1;
			_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];
			
			_cachedGroup = [];
			if (_groupCount > 0) then 
			{
				private _unitCount = count units _attackerGroup;

				_cachedGroup set [0, _unitCount];
				_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];
			};

			{
				deleteVehicle _x;
			} forEach units _attackerGroup;
			deleteGroup _attackerGroup;
		}else
		{
			_groupCount = 0;
			_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];
			_cachedGroup = [];
		};
	};
}else 
{
	_groupCount = _zoneTrigger getVariable ["Zone_GroupCount", -1];
	if (_groupCount == -1) then 
	{
		_groupCount = _zonePref # 0;
		_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];

		_groupSize = _zonePref # 1;
		_cachedGroup = [];

		if (_groupCount > 0) then 
		{
			
			for "_i" from 0 to _groupCount-1 do 
			{
				private _unitCount = floor random [1, _groupSize # 0, _groupSize # 1];
				_cachedGroup set [_i, _unitCount];
			};
			_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];
		};
	};
};

[_zoneData, _groupCount] spawn F90_fnc_zoneHandler;