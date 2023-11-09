/*
	Author: PrinceF90 
 
	Description: 
		This code handles the processing of a zone in the script. It creates a trigger for the zone, sets its properties, and manages the attacker group and cached group information. It also calls the "zoneHandler" function with the zone data and group count. 
	
	Parameter(s): 
		0: ARRAY - The zone data containing information about the zone. 
		1: BOOL - Indicates whether the zone is captured or not. 
		2: GROUP (optional) - The attacker group. 
	
	Returns: 
		None 
	
	Example(s): 
		[[0,"zone_0",[150,150,0],"OUTPOST",west], false] call F90_fnc_createZone;
		[[1,"zone_1",getMarkerPos "zone_1","FACTORY",east], false, _group1] call F90_fnc_createZone;
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