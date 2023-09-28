/*
	Script to create zone at given marker position with given data
*/
params ["_zone", "_cache"];

["initZone", "Initializing zones"] call F90_fnc_debug;

private _marker = _zone # 0; 
private _markerSize = getMarkerSize _marker;
private _markerX = _markerSize # 0;
private _markerY = _markerSize # 1;
private _zonePos = markerPos _marker;
private _markerDir = markerDir _marker;

private _data = _zone # 1;
private _type = _data # 0;
private _side = _data # 1;

private _infantry = _data # 2;
private _infantryGroup = _infantry # 0;
private _infantryMax = _infantry # 1;
private _infantryCount = floor (random _infantryMax + 1);

private _car = _data # 3;
private _carGroup = _car # 0;
private _carMax = _car # 1;
private _carCount = floor (random _carMax + 1);

private _tank = _data # 4;
private _tankGroup = _tank # 0;
private _tankMax = _tank # 1;
private _tankCount = floor (random _tankMax + 1);

private _static = _data # 5;
private _staticGroup = _static # 0;
private _staticMax = _static # 1;
private _staticCount = floor (random _staticMax + 1);

private _carPools = [];
private _tankPools = [];

private _garrisonSkill = 0;
private _zoneActivated = false;

//	Empty Variables
private 
[
	"_activationCondition",
	"_zoneTrigger",
	"_infantryCacheGroup",
	"_carGrp",
	"_tankGrp",
	"_staticGrp"
];

_trig = format ["F90Trigger%1", _marker];

if (!_cache) then
{
	if (AWSP_HeightLimit) then 
	{
		_activationCondition = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
	}else
	{
		_activationCondition = "{vehicle _x in thisList && isplayer _x} count allUnits > 0";
	};

	["initZone", format ["Creating trigger for %1", _marker]] call F90_fnc_debug;
	_zoneTrigger = createTrigger ["EmptyDetector",_zonePos]; 
	_zoneTrigger setTriggerArea [(AWSP_GarrisonSpawnDistance + _markerX), (AWSP_GarrisonSpawnDistance + _markerY), _markerDir, true]; 
	_zoneTrigger setTriggerActivation ["ANY","PRESENT",true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements [_activationCondition,"",""];
	["initZone", "Trigger created"] call F90_fnc_debug;

	AWSP_GARRISON setvariable [_trig,_zoneTrigger];
} else 
{
	_zoneTrigger = AWSP_GARRISON getVariable _trig;	
};

_marker setMarkerAlpha 0;
private _iconName = format ["%1_icon", _marker];
private _iconPos = _zonePos;
private _zoneIcon = createMarker [_iconName, _iconPos];

switch (_type) do 
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
		_zoneIcon setMarkerText format["NATO %1", _type];
	};
	case east:
	{
		_zoneIcon setMarkerColor "colorOPFOR";
		_zoneIcon setMarkerText format["CSAT %1", _type];
		_carPools = AWSP_OPFORCars;
		_tankPools = AWSP_OPFORTanks;
		_garrisonSkill = AWSP_OPFORSkill;
	};
	case independent:
	{
		_zoneIcon setMarkerColor "colorGUER";
		_zoneIcon setMarkerText format["Ally %1", _type];
		_carPools = AWSP_GUERCars;
		_tankPools = AWSP_GUERTanks;
		_garrisonSkill = AWSP_GUERSkill;
	};
	case civilian: 
	{
		_zoneIcon setMarkerColor "colorCIV";
		_zoneIcon setMarkerText format["Civilian %1", _type];
	};
};

waituntil {triggeractivated _zoneTrigger};

