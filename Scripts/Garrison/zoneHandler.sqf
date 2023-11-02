/*
	Handler that handles zoning and garrison system (ZAGS)
*/
params ["_zoneData", "_groupCount"];

private ["_zoneTrigger", "_zoneIndex", "_zoneMarker", "_zonePos", "_zoneType", "_zoneSide", "_zoneSize", "_zoneDirection", "_zoneUnderAttack", "_playerInZone", "_spawned", "_shouldSpawn", "_cachedGroup", "_garrisons", "_inCaptureEvent", "_enemyDetector", "_enemyDetector2", "_captureChecker", "_captureTrigger", "_reinforcementSent", "_detectorConfigured"];

_zoneIndex = _zoneData # 0;
_zoneMarker = _zoneData # 1;
_zonePos = _zoneData # 2;
_zoneType = _zoneData # 3;
_zoneSide = _zoneData # 4;

_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
_zoneSize = getMarkerSize _zoneMarker;
_zoneDirection = markerDir _zoneMarker;

_spawned = false;
_garrisons = [];
_inCaptureEvent = false;
_reinforcementSent = -1;

_enemyDetector = createTrigger ["EmptyDetector", _zonePos];
_enemyDetector2 = createTrigger ["EmptyDetector", _zonePos];
_detectorConfigured = false;

