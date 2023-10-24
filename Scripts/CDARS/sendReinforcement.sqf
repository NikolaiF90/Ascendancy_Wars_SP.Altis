/*
	Function to make specified side calls for a reinforcement or QRF
*/
params ["_zoneIndex", "_side"];

private _thisGarrison = AWSP_Zones # _zoneIndex;
private _pos = _thisGarrison # 2;
private _otherGarrisons = [];
private _nearestGarrisons = [];
private _reinforcementGarrison = nil;
private _reinforcementArray = [];

// Find other garrison of the same side
{
	private _garrisonSide = _x # 4;
	if (_garrisonSide == _side) then 
	{
		private _garrisonIndex = _x # 0;
		if (_garrisonIndex != _thisGarrison # 0) then 
		{
			_otherGarrisons pushBack _x;
		};
	};
} forEach AWSP_Zones;

// Get the distance of other garrison
{
	private _garrisonPos = _x # 2;
	private _distance = _pos distance _garrisonPos;
	
	_x set [5, _distance];
	_otherGarrisons set [_forEachIndex, _x];
} forEach _otherGarrisons;

// Find nearest garrison
private _radioRange = 0;
private _blacklist = [];

while {isNil "_reinforcementGarrison"} do 
{
	if (count _nearestGarrisons == 0 && count _otherGarrisons > 0) then 
	{
		_radioRange = _radioRange + 100;
		_nearestGarrisons = [_radioRange, _otherGarrisons, _blacklist] call F90_fnc_findNearestGarrisons;
	};

	if (count _nearestGarrisons > 0) then 
	{
		private _selectedGarrison = _nearestGarrisons # 0;
		private _selectedIndex = _selectedGarrison # 0;
		private _selectedTrigger = AWSP_ZoneTrigger # _selectedIndex;
		private _selectedDefenseCount = _selectedTrigger getVariable "Zone_GroupCount";

		if (_selectedDefenseCount > 1) then 
		{
			["NotificationReinforcement", ["CSAT is sending their QRF"]] call BIS_fnc_showNotification;
			//	Assign Reinforcement
			private _reinforcementGroup = [_selectedGarrison, _selectedTrigger] call F90_fnc_assignAsReinforcement;
			_reinforcementArray = [_reinforcementGroup, _thisGarrison, _selectedGarrison] call F90_fnc_createReinforcement;
		}else 
		{
			_nearestGarrisons deleteAt 0;
			_blacklist pushBack _selectedGarrison; 
			["sendReinforcement", format["Selected garrison cant provide support. Finding another from %1", _nearestGarrisons]] call F90_fnc_debug;
		};
	};

	if (count _blacklist == count _otherGarrisons) exitWith
	{
		["sendReinforcement", "No garrison cant provide any support for the time being.."] call F90_fnc_debug;
	};
	sleep 0.05;
};

_reinforcementArray;