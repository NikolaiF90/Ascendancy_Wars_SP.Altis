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
	
	Examples: 
		[[0,"zone_0",[150,150,0],"OUTPOST",west], false] call F90_fnc_createZone;
		[[1,"zone_1",getMarkerPos "zone_1","FACTORY",east], false, _group1] call F90_fnc_createZone;
*/
params ["_zoneData", "_isCapturedZone", "_attackerGroup"];

private ["_zoneIndex", "_zoneMarker", "_zonePos", "_zoneType", "_zoneSide", "_zoneSize", "_zoneDirection", "_zoneTrigger", "_groupSize"];

_zoneIndex = _zoneData # 0;
_zoneMarker = _zoneData # 1;
_zonePos = _zoneData # 2;
_zoneType = _zoneData # 3;
_zoneSide = _zoneData # 4;

if (isNil {_isCapturedZone}) then {_isCapturedZone = false} else {_isCapturedZone = _isCapturedZone};

_zoneSize = getMarkerSize _zoneMarker;
_zoneDirection = markerDir _zoneMarker;

if (count AWSP_ZoneTrigger > _zoneIndex) then 
{
	_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
	if !(isNil {_zoneTrigger}) then {[Garrison_Debug, "createZone", format["Trigger %1 assigned to %2",_zoneTrigger,_zoneMarker], false] call F90_fnc_debug;};
};

if (isNil {_zoneTrigger}) then 
{
	_zoneTrigger = createTrigger ["EmptyDetector", _zonePos];
	_zoneTrigger setTriggerArea [(Garrison_SpawnDistance + (_zoneSize # 0)), (Garrison_SpawnDistance + (_zoneSize # 1)), _zoneDirection, true, 500];
	_zoneTrigger setTriggerActivation ["ANY", "PRESENT", true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements ["{vehicle _x in thisList && isPlayer _x} count allUnits > 0", "", ""];
	AWSP_ZoneTrigger set [_zoneIndex, _zoneTrigger];
	[Garrison_Debug, "createZone", format["Trigger %1 created for %2",_zoneTrigger,_zoneMarker], false] call F90_fnc_debug;
};

private _zoneIcon = [_zoneMarker, _zoneType, _zoneSide] call F90_fnc_createIcon;
AWSP_ZoneIcons set [_zoneIndex, _zoneIcon];

private _zonePref = [_zoneType] call F90_fnc_getPreference;
private _garrisonGroupCount = 0;
private _cachedGroup = [];

if (_isCapturedZone) then 
{
	if (isNil {_attackerGroup}) exitWith {[Garrison_Debug, "createZone", "Script is prevented from running because attackerGroup is nil", true] call F90_fnc_debug};
	private _attackerGroupCount = 1;

	if (_attackerGroup != group player) then 
	{
		if (_attackerGroupCount > 0) then 
		{
			_garrisonGroupCount = _attackerGroupCount;
			private _unitCount = count units _attackerGroup;

			_cachedGroup pushBack _unitCount;

			{
				deleteVehicle _x;
			} forEach units _attackerGroup;
			deleteGroup _attackerGroup;
		};
	};
}else 
{
	_garrisonGroupCount = _zoneTrigger getVariable ["Zone_GroupCount", -1];
	if (_garrisonGroupCount == -1) then 
	{
		_garrisonGroupCount = _zonePref # 0;

		_groupSize = _zonePref # 1;
		_cachedGroup = [];

		if (_garrisonGroupCount > 0) then 
		{
			for "_i" from 0 to _garrisonGroupCount-1 do 
			{
				private _unitCount = floor random [1, _groupSize # 0, _groupSize # 1];
				_cachedGroup set [_i, _unitCount];
			};
		};
	}else 
	{
		_cachedGroup = _zoneTrigger getVariable "Zone_CachedGroup";
	};
};

_zoneTrigger setVariable ["Zone_GroupCount", _garrisonGroupCount];
_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];

[Garrison_Debug, "createZone", format["Zone %1 created with %2 unit(s)",_zoneMarker, (count _cachedGroup)], false] call F90_fnc_debug;

[_zoneData, _garrisonGroupCount] spawn F90_fnc_zoneHandler;