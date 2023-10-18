/*
	Code Description: 
	This script creates a zone based on the provided data. 
	It handles the creation of zone triggers, icons, and garrisons. 
	The script continuously checks if players are present in the zone and spawns garrisons accordingly.
	It also handles despawning garrisons when players leave the zone. 
	If the zone becomes empty, it triggers a capture event and creates a capture trigger. 
	The script runs in an infinite loop to continuously manage the zone. 
	
	Syntax: 
	[parameters] spawm F90_fnc_createZone 
	
	Parameters: 
	- _zoneData (Array): An array containing the zone data, including the zone index, marker, position, type, and side. 
	- _isCapturedZone (Boolean): A boolean value indicating if the zone is captured by a specific attacker group. 
	- _attackerGroup (Group): The attacker group that has captured the zone. 
	
	Return: 
	None 
*/
params ["_zoneData", "_isCapturedZone", "_attackerGroup"];

private ["_zoneMarker", "_zonePos", "_zoneType", "_zoneSide", "_zoneSize", "_zoneDirection", "_actCondition", "_zoneTrigger", "_captureTrigger", "_zoneIcon", "_zonePref", "_groupCount", "_groupSize", "_spawned", "_playerInZone", "_cachedGroup", "_garrisons", "_zoneEmpty", "_inCaptureEvent"];

_zoneIndex = _zoneData # 0;
_zoneMarker = _zoneData # 1;
_zonePos = _zoneData # 2;
_zoneType = _zoneData # 3;
_zoneSide = _zoneData # 4;

_zoneSize = getMarkerSize _zoneMarker;
_zoneDirection = markerDir _zoneMarker;

if (Garrison_HeightLimit) then 
{
	_actCondition = "{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
} else 
{
	_actCondition = "{vehicle _x in thisList && isPlayer _x} count allUnits > 0";
};

if (count AWSP_ZoneTrigger > _zoneIndex) then 
{
	_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
};

