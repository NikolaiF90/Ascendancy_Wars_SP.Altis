/*
	Code Explanation:

	This code is a function in Arma 3 that is used to debug the Revive System. It allows the spawning of a unit from a specified side and makes the player immune to damage.

	SYNTAX:
	To call this function, use the syntax: [side, turnOn] call F90_fnc_debugRevive;

	PARAMETERS:
	- _side: Side - The side of the unit to spawn.
	- _turnOn: Boolean - A boolean value. If true, it makes the player immune to damage.

	CODE:
	1. If the "_turnOn" parameter is true, the following actions are performed:
	- The player is set to not allow damage.
	- The function "BIS_fnc_findSafePos" is called with parameters "player", 1, and 25 to find a safe position for the player.
	- A group is created for the specified side using the "createGroup" function and assigned to the "_group" variable.
	- A temporary group is created for the specified side using the "createGroup" function and assigned to the "_tempGrp" variable.
	- A soldier unit of the specified side ("O_G_Soldier_F") is created at the safe position and assigned to the "_soldier" variable.
	- The soldier unit is added to the main group using the "joinSilent" function.
	- If the "Revive_Enabled" variable is true, the "F90_fnc_addRevive" function is called for the soldier unit.
	2. If the "_turnOn" parameter is false, the player is set to allow damage.

	RETURN:
	None.
*/

params ["_side", "_turnOn"];

if (_turnOn) then 
{
	player allowDamage false;

	private _pos = [player, 1, 25] call BIS_fnc_findSafePos;
	private _group = createGroup [_side, true];
	private _tempGrp = createGroup [_side, true];
	private _soldier = _tempGrp createUnit ["O_G_Soldier_F", _pos, [], 0, "FORM"];
	[_soldier] joinSilent _group;
	if (Revive_Enabled) then 
	{
		_soldier call F90_fnc_addRevive;
	};
} else
{
	player allowDamage true;
};