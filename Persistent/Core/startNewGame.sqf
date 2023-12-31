["startNewGame", "Starting a new game..."] call F90_fnc_debug;
F90_MissionStarted = true;

if (dialog) then 
{
	closeDialog 2;
};
[] spawn F90_fnc_showLoadingScreen;

initVarsDone = false;
[] call F90_fnc_initVars;

waitUntil {initVarsDone};

// commanderX setPos [0,0,0];

// Delete all created vehicles
if (count Persistent_VehiclesToSave > 0) then
{
    {
        deleteVehicle _x;
    } forEach Persistent_VehiclesToSave;

    [Persistent_VehiclesToSave] call F90_fnc_clearArray;
	Persistent_VehiclesToSave = [];
};

//	Delete injured units (if any) on load game
//	Delete non script spawned units (e.g zeus spawned)
{
	private _unit = _x;
	private _isScriptSpawned = _unit getVariable "IsScriptSpawned";

	if (isNil {_isScriptSpawned}) then 
	{
		deleteVehicle _unit;
	};
	
	if (captive _unit && (lifeState _unit == "INCAPACITATED")) then 
	{
		deleteVehicle _unit;
	};
} forEach allUnits - [commanderX];

//	Delete all units under player command
if (count units group player > 1) then 
{
	{
		if (_x != player) then 
		{
			deleteVehicle _x;
		};
	} forEach units group player;
};

if (!isNil "AWSP_Zones") then 
{
	{
		[_forEachIndex] call F90_fnc_clearZones;
	} forEach AWSP_Zones;

	for "_i" from 0 to (count AWSP_Zones) -1 do 
	{
		AWSP_Zones deleteAt 0;
	};
};
[] call F90_fnc_initGarrison;
[] call F90_fnc_initCDARS;

commanderX setPos (getMarkerPos "respawn_guerrila");
commanderX setDamage 0;
/*
	TODO: 
	delete objects/units spawned by player

*/