while {true} do 
{
	if (isNil "_zoneTrigger") exitWith {["createZone","Player in zone checking has been stopped from being executed as the zone doesn't exist anymore"] call F90_fnc_debug;};

	_zoneUnderAttack = _zoneTrigger getVariable ["Zone_UnderAttack", false];
	if (triggerActivated _zoneTrigger) then
	{
		_playerInZone = true;
	}else
	{
		_playerInZone = false;
	};

	if (_playerInZone == true || _zoneUnderAttack == true) then 
	{
		_shouldSpawn = true;
	} else 
	{
		_shouldSpawn = false;
	};
	
	if (!_spawned && _shouldSpawn) then 
	{
		_spawned = true;

		if (_groupCount > 0) then 
		{
			_cachedGroup = _zoneTrigger getVariable "Zone_CachedGroup";

			if (count _cachedGroup > 0) then 
			{
				for "_i" from 0 to (count _cachedGroup)-1 do 
				{
					private _unitCount = _cachedGroup # _i;

					["createZone", format["%1 spawned group %2 with %3 units",_zoneMarker, _i, _unitCount]] call F90_fnc_debug;
					private _spawnedGroup = [_zoneMarker, _zoneSide, _unitCount] call F90_fnc_spawnGroup;
					_garrisons set [_i,_spawnedGroup];
				};
			}
		};
	};

	if (!_shouldSpawn&&_spawned) then 
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
			_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];
			_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];
		};
	};

	if (_shouldSpawn && _spawned) then 
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
	};

	if !(_detectorConfigured) then 
	{
		// Configure enemy detector 
		_enemyDetector setTriggerArea [(_zoneSize # 0) + Garrison_ThreatRange, (_zoneSize # 1) + Garrison_ThreatRange, _zoneDirection, true, 300];
		_enemyDetector setTriggerTimeout [1,1,1,true];
		_enemyDetector setTriggerStatements ["this", "", ""];

		switch (_zoneSide) do 
		{
			case west: 
			{
				_enemyDetector setTriggerActivation ["EAST", "EAST D", true];
			};
			case east: 
			{
				_enemyDetector setTriggerActivation ["GUER", "GUER D", true];

				// Configure second detector to detect blufor 
				_enemyDetector2 setTriggerArea [(_zoneSize # 0) + Garrison_ThreatRange, (_zoneSize # 1) + Garrison_ThreatRange, _zoneDirection, true, 300];
				_enemyDetector2 setTriggerTimeout [1,1,1,true];
				_enemyDetector2 setTriggerStatements ["this", "", ""];
				_enemyDetector2 setTriggerActivation ["WEST", "WEST D", true];
			};
			case independent: 
			{
				_enemyDetector setTriggerActivation ["EAST", "EAST D", true];
			};
		};
		_detectorConfigured = true;
	};

	if (triggerActivated _enemyDetector || triggerActivated _enemyDetector2) then 
	{
		if (_zoneSide == east && _reinforcementSent == -1) then 
		{
			_reinforcementSent = 1;

			// If detected enemies is independent
			if (triggerActivated _enemyDetector) then 
			{
				CDARS_GUERActivity = CDARS_GUERActivity + 5;
			};

			// If detected enemies is west
			if (triggerActivated _enemyDetector2) then 
			{
				CDARS_BLUFORActivity = CDARS_BLUFORActivity + 5;
			};
		};
	};

	if (_groupCount == 0 && (!_inCaptureEvent)) then 
	{
		_inCaptureEvent = true;
		_spawned = false;

		_captureChecker = createTrigger ["EmptyDetector", _zonePos];
		_captureChecker setTriggerArea [(Garrison_SpawnDistance + (_zoneSize # 0)), (Garrison_SpawnDistance + (_zoneSize # 1)), _zoneDirection, true];
		switch (_zoneSide) do 
		{
			case west: 
			{
				_captureChecker setTriggerActivation ["WEST", "NOT PRESENT", true];
			};
			case east: 
			{
				_captureChecker setTriggerActivation ["EAST", "NOT PRESENT", true];
			};
			case independent: 
			{
				_captureChecker setTriggerActivation ["GUER", "NOT PRESENT", true];
			};
		};
		_captureChecker setTriggerTimeout [1, 1, 1, true];
		_captureTrigger setTriggerStatements ["this", "", ""];

		_captureTrigger = createTrigger ["EmptyDetector", _zonePos];
		_captureTrigger setTriggerArea [_zoneSize # 0,_zoneSize # 1, _zoneDirection, true, 5];
		_captureTrigger setTriggerActivation ["ANY", "PRESENT", true];
		_captureTrigger setTriggerTimeout [1, 1, 1, true];
		_captureTrigger setVariable ["Zone_PreviousSide", _zoneSide];
		_captureTrigger setVariable ["Zone_PreviousTrigger", _zoneTrigger];
		_captureTrigger setVariable ["Zone_Index", _zoneIndex];
		_captureTrigger setVariable ["Zone_Marker", _zoneMarker];

		_captureTrigger setTriggerStatements ["this", "thisTrigger setVariable ['Capture_DetectedUnits', thisList];", ""];
	};

	if (_reinforcementSent == 1 && _zoneSide == east) then 
	{
		_reinforcementSent = 0;
		["SEND_REINFORCEMENT", _zoneIndex] spawn F90_fnc_eastCommanderHandler;
	};

	if (_inCaptureEvent && !(isNil {_captureTrigger})) then 
	{
		if (triggerActivated _captureTrigger && triggerActivated _captureChecker) then 
		{
			private _oldSide = _zoneSide;
			private _oldTrigger = _zoneTrigger;

			private _detectedUnits = _captureTrigger getVariable "Capture_DetectedUnits";
			private _attackers = [];
			private _attacker = objNull;
			
			{
				if ((side _x != civilian)&&!(isPlayer _x)&&!(captive _x)) then 
				{
					_attackers pushBack _x;
				};
			} forEach _detectedUnits;

			if (count _attackers > 0) then
			{
				_attacker = _attackers # 0;
				private _attackerGroup = group _attacker;

				if (side _attacker == independent) then 
				{
					['CAPTURED', _zoneType] call F90_fnc_showNotification;
					CDARS_GUERActivity = CDARS_GUERActivity + 10;
				} else 
				{
					if (_zoneSide == independent && side _attacker == east) then 
					{
						['LOSS', _zoneType] call F90_fnc_showNotification;
					};
				};

				[_zoneIndex] call F90_fnc_clearZones;
				private _zone = [_zoneMarker, side _attacker, _zoneIndex] call F90_fnc_generateZone;
				AWSP_Zones set [_zoneIndex, _zone];
				[AWSP_Zones # _zoneIndex, true, _attackerGroup] call F90_fnc_createZone;
				deleteVehicle _captureChecker;
				deleteVehicle _captureTrigger;
			};
		};
	};
	sleep Garrison_CheckInterval;
};