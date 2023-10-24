/*

*/
params ["_reinforcementData", "_caller", "_provider"];

["createReinforcement", "Creating reinforcement"] call F90_fnc_debug;

private _callerPos = _caller # 2;
private _providerPos = _provider # 2;
private _side = _provider # 4;
private _distance = _provider # 5;
private _transportation = -1;
private _vehicle = "";
private _cars = [];
private _helos = [];
private _reinforcementGroups = [];
private _groupSkill = 0;

if (_distance <= 1000) then 
{
	_transportation = floor random 2;
};

if (_distance > 1000) then 
{
	_transportation = 2;
};

switch (_side) do 
{
	case east: 
	{
		_groupSkill = AWSP_OPFORSkill;
		_cars = ["O_Truck_03_transport_F", "O_Truck_03_covered_F", "O_Truck_02_transport_F", "O_Truck_02_covered_F"];
		_helos = ["O_Heli_Light_02_unarmed_F", "O_Heli_Light_02_dynamicLoadout_F", "O_Heli_Transport_04_covered_F", "O_Heli_Attack_02_dynamicLoadout_F"];
	};
	case west: 
	{
		_groupSkill = AWSP_BLUFORSkill;
		_cars = ["I_Truck_02_covered_F", "I_Truck_02_transport_F", "I_G_Van_01_transport_F", "I_G_Van_02_transport_F"];
		_helos = ["I_Heli_Transport_02_F", "I_Heli_light_03_unarmed_F"];
	};
	case independent: {_groupSkill = AWSP_GUERSkill;};
};

for "_i" from 0 to (count _reinforcementData)-1 do 
{
	private _group = createGroup _side;
	private _tempGroup = [_providerPos, _side, _reinforcementData # _i] call BIS_fnc_spawnGroup;

	{
		[_x] joinSilent _group;
		_x setSkill _groupSkill;
		if (Revive_Enabled) then 
		{
			_x call F90_fnc_addRevive;
		};
	} forEach units _tempGroup;
	_reinforcementGroups set [_i, _group];
};

for "_i" from 0 to (count _reinforcementGroups)-1 do 
{
	private _selectedGroup = _reinforcementGroups # _i;
	switch (_transportation) do 
	{
		case 1: 
		{
			_vehicle = _cars # (floor random (count _cars));
		};
		case 2: 
		{
			_vehicle = _helos # (floor random (count _helos));
		};
	};

	_selectedGroup setCombatMode "YELLOW";
	if (_transportation != 0) then 
	{
		private _spawnPos = [_providerPos, 0, 100] call BIS_fnc_findSafePos;
		private _spawnedVehicle = _vehicle createVehicle [_spawnPos # 0, _spawnPos # 1, 200];
		_selectedGroup addVehicle _spawnedVehicle;

		{
			_x moveInAny _spawnedVehicle;
		} forEach units _selectedGroup;
		
		private _wpMove = _selectedGroup addWaypoint [_callerPos, 100, 1];
		_wpMove setWaypointType "MOVE";

		if (_transportation == 1) then 
		{
			private _wpGetOut = _selectedGroup addWaypoint [_callerPos, 100, 2];
			_wpGetOut setWaypointType "GETOUT";
		} else 
		{
			private _wpLand = _selectedGroup addWaypoint [_callerPos, 100, 2];
			[_selectedGroup] setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";

			private _wpGetOut = _selectedGroup addWaypoint [_callerPos, 100, 3];
			_wpGetOut setWaypointType "GETOUT";
		};
		private _wpAttack = _selectedGroup addWaypoint [_callerPos, 100];
		_wpAttack setWaypointType "SAD";
	};
	
};

_reinforcementGroups;
