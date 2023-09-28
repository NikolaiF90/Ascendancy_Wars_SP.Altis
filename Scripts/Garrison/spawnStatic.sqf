/*
	Function to spawn static at suitable building at provided position
*/
params ["_marker", "_count", "_side", "_skill", "_staticGrp"];

private _pos = markerPos _marker;
private _area = markerSize _marker;
private _searchRadius = _area # 0; 

private _spawnPosition = [];
private _mgBuildings = [];
private ["_selectedBuilding"];

private _groupUnits = [];
private _returnData = [];


if (surfaceiswater _pos) exitwith {["spawnStatic", "Static can't be spawned on water"] call F90_fnc_debug;};

{
	private _suitableBuildings = _pos nearObjects [_x, _searchRadius];
	_mgBuildings append _suitableBuildings;
} forEach AWSP_MGBuilding;
["spawnStatic", format ["MG Buildings = %1", _mgBuildings]] call F90_fnc_debug;

for "_i" from 1 to _count do 
{
	private _group = createGroup _side;

	//	Pick random building
	if (count _mgBuildings > 1) then 
	{
		private _buildingIndex = floor random (count _mgBuildings -1);
		["spawnStatic", format ["_buildingIndex = %1", _buildingIndex]] call F90_fnc_debug;
		_selectedBuilding = _mgBuildings # _buildingIndex;

	}else
	{
		_selectedBuilding = _mgBuildings # 0;
	};
	["spawnStatic", format ["_selectedBuilding = %1", _selectedBuilding]] call F90_fnc_debug;

	//	Find position on the building to spawn the mg 
	if (!isNil "_selectedBuilding") then 
	{
		private _posX = getPos _selectedBuilding # 0; 
		private _posY = getPos _selectedBuilding # 1;
		private _posZ = getPos _selectedBuilding # 2;

		_spawnPosition = [_posX, _posY, _posZ + 2];
		_selectedBuilding = nil;
		["spawnStatic", format ["_spawnPosition = %1", _spawnPosition]] call F90_fnc_debug;
	} else 
	{
		if (isNil "_selectedBuilding") exitWith 
		{
			["spawnStatic", "No suitable buildings to place MG"] call F90_fnc_debug;
		};
	};
	
	//	Spawn static
	if (count _spawnPosition > 0) then 
	{
		
		private _turret = [_spawnPosition, 0, "B_HMG_01_high_F", _side] call BIS_fnc_spawnVehicle;
		private _vehicle = _turret # 0;
		private _crew = _turret # 1;
		private _turretGroup = _turret # 2;

		{
			[_x] joinSilent _group;
		} forEach units _turretGroup;
	
		{
			_x setSkill _skill;
		} forEach units _group;

		["spawnStatic", format["Static%1 spawned", _i]] call F90_fnc_debug;
		returnData = [_vehicle, _crew, _group];
	};

	{
		_groupUnits pushback _x;	
	} forEach units _group;
};

_returnData;