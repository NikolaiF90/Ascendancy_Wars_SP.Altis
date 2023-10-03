params ["_zoneData","_loadCache","_zoneIndex"];
private ["_zoneIcon", "_zoneTriggerArray", "_newpos", "_seized", "_sideAttacker", "_vehType", "_garrisonData", "_colorOwner", "_colorAttacker", "_zoneTextOwner", "_zoneTextAttacker", "_markerDir", "_garrisonSkill", "_zoneType","_attacker","_pref", "_side", "_spawnedGroup", "_minUnitCount", "_units", "_groupSize", "_groupCount", "_groupArray", "_actCondition", "_distance", "_markerType", "_clear", "_zoneOwner", "_playerInZone", "_zoneTrigger", "_debug", "_marker", "_markerPosition", "_markerX", "_markerY"];

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

private _zoneLost = false;

switch (_side) do 
{
	case east: 
	{
		_zoneOwner = "east";
		_colorOwner = "colorOPFOR";
		_zoneTextOwner = format["CSAT %1", _zoneType];
		_seized = "GUER SEIZED";
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
		_seized = "EAST SEIZED";
		_attacker = "EAST";
		_sideAttacker = east;
		_colorAttacker = "colorOPFOR";
		_zoneTextAttacker = format["CSAT %1", _zoneType];
	};
};

// INITIATE ZONE

if (!_loadCache) then 
{
	if (_heightLimit) then 
	{
		_actCondition = "{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
	} else 
	{
		_actCondition = "{vehicle _x in thisList && isPlayer _x} count allUnits > 0";
	};

//	CREATE TRIGGER
	["initZone", format["Creating trigger for zone %1", _zoneIndex]] call F90_fnc_debug;
	_zoneTrigger = createTrigger ["EmptyDetector", _markerPosition];
	_zoneTrigger setTriggerArea [(_distance+_markerX), (_distance+_markerY), _markerDir, false];
	_zoneTrigger setTriggerActivation ["ANY", "PRESENT", true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements [_actCondition, "", ""];
	["initZone", format["Created trigger %1", _zoneTrigger]] call F90_fnc_debug;

//	CREATE ICON 
	["initZone", format["Creating icon for zone %1", _zoneIndex]] call F90_fnc_debug;
	_zoneIcon = [_marker, _zoneType, _side] call F90_fnc_createIcon;
	["initZone", format ["Zone icon created for zone %1", _zoneIndex]] call F90_fnc_debug;

//	ASSIGN TRIGGER AND ICON FOR CACHING
	AWSP_ZoneTrigger set [_zoneIndex, _zoneTrigger];
	AWSP_ZoneIcons set [_zoneIndex, _zoneIcon];
} else {
	["initZone", format["Fetching trigger for zone %1 from AWSP_ZoneTrigger", _zoneIndex]] call F90_fnc_debug;
	_zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
	["initZone", format["Fetched trigger %1", _zoneTrigger]] call F90_fnc_debug;
	["initZone", format["Fetching icon for zone %1 from AWSP_ZoneIcons", _zoneIndex]] call F90_fnc_debug;
	_zoneIcon = AWSP_ZoneIcons # _zoneIndex;
	["initZone", format["Fetched icon for zone %1", _zoneIndex]] call F90_fnc_debug;
};

_marker setMarkerAlpha 0;

switch (_side) do {
	case east:
	{
		_garrisonSkill = AWSP_OPFORSkill;
	};
	case independent:
	{
		_garrisonSkill = AWSP_GUERSkill;
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
		
		if (_loadCache) then 
		{
			_cacheGrp = format ["Infantry%1", _i];
			_units = _zoneTrigger getVariable _cacheGrp;
			_groupSize = _units;
			_minUnitCount = _groupSize;
			["initZone", format ["ID:%1, restored %2 units", _cacheGrp, _units]] call F90_fnc_debug;
		};
		if (_minUnitCount > 0) then {

			_spawnedGroup = [_marker, _side, _groupSize, _garrisonSkill] call F90_fnc_spawnGroup;

			_groupArray set [count _groupArray, _spawnedGroup # 0];
			_groupSize = _spawnedGroup # 1;
		};
	};

	// spawn ALT TRIGGERS
	_clear = createTrigger ["EmptyDetector", _markerPosition];
	_clear setTriggerArea [_markerX, _markerY, _markerDir, false];
	_clear setTriggerActivation [_seized, "PRESENT", true];
	_clear setTriggerStatements ["this", "", ""];
	_playerInZone = true;

	while { _playerInZone } do 
	{
		// if player LEAVES THE AREA
		if (!triggeractivated _zoneTrigger) exitWith {
			// CACHE PATROL INFANTRY
			if (!isnil "_groupArray") then {
				private _index = 0;
				{
					_index = _index + 1;
					_units = {
						alive _x;
					} count units _x;

					_cacheGrp = format ["Infantry%1", _index];
					["initZone", format ["%1 cached %2 units", _cacheGrp, _units]] call F90_fnc_debug;
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
		if (triggerActivated _clear) exitWith 
		{
			// if ZONE CAPTURED, BEGIN CHANGING OWNER
			_groupCount = 0;
			["initZone", format ["%1 owner changed from %2 to %3",_zoneType, _side, _sideAttacker]] call F90_fnc_debug;
			if (_sideAttacker == independent) then 
			{
				["CAPTURED", _zoneType] call F90_fnc_showNotification;
			} else 
			{
				if (_sideAttacker == east) then 
				{
					["LOSS", _zoneType] call F90_fnc_showNotification;
				};
			};
			
			_zoneIcon setMarkerColor _colorAttacker;
			_zoneIcon setMarkerText _zoneTextAttacker;
			_side = _sideAttacker;
			_groupCount = 1;
			_groupSize = [4,4];
			_garrisonData = [_zoneType,_side,_groupCount,_groupSize];
			AWSP_Zones set [_zoneIndex, [_marker,_garrisonData]];
			_zoneLost = true;
		};
		sleep 1;
	};
	deleteVehicle _clear;

	//	If player exit the zone
	if (!(_zoneLost)) exitWith {
		["initZone", format ["Re-init zone %1", _marker]] call F90_fnc_debug;
		null = [[_marker, _pref], true, _zoneIndex] execVM "Init\initZone.sqf";
	};
	if (_zoneLost) exitWith {
		["initZone", format ["%1 captured. Initiliazing new pref", _marker]] call F90_fnc_debug;
		[_zoneIndex] execVM "Scripts\Garrison\clearZones.sqf";
		null = [[_marker, [_zoneType, _side, _groupCount, _groupSize]], false, _zoneIndex] execVM "Init\initZone.sqf";
	};
};