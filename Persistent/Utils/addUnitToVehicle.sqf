/*
	Function Description: 
	Function to puts units back into their vehicles if they were in a vehicle while the mission was being saved. 
	The function retrieves the assigned vehicle and role information from the "_vehicleData" parameter and moves the unit into the corresponding position in the vehicle based on their role (e.g., driver, gunner, cargo, commander, turret). 
	
	Syntax: 
	[unit,vehicleData] call F90_fnc_addUnitToVehicle 
	
	Parameters: 
	- "unit": The unit to put back into the vehicle. 
	- "vehicleData": Data containing information about the vehicle and unit assignment. 
	
	Return: 
	None 
*/

params ["_unit", "_vehicleData"];

if (isNil {_vehicleData}) exitWith { ["addUnitToVehicle", format ["%1 has no vehicle", _unit]]call F90_fnc_debug; };
if !(_vehicleData isEqualType []) exitWith {["addUnitToVehicle", format ["%1 has no vehicle", _unit]]call F90_fnc_debug;};

private _FindAssignedVehicleInArray =
{
	params ["_id"];
	private _instance = objNull;

	{
		if (_x getVariable "PSave_UnitAssignmentID" == _id) exitWith { _instance = _x };
	} forEach Persistent_VehiclesToSave;

	_instance;
};

private _vehicleAssignmentId = [_vehicleData, "id"] call F90_fnc_getByKey;
private _roleArray = [_vehicleData, "role"] call F90_fnc_getByKey;

private _vehicleInstance = [_vehicleAssignmentId] call _FindAssignedVehicleInArray;
		
if (!(isNil {_vehicleInstance}) && !(isNil {_roleArray})) then
{
	private _role = _roleArray # 0;

	switch (_role) do
	{
		case "driver":
		{
			_unit moveInDriver _vehicleInstance;
		};
		case "gunner":
		{
			_unit moveInGunner _vehicleInstance;
		};
		case "cargo":
		{
			private _cargoIndex = _roleArray # 1;
			_unit moveInCargo [_vehicleInstance, _cargoIndex];
		};
		case "commander":
		{
			_unit moveInCommander _vehicleInstance;
		};
		case "turret":
		{
			private _turretPath = _roleArray # 2;
			_unit moveInTurret [_vehicleInstance, _turretPath];
		};
	};
};