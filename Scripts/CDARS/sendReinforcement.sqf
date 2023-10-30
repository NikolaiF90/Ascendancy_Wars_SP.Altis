/*
	Function to make specified side calls for a reinforcement or QRF
*/
params ["_zoneIndex", "_side"];

private _targetZone = AWSP_Zones # _zoneIndex;
private _targetPos = _targetZone # 2;
private _eastZones = [];
private _nearestZones = [];
private _attackerZone = nil;
private _attackerArray = [];

// Find other garrison of the same side
{
	private _zoneSide = _x # 4;
	if (_zoneSide == _side) then 
	{
		private _index = _x # 0;
		
		// Exclude _targetZone from the search if its the same side
		if (_index != _targetZone # 0) then 
		{
			_eastZones pushBack _x;
		};
	};
} forEach AWSP_Zones;

// Add distance into the data
{
	private _xPos = _x # 2;
	private _distance = _targetPos distance _xPos;
	
	_x set [5, _distance];
	_eastZones set [_forEachIndex, _x];
} forEach _eastZones;

// Find nearest garrison
private _radioRange = 0;
private _blacklist = [];

while {isNil "_attackerZone"} do 
{
	if (count _nearestZones == 0 && count _eastZones > 0) then 
	{
		_radioRange = _radioRange + 100;
		_nearestZones = [_radioRange, _eastZones, _blacklist] call F90_fnc_findNearestGarrisons;
	};

	if (count _nearestZones > 0) then 
	{
		private _selectedGarrison = _nearestZones # 0;
		private _selectedIndex = _selectedGarrison # 0;
		private _selectedTrigger = AWSP_ZoneTrigger # _selectedIndex;
		private _cachedGroup = _selectedTrigger getVariable "Zone_CachedGroup";
		private _selectedDefenseCount = count _cachedGroup;

		if (_selectedDefenseCount > 1) then 
		{
			_attackerZone = _selectedGarrison;
			["NotificationReinforcement", ["CSAT is sending their QRF"]] call BIS_fnc_showNotification;
			//	Assign Reinforcement
			private _attackerGroup = [_selectedGarrison, _selectedTrigger] call F90_fnc_assignAsReinforcement;
			_attackerArray = [_attackerGroup, _targetZone, _selectedGarrison] call F90_fnc_createReinforcement;
		}else 
		{
			_nearestZones deleteAt 0;
			_blacklist pushBack _selectedGarrison; 
			["sendReinforcement", format["Selected garrison cant provide support. Finding another from %1", _nearestZones]] call F90_fnc_debug;
		};
	};

	if (count _blacklist == count _eastZones) exitWith
	{
		["sendReinforcement", "No garrison cant provide any support for the time being.."] call F90_fnc_debug;
	};
	sleep 0.05;
};

_attackerArray;