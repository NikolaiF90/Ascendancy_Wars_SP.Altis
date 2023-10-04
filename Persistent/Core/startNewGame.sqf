["startNewGame", "Starting a new game..."] call F90_fnc_debug;
F90_MissionStarted = true;

initVarsDone = false;
[] call F90_fnc_initVars;

waitUntil {initVarsDone};

commanderX setPos [0,0,0];

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
	private _zoneIndex = -1;
	{
		_zoneIndex = _zoneIndex + 1;
		[_zoneIndex] call F90_fnc_clearZones;
	} forEach AWSP_Zones;

	for "_i" from 0 to (count AWSP_Zones) -1 do 
	{
		AWSP_Zones deleteAt 0;
	};
};
[] call F90_fnc_initGarrison;

commanderX setPos [16914.2,21877.8,0];
/*
	TODO: 
	delete objects/units spawned by player

*/