//	Spawn Infantry 
for "_i" from 1 to _infantryGroup do 
{
	if (isNil "_infantryCacheGroup") then {_infantryCacheGroup = []};
	if (_cache) then
	{
		private _key = format ["%1Infantry%2",_type, _i];
		private _unitCount = _zoneTrigger getvariable _key;
		_infantryCount = _unitCount;
		["initZone", format ["ID: %1 restored: %2 units", _key, _infantryCount]] call F90_fnc_debug;
	};

	if (_infantryCount > 0) then 
	{
		["initZone", format["Creating %1Infantry%2", _type, _i]] call F90_fnc_debug;
		private _spawnedGroup =[_zonePos,_infantryCount,_side] call F90_fnc_spawnGroup;
		private _group = _spawnedGroup # 0;
		private _groupUnits = _spawnedGroup # 1;
		private _leader = _groupUnits # 0;
		{
			_x setSkill _garrisonSkill;
		} forEach _groupUnits;

		[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;
		_infantryCacheGroup pushback _group;

		["initZone", format["Infantry%1 spawned", _i]] call F90_fnc_debug;
	};
};

if (_carGroup > 0) then 
{
	for "_i" from 1 to _carGroup do 
	{
		if(isNil "_carGrp") then {_carGrp = []};

		private _spawnedGroup = [_carPools, _zonePos, _markerDir, _side, _carCount] call F90_fnc_spawnVehicle;
		private _group = _spawnedGroup # 0;
		private _groupUnits = _spawnedGroup # 1;
		private _leader = _groupUnits # 0;
		{
			_x setSkill _garrisonSkill;
		} forEach _groupUnits;

		[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;
		_carGrp pushBack _group;
		["initZone", format["_carGrp = %1", _carGrp]] call F90_fnc_debug;
		["initZone", format["Car%1 spawned", _i]] call F90_fnc_debug;
	};
}else
{
	_carGrp = [];
	["initZone", "No cars to spawned"] call F90_fnc_debug;
};

if (_tankGroup > 0) then 
{
	for "_i" from 1 to _tankGroup do 
	{
		if(isNil "_tankGrp") then {_tankGrp = []};

		private _spawnedGroup = [_tankPools, _zonePos, _markerDir, _side, _tankCount] call F90_fnc_spawnVehicle;
		private _group = _spawnedGroup # 0;
		private _groupUnits = _spawnedGroup # 1;
		private _leader = _groupUnits # 0;

		{
			_x setSkill _garrisonSkill;
		} forEach _groupUnits;

		[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;
		_tankGrp pushBack _group;

		["initZone", format["Armour%1 spawned", _i]] call F90_fnc_debug;
	};
}else
{
	_tankGrp = [];
	["initZone", "No armour to spawn"] call F90_fnc_debug;
};

if (_staticGroup > 0) then 
{
	if(isNil "_staticGrp") then {_staticGrp = []};
	private _spawnedGroup = [_marker, _staticGroup, _side, _garrisonSkill, _staticGrp] call F90_fnc_spawnStatic;
	_staticGrp pushBack _spawnedGroup;
}else 
{
	_staticGrp = [];
	["initZone", "No static to spawned"] call F90_fnc_debug;
};

//	Alt Trigger
private _clear = createTrigger ["EmptyDetector",_zonePos];
_clear setTriggerArea [_markerX,_markerY,_markerDir,true];
_clear setTriggerActivation [_side,"NOT PRESENT",true]; 
_clear setTriggerStatements ["this","",""];

private _taken = createTrigger ["EmptyDetector",_zonePos]; 
_taken setTriggerArea [_markerX,_markerY,_markerDir,true];
_taken setTriggerActivation ["ANY","PRESENT",true]; 
_taken setTriggerStatements ["{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0","",""];

_zoneActivated = true;

while {_zoneActivated} do 
{
	if (!triggerActivated _zoneTrigger) exitWith 
	{

		//	Cache function 
		

		//	Cache infantry
		if (!isNil "_infantryCacheGroup") then 
		{
			private _i = 0;

			{
				_i = _i + 1;
				private _aliveUnits = {alive _x} count units _x;
				private _key = format ["%1Infantry%2", _type, _i];

				["initZone", format ["ID: %1 cached: %2 units", _key, _infantryCount]] call F90_fnc_debug;
				_zoneTrigger setVariable [_key, _aliveUnits];

				{
					deleteVehicle _x;
				} forEach units _x;
				deleteGroup _x;

			} forEach _infantryCacheGroup;
		};

		//	Cache cars 
		if (!isNil "_carGrp") then
		{
			{
				private _vehicle = _x # 0;
				private _crew = _x # 1;
				private _group = _x # 2;

				if (!alive _vehicle || {!alive _x} forEach _crew) then 
				{
					_carGroup = _carGroup - 1;
				};

				{
					deleteVehicle _x;
				} forEach _crew;

				if (!(vehicle player == _vehicle)) then 
				{
					{
						deleteVehicle _x;
					} forEach _vehicle;
				};

				{
					deleteVehicle _x;
				} forEach units _group;
				deleteGroup _group;
			} forEach _carGrp;
		};

		//	Cache tanks
		if (!isNil "_tankGrp") then
		{
			{
				private _vehicle = _x # 0;
				private _crew = _x # 1;
				private _group = _x # 2;

				if (!alive _vehicle || {!alive _x} forEach _crew) then 
				{
					_tankGroup = _tankGroup - 1;
				};

				{
					deleteVehicle _x;
				} forEach _crew;

				if (!(vehicle player == _vehicle)) then 
				{
					{
						deleteVehicle _x;
					} forEach _vehicle;
				};

				{
					deleteVehicle _x;
				} forEach units _group;
				deleteGroup _group;
			} forEach _tankGrp;
		};

		//	Cache statics
		if (!isNil "_staticGrp") then
		{
			{
				private _vehicle = _x # 0;
				private _crew = _x # 1;
				private _group = _x # 2;

				if (!alive _vehicle || {!alive _x} forEach _crew) then 
				{
					_staticGroup = _staticGroup - 1;
				};

				{
					deleteVehicle _x;
				} forEach _crew;

				if (!(vehicle player == _vehicle)) then 
				{
					{
						deleteVehicle _x;
					} forEach _vehicle;
				};

				{
					deleteVehicle _x;
				} forEach units _group;
				deleteGroup _group;
			} forEach _staticGrp;
		};

		_zoneActivated = false;
		["initZone", "Zone Cached"] call F90_fnc_debug;
	};

	if (triggerActivated _clear && triggerActivated _taken) exitWith 
	{
		_infantryGroup = 0;
		_carGroup = 0;
		_tankGroup = 0;
		_staticGroup = 0;

		while {triggerActivated _zoneTrigger} do 
		{
			if (!triggerActivated _clear) then 
			{
				_marker setMarkerColor "colorOPFOR";
				hint format ["CSAT has captured your %1", _type];
				
			} else 
			{
				_marker setMarkerColor "colorGUER";
				hint format ["You have captured CSAT's %1", _type];
			};
			sleep 1;
		};
		_zoneActivated = false;
	};
	sleep 0.5;
};

deletevehicle _clear;deletevehicle _taken;

