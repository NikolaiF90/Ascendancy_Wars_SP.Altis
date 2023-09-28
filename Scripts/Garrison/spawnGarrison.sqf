params ["_trigger", "_initialGroupCount", "_zoneType", "_zonePos", "_side", "_garrisonSkill", "_marker"];

["spawnGarrison","Spawning garrison"] call F90_fnc_debug;

private _unitCacheArray = [];

private _loadedGroupCount = _trigger getVariable "cachedGroupCount";

if (isNil "_loadedGroupCount") then 
{
	_loadedGroupCount = _initialGroupCount;
	["spawnGarrison","No cache found for group count. Applying init value instead"] call F90_fnc_debug;
} else 
{
	["spawnGarrison", format ["Restored %1 group(s)", _loadedGroupCount]] call F90_fnc_debug;
};

private _groupsToSpawn = _loadedGroupCount;

//	Spawn Infantry 
for "_i" from 1 to _groupsToSpawn do 
{
	private _key = format ["_garrisonGroup%1", _i];
	private _loadedUnitsCount = _trigger getVariable _key;

	if (isNil "_loadedUnitsCount") then 
	{
		_loadedUnitsCount = _initialUnitCount;
		["spawnGarrison","No cache found for units count. Applying init value instead"] call F90_fnc_debug;
	} else 
	{
		["spawnGarrison", format ["Restored %1 unit(s)", _loadedUnitsCount]] call F90_fnc_debug;
	};

	private _unitsToSpawn = _loadedUnitsCount;

	if (_unitsToSpawn > 0) then 
	{
		["spawnGarrison", format["Creating %1Infantry%2", _zoneType, _i]] call F90_fnc_debug;
		private _spawnedGroup =[_zonePos,_unitsToSpawn,_side] call F90_fnc_spawnGroup;
		private _group = _spawnedGroup # 0;
		private _groupUnits = _spawnedGroup # 1;
		private _leader = _groupUnits # 0;
		{
			_x setSkill _garrisonSkill;
		} forEach _groupUnits;

		[_leader, _marker, "NOFOLLOW"] spawn F90_fnc_patrolArea;
		_unitCacheArray pushback _group;

		["spawnGarrison", format["Infantry%1 spawned", _i]] call F90_fnc_debug;
	};
};

_unitCacheArray;
