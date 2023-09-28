params ["_zoneData","_cache"];
private ["_newpos", "_cargoType", "_vehType", "_markerDir","_zoneType","_pref", "_side", "_spawnedGroup", "_minUnitCount", "_units", "_groupSize", "_groupCount", "_groupArray", "_triggerKey", "_actCondition", "_distance", "_markerType", "_taken", "_clear", "_zoneOwner", "_faction", "_index", "_isActive", "_zoneTrigger", "_debug", "_marker", "_markerPosition", "_markerX", "_markerY"];

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
	};
	case west:
	{
		_zoneOwner = "west";
	};
	case independent:
	{
		_zoneOwner = "GUER";
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

if (!(_side == independent)) then // if MARKER IS GREEN do not CHANGE COLOUR
{
	_side = _side;
};

_marker setMarkerAlpha 0;
private _iconName = format ["%1_icon", _marker];
private _iconPos = _markerPosition;
private _zoneIcon = createMarker [_iconName, _iconPos];

switch (_zoneType) do 
{
	case "Outpost":
	{
		_zoneIcon setMarkerType "loc_Bunker";
		_zoneIcon setMarkerSize [2,2];
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
		_zoneIcon setMarkerText format["Ally %1", _zoneType];
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
			private _pos = [_markerPosition, 5, 20] call BIS_fnc_findSafePos;
			_spawnedGroup = createGroup _side;
			private _tempGroup = [_pos, _side, _minUnitCount] call BIS_fnc_spawnGroup;
			{
				[_x] joinSilent _spawnedGroup;
			} forEach units _tempGroup;
			_groupArray set [count _groupArray, _spawnedGroup];

			0=[_spawnedGroup, "INFskill"] call eos_fnc_grouphandlers;
			if (_debug) then {
				PLAYER SIDECHAT (format ["Spawned Patrol: %1", _i]);
				0= [_marker, _i, "patrol", getPos (leader _spawnedGroup)] call EOS_debug
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
	_taken setTriggerActivation ["ANY", "PRESENT", true];
	_taken setTriggerStatements ["{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0", "", ""];
	_isActive=true;

	while { _isActive } do {
		// if player LEAVES THE AREA or ZONE DEACTIVATED
		if (!triggeractivated _zoneTrigger || _zoneLost) exitWith {
			if (_debug) then {
				if (!_zoneLost) then {
					hint "Restarting Zone AND deleting units";
				} else {
					hint "EOS zone deactivated";
				};
			};

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

			_isActive=false;
			if (_debug) then {
				hint "Zone Cached";
			};
		};
		if (triggerActivated _clear and triggerActivated _taken) exitWith {
			// if ZONE CAPTURED BEGIN CHECKING for ENEMIES
			_groupCount=0;
			while { triggeractivated _zoneTrigger AND !(_zoneLost) } do {
				if (!triggerActivated _clear) then {
					_marker setMarkerColor "colorOPFOR";
					_marker setMarkerText format ["CSAT%1", _zoneType];
					if (_debug) then {
						hint "Zone Lost";
					};
				} else {
					_marker setMarkerColor "ColorGUER";
					_marker setMarkerText format ["FIA%1", _zoneType];
					if (_debug) then {
						hint "Zone Captured";
					};
				};
				sleep 1;
			};
			// player LEFT ZONE
			_isActive=false;
		};
		sleep 0.5;
	};

	deleteVehicle _clear;
	deleteVehicle _taken;

	if (!(_zoneLost)) then {
		null = [[_marker, _pref], true] execVM "Init\initZone.sqf";
	};
};