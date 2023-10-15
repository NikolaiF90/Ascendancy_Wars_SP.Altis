/*
	Code Explanation: 
 
	This code is a function in Arma 3 that handles the revive system and damage handling for a unit. Here is a breakdown of the code: 
	
	SYNTAX: 
	[unit] call F90_fnc_addRevive; 
	
	PARAMETERS: 
	- _unit: Object - The unit for which the revive system and damage handling are performed. 
	
	RETURN: 
	None 
*/
params ["_unit"];

_unit setVariable ["Revive_Selections", []];
_unit setVariable ["Revive_GetHit", []];
_unit addEventHandler ["HandleDamage", 
{
	private ["_unit", "_selections", "_getHit", "_selection", "_source", "_projectile", "_oldDmg", "_curDmg", "_newDmg"];
	_unit = _this select 0;
	_selections = _unit getVariable ["selections", []];
	_getHit = _unit getVariable ["gethit", []];
	_selection = _this select 1;
	_source = _this select 3;
	_projectile = _this select 4;
	
	if !(_selection in _selections) then 
	{
		_selections set [count _selections, _selection];
		_getHit set [count _getHit, 0];
	};
	_i = _selections find _selection;
	_oldDmg = _getHit select _i;
	_curDmg = _this select 2;
	if (_curDmg >= 0.99) then 
	{
		_newDmg = 0.98;
		_unit allowDamage false;
		[_unit, true] call F90_fnc_setUnitReviveState;
		[_unit] spawn F90_fnc_bleedOut;

		if (!(side _unit == side player)) then 
		{
			private _captureActionID = _unit getVariable ["Revive_CaptureActionID", nil];
			if (!isNil "_captureActionID") then 
			{
				_unit removeAction _captureActionID;
			};
			private _actionID = _unit addAction ["Revive prisoner", F90_fnc_revivePrisoner, nil, 5, false, true, "", "lifeState _target == 'INCAPACITATED' && _this == player", 5];
			_unit setVariable ["Revive_PrisonerActionID",_actionID];
		} else 
		{
			_unit call F90_fnc_addPlayerHoldRevive;
		};
		_newDmg;
	}
	else
	{
		_getHit set [_i, _curDmg];
		_curDmg;
	};
}];