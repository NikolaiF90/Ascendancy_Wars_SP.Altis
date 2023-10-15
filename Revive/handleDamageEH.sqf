/*
	Function for handling damage to a unit and initiating the revive process if the unit's damage exceeds a certain threshold. 
*/
params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

private ["_selections", "_getHit", "_i", "_oldDmg", "_curDmg", "_newDmg"];

_selections = _unit getVariable ["Revive_Selections", []];
_getHit = _unit getVariable ["Revive_GetHit", []];

if !(_selection in _selections) then 
{
	_selections set [count _selections, _selection];
	_getHit set [count _getHit, 0];
};

_i = _selections find _selection;
_oldDmg = _getHit select _i;

if (_curDmg >= 1) then 
{
	_newDmg = 0.99;
	_unit allowDamage false;
	[_unit, true] call F90_fnc_setUnitReviveState;
	[_unit] spawn F90_fnc_bleedOut;

	if (side _unit == side player) then 
	{
		_unit call F90_fnc_addPlayerHoldRevive;
	} else 
	{
		player call F90_fnc_revivePrisoner;
	};
	
	_newDmg;
} else
{
	_getHit set [_i, _curDmg];
	_curDmg;
};