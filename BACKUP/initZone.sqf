params ["_zoneData","_cache","_zoneIndex"];
private ["_newpos", "_cargoType", "_sideAttacker", "_vehType", "_garrisonData", "_colorOwner", "_colorAttacker", "_zoneTextOwner", "_zoneTextAttacker", "_markerDir", "_garrisonSkill", "_zoneType","_attacker","_pref", "_side", "_spawnedGroup", "_minUnitCount", "_units", "_groupSize", "_groupCount", "_groupArray", "_triggerKey", "_actCondition", "_distance", "_markerType", "_taken", "_clear", "_zoneOwner", "_faction", "_index", "_playerInZone", "_zoneTrigger", "_debug", "_marker", "_markerPosition", "_markerX", "_markerY"];

_marker = _zoneData # 0;
_markerPosition = markerPos _marker;
_markerX = getMarkerSize _marker select 0;
_markerY = getMarkerSize _marker select 1;
_markerDir = markerDir _marker;

_pref = _zoneData # 1;
_zoneType = _pref # 0;
_side = _pref # 1;

_groupCount = _pref # 2;
_groupSize = _pref # 3;
_minUnitCount = _groupSize # 0;

_distance = AWSP_GarrisonSpawnDistance;
_heightLimit = AWSP_HeightLimit;

_debug = F90_debug;

["initZone", format["Creating %1", _marker]] call F90_fnc_debug;

private _zoneLost = false;
switch (_side) do 
{
	case east: 
	{
		_zoneOwner = "east";
		_colorOwner = "colorOPFOR";
		_zoneTextOwner = format["CSAT %1", _zoneType];
		_attacker = "GUER";
		_sideAttacker = independent;
		_colorAttacker = "colorGUER";
		_zoneTextAttacker = format["LDF %1", _zoneType];
	};
	case west:
	{
		_zoneOwner = "west";
		_colorOwner = "colorBLUFOR";
		_zoneTextOwner = format["NATO %1", _zoneType];
	};
	case independent:
	{
		_zoneOwner = "GUER";
		_colorOwner = "colorGUER";
		_zoneTextOwner = format["LDF %1", _zoneType];
		_attacker = "east";
		_sideAttacker = east;
		_colorAttacker = "colorOPFOR";
		_zoneTextAttacker = format["CSAT %1", _zoneType];
	};
};

// INITIATE ZONE
_triggerKey = format ["AWSP_%1Trigger", _marker];

