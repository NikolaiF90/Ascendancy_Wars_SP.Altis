/*
	Author: PrinceF90 
 
	Description: 
	This onPlayerKilled.sqf code is a respawn script. It handles the respawn process for a player unit. It includes camera effects, menu options for loading the game, respawning, or ending the game, and various actions related to the respawn. 
	
	Parameter(s): 
		0: OBJECT - _oldUnit: The unit that was killed. 
		1: OBJECT - (optional) _killer: The unit that killed the player. 
		2: BOOL - _respawn: Determines if the player should respawn or not. 
		3: NUMBER - _respawnDelay: The delay in seconds before respawning. 
	
	Returns: 
		None 
	
	Examples: 
		N/A - This script is called automatically if player dies.
*/
params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

Respawn_Debug = true;
[Respawn_Debug, "onPlayerKilled", format ["%1 killed", _oldUnit], true] call F90_fnc_debug;

private _fnc_elevateCamera = 
{
	params ["_position"];
	titleText ["","BLACK OUT",0.8];

	private _camera = "camera" camcreate _position;
	_camera cameraEffect ["Internal","BACK"];
	_camera camsetPos _position;
	_camera camsetTarget _position;
	_camera CamCommit 0;

	private _camZ = 0;
	titleText ["","BLACK IN",1];

	[] spawn 
	{
		sleep 1;
		titleText ["","BLACK OUT", 3];
	};

	while {_camZ < 400} do 
	{
		_camera camSetPos [(_position select 0)+1, _position select 1,_camZ / 10];
		_camera camcommit 0;
		_camZ = _camZ + 1;
		sleep 0.01;
	};

	sleep 1;
	titleText ["","BLACK IN",5];
	_camera cameraeffect ["Terminate","BACK"];
	_camera camcommit 0;
	camdestroy _camera;
};

private _respawnPos = markerPos "respawn_guerrila";
private _oldGroup = group _oldUnit;

private _newUnit = [_oldUnit, _respawnPos] call F90_fnc_cloneUnit;
[_newUnit] joinSilent _oldGroup;

selectPlayer _newUnit;
_oldUnit switchcamera "EXTERNAL";
3.5 fadeSound 0;
sleep 2;

[] call F90_fnc_showDeadMenu;

3.5 fadeSound 1;
switch (Killed_Choice) do 
{
	case 0: // Load Game
	{
		_newUnit switchcamera "INTERNAL";
		[] call F90_fnc_deadMenuLoad;
		Killed_Choice = -1;
	};
	case 1: // Respawn
	{
		private _oldPos = position _oldUnit;
		[_oldPos] call _fnc_elevateCamera; 
		_newUnit switchcamera "INTERNAL";
		Killed_Choice = -1;
	};
	case 2: // End Game
	{
		["KILLED",false,true,true,true] call BIS_fnc_endMission;
		deleteVehicle _newUnit;
		Killed_Choice = -1;
	};
};