if (isNil {_zoneTrigger}) then 
{
	_zoneTrigger = createTrigger ["EmptyDetector", _zonePos];
	_zoneTrigger setTriggerArea [(Garrison_SpawnDistance + (_zoneSize # 0)), (Garrison_SpawnDistance + (_zoneSize # 1)), _zoneDirection, true];
	_zoneTrigger setTriggerActivation ["ANY", "PRESENT", true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements [_actCondition, "", ""];
	AWSP_ZoneTrigger set [_zoneIndex, _zoneTrigger];
};

_zoneIcon = [_zoneMarker, _zoneType, _zoneSide] call F90_fnc_createIcon;
AWSP_ZoneIcons set [_zoneIndex, _zoneIcon];

_garrisons = [];
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

_spawned = false;
_zoneEmpty = false;
_inCaptureEvent = false;

while {true} do 
{
	if (isNil "_zoneTrigger") exitWith {["createZone","Player in zone checking has been stopped from being executed as the zone doesn't exist anymore"] call F90_fnc_debug;};

	if (triggerActivated _zoneTrigger) then
	{
		_playerInZone = true;
	}else
	{
		_playerInZone = false;
	};
	
	if (!_spawned && _playerInZone) then 
	{
		_spawned = true;

		if (_groupCount > 0) then 
		{
			_cachedGroup = _zoneTrigger getVariable "Zone_CachedGroup";
			for "_i" from 0 to (count _cachedGroup)-1 do 
			{
				private _unitCount = _cachedGroup # _i;

				["createZone", format["%1 spawned group %2 with %3 units",_zoneMarker, _i, _unitCount]] call F90_fnc_debug;
				private _spawnedGroup = [_zoneMarker, _zoneSide, _unitCount] call F90_fnc_spawnGroup;
				_garrisons set [_i,_spawnedGroup];
			};
			["createZone", format["_garrisons = %1",_garrisons]] call F90_fnc_debug;
		};
	};

	if (!_playerInZone&&_spawned) then 
	{
		// Despawn
		_spawned = false;
		if (count _garrisons > 0) then 
		{
			private _activeGroups = [];
			private _inactiveGroups = [];
			{
				private _activeUnits = [];
				{
					if (!captive _x && alive _x) then 
					{
						_activeUnits pushBack _x;
					};
				}forEach units _x;

				if (count _activeUnits > 0) then 
				{
					_cachedGroup set [_forEachIndex,count _activeUnits];
					_activeGroups pushBack _x;
					{
						deleteVehicle _x;
					} forEach _activeUnits;
					deleteGroup _x;
					["createZone", format["%1 despawned %2 units from group no.%3",_zoneMarker,count _activeUnits, _forEachIndex]] call F90_fnc_debug;
				}else
				{
					_cachedGroup set [_forEachIndex,0];
					_inactiveGroups pushBack _x;
				};
			} forEach _garrisons;
			_cachedGroup = _cachedGroup - [0];
			_garrisons = [];
			_groupCount = count _activeGroups;
			["createZone", format["_cachedGroup = %1", _cachedGroup]] call F90_fnc_debug; 
			_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];
			_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];
		};
	};

	if (_playerInZone && _spawned) then 
	{
		private _activeGroups = [];
		private _inactiveGroups = [];
		{
			private _activeUnits = [];
			{
				if (!captive _x && alive _x) then 
				{
					_activeUnits pushBack _x;
				};
			} forEach units _x;
			if (count _activeUnits > 0) then 
			{
				_activeGroups pushBack _x;
			}else
			{
				_inactiveGroups pushBack _x;
			};
		} forEach _garrisons;
		_garrisons - _inactiveGroups;
		_groupCount = count _activeGroups;
		["createZone", format["Currently there are %1 active groups for %2",_groupCount, _zoneMarker]] call F90_fnc_debug;
	};

	if (_groupCount == 0 && (!_inCaptureEvent)) then 
	{
		_inCaptureEvent = true;
		['DEBUG', 'Creating capture trigger'] call F90_fnc_debug;
		player sideChat 'DEBUG: Creating capture trigger';
		_captureTrigger = createTrigger ["EmptyDetector", _zonePos];
		_captureTrigger setTriggerArea [_zoneSize # 0,_zoneSize # 1, _zoneDirection, true];
		_captureTrigger setTriggerActivation ["ANY", "PRESENT", true];
		_captureTrigger setTriggerTimeout [1, 1, 1, true];
		_captureTrigger setVariable ["Zone_PreviousSide", _zoneSide];
		_captureTrigger setVariable ["Zone_PreviousTrigger", _zoneTrigger];
		_captureTrigger setVariable ["Zone_Index", _zoneIndex];
		_captureTrigger setVariable ["Zone_Marker", _zoneMarker];

		_captureTrigger setTriggerStatements ["this", 
		"thisTrigger setVariable ['Capture_DetectedUnits', thisList];", ""];
		sleep 1;
	};

	if (_inCaptureEvent && !(isNil {_captureTrigger})) then 
	{
		if (triggerActivated _captureTrigger) then 
		{
			['DEBUG', 'TRIGGER EXECUTED'] call F90_fnc_debug;
			player sideChat 'DEBUG: TRIGGER EXECUTED';

			private _oldSide = _zoneSide;
			private _oldTrigger = _zoneTrigger;
			private _index = _zoneIndex;

			private _detectedUnits = _captureTrigger getVariable "Capture_DetectedUnits";
			private _attackers = [];
			private _attacker = objNull;
			
			{
				if ((side _x != civilian)&&(side _x != _oldSide)&&(_x != player)) then 
				{
					_attackers pushBack _x;
				};
			} forEach _detectedUnits;

			if (count _attackers > 0) then
			{
				_attacker = _attackers # 0;
				['DEBUG', format ['attacker found = %1', _attacker]] call F90_fnc_debug;
				private _attackerGroup = group _attacker;

				if (side _attacker == independent) then 
				{
					['CAPTURED', _zoneType] call F90_fnc_showNotification;
				} else 
				{
					if (side _attacker == east) then 
					{
						['LOSS', _zoneType] call F90_fnc_showNotification;
					};
				};

				[_index] spawn F90_fnc_clearZones;
				private _zone = [_zoneMarker, side _attacker, _index] call F90_fnc_generateZone;
				AWSP_Zones set [_index, _zone];
				[AWSP_Zones # _index, true, _attackerGroup] spawn F90_fnc_createZone;
				deleteVehicle _captureTrigger;
			};
		};
	};
	sleep Garrison_CheckInterval -1;
};