if (!_cache) then 
{
	if (_heightLimit) then 
	{
		_actCondition = "{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
	} else 
	{
		_actCondition = "{vehicle _x in thisList && isPlayer _x} count allUnits > 0";
	};

	_zoneTrigger = createTrigger ["EmptyDetector", _markerPosition];
	_zoneTrigger setTriggerArea [(_distance+_markerX), (_distance+_markerY), _markerDir, false];
	_zoneTrigger setTriggerActivation ["ANY", "PRESENT", true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements [_actCondition, "", ""];

	AWSP_GARRISON setVariable [_triggerKey, _zoneTrigger];
} else {
	_zoneTrigger = AWSP_GARRISON getVariable _triggerKey;
};

_marker setMarkerAlpha 0;
private _iconName = format ["%1_icon", _marker];
private _iconPos = _markerPosition;
private _zoneIcon = createMarker [_iconName, _iconPos];

switch (_zoneType) do 
{
	case "Outpost":
	{
		_zoneIcon setMarkerType "loc_Ruin";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "Resource":
	{
		_zoneIcon setMarkerType "loc_Rock";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "Factory":
	{
		_zoneIcon setMarkerType "loc_Power";
		_zoneIcon setMarkerSize [1,1];
	};
	case "Airport":
	{
		_zoneIcon setMarkerType "b_plane";
		_zoneIcon setMarkerSize [1,1];
	};
};


switch (_side) do {
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
		_zoneIcon setMarkerText format["LDF %1", _zoneType];
		_garrisonSkill = AWSP_GUERSkill;
	};
	case civilian: 
	{
		_zoneIcon setMarkerColor "colorCIV";
		_zoneIcon setMarkerText format["Civilian %1", _zoneType];
	};
};

waitUntil {triggerActivated _zoneTrigger};// WAIT UNTIL PLAYERS in ZONE
if (!_zoneLost) then 
{
	// spawn PATROLS
	for "_i" from 1 to _groupCount do 
	{
		if (isnil "_groupArray") then 
		{
			_groupArray=[];
		};
		
		if (_cache) then 
		{
			_cacheGrp = format ["Infantry%1", _i];
			_units = _zoneTrigger getVariable _cacheGrp;
			_groupSize = [_units, _units];
			_minUnitCount = _groupSize select 0;
			if (_debug) then {
				player sidechat format ["ID:%1, restore - %2", _cacheGrp, _units];
			};
		};
		if (_minUnitCount > 0) then {

			_spawnedGroup = [_marker, _side, _groupSize, _garrisonSkill] call F90_fnc_spawnGroup;

			_groupArray set [count _groupArray, _spawnedGroup # 0];
			_groupSize = _spawnedGroup # 1;
			if (_debug) then 
			{
				PLAYER SIDECHAT (format ["Spawned Patrol: %1", _i]);
			};
		};
	};

	// spawn ALT TRIGGERS
	_clear = createTrigger ["EmptyDetector", _markerPosition];
	_clear setTriggerArea [_markerX, _markerY, _markerDir, false];
	_clear setTriggerActivation [_zoneOwner, "NOT PRESENT", true];
	_clear setTriggerStatements ["this", "", ""];
	_taken = createTrigger ["EmptyDetector", _markerPosition];
	_taken setTriggerArea [_markerX, _markerY, _markerDir, false];
	_taken setTriggerActivation [_attacker, "PRESENT", true];
	_taken setTriggerStatements ["{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0", "", ""];
	_playerInZone = true;

	while { _playerInZone } do {
		// if player LEAVES THE AREA or ZONE DEACTIVATED
		if (!triggeractivated _zoneTrigger || _zoneLost) exitWith {
			// CACHE PATROL INFANTRY
			if (!isnil "_groupArray") then {
				_index=0;
				{
					_index = _index + 1;
					_units = {
						alive _x
					} count units _x;
					_cacheGrp = format ["Infantry%1", _index];
					if (_debug) then {
						player sidechat format ["ID:%1, cache - %2", _cacheGrp, _units];
					};
					_zoneTrigger setVariable [_cacheGrp, _units];
					{
						deleteVehicle _x;
					} forEach units _x;
					deleteGroup _x;
				}forEach _groupArray;
			};

			_playerInZone = false;
			if (_debug) then {
				hint "Zone Cached";
			};
		};
		if (triggerActivated _clear and triggerActivated _taken) exitWith 
		{
			// if ZONE CAPTURED BEGIN CHANGING OWNER
			_groupCount = 0;
			player sideChat format ["Zone owner changed from %1 to %2", _side, _sideAttacker];
			["initZone", format ["Zone owner changed from %1 to %2", _side, _sideAttacker]] call F90_fnc_debug;
			_zoneIcon setMarkerColor _colorAttacker;
			_zoneIcon setMarkerText _zoneTextAttacker;

			while { triggeractivated _zoneTrigger AND !(_zoneLost) } do {
				if (!triggerActivated _clear) then {
					_zoneIcon setMarkerColor _colorOwner;
					_zoneIcon setMarkerText _zoneTextOwner;
				} else {
					/*
					
					
					
					
					_side = _sideAttacker;
					_groupCount = 1;
					_groupSize = [4,4];
					_garrisonData = [_zoneType,_side,_groupCount,_groupSize];
					AWSP_Zones set [_zoneIndex, [_marker,_garrisonData]];
					*/
				};
				sleep 1;
			};
			// player LEFT ZONE
			_playerInZone = false;
		};
		sleep 0.5;
	};

	deleteVehicle _clear;
	deleteVehicle _taken;

	if (!(_zoneLost)) then {
		player sideChat "Re-init zone";
		["initZone", "Re-init zone"] call F90_fnc_debug;
		null = [[_marker, [_zoneType,_side,_groupCount,_groupSize]], true, _zoneIndex] execVM "Init\initZone.sqf";
	};
};