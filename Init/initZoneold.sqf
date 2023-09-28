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
private _initialGroupCount = _infantry # 0;
private _infantryMax = _infantry # 1;
private _initialUnitCount = floor (random _infantryMax + 1);

private _garrisonSkill = 0;
private _zoneActivated = false;

//	Empty Variables
private 
[
	"_activationCondition",
	"_zoneTrigger",
	"_unitCacheArray"
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
		_garrisonSkill = AWSP_OPFORSkill;
	};
	case independent:
	{
		_zoneIcon setMarkerColor "colorGUER";
		_zoneIcon setMarkerText format["Ally %1", _type];
		_garrisonSkill = AWSP_GUERSkill;
	};
	case civilian: 
	{
		_zoneIcon setMarkerColor "colorCIV";
		_zoneIcon setMarkerText format["Civilian %1", _type];
	};
};

waituntil {triggeractivated _zoneTrigger};
["initZone","Trigger activated"] call F90_fnc_debug;
_zoneActivated = true;
_unitCacheArray =  [_zoneTrigger, _initialGroupCount, _type, _zonePos, _side, _garrisonSkill, _marker] spawn F90_fnc_spawnGarrison;

//	Alt Trigger
private _clear = createTrigger ["EmptyDetector",_zonePos];
_clear setTriggerArea [_markerX,_markerY,_markerDir,true];
_clear setTriggerActivation [_side,"NOT PRESENT",true]; 
_clear setTriggerStatements ["this","",""];

private _taken = createTrigger ["EmptyDetector",_zonePos]; 
_taken setTriggerArea [_markerX,_markerY,_markerDir,true];
_taken setTriggerActivation ["ANY","PRESENT",true]; 
_taken setTriggerStatements ["{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0","",""];

while {_zoneActivated} do 
{
	if (!triggerActivated _zoneTrigger) exitWith 
	{
		private _aliveGroupCount = 0;
		//	Cache infantry
		if (!isNil "_unitCacheArray") then 
		{
			_aliveGroupCount = count _unitCacheArray;
			private _i = 0;

			{
				_i = _i + 1;
				private _aliveUnits = {alive _x} count units _x;

				if (_aliveUnits == 0) then 
				{
					_aliveGroupCount = _aliveGroupCount - 1;
				}else 
				{
					private _key = format ["_garrisonGroup%1", _i];
					_zoneTrigger setVariable [_key, _aliveUnits];
					["initZone", format ["ID: %1 cached: %2 units", _key, _aliveUnits]] call F90_fnc_debug;
				};

				{
					deleteVehicle _x;
				} forEach units _x;
				deleteGroup _x;

			} forEach _unitCacheArray;
		};
		_zoneActivated = false;
		_zoneTrigger setVariable ["cachedGroupCount", _aliveGroupCount];
		["initZone", "Zone Cached"] call F90_fnc_debug;
	};

	if (triggerActivated _clear && triggerActivated _taken) exitWith 
	{
		_initialGroupCount = 0;
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

