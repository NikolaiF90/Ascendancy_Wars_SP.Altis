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
	private ["_unit", "_selections", "_getHit", "_selection", "_source", "_projectile", "_oldDmg", "_currentDamage", "_newDmg", "_unitSide"];
	_unit = _this # 0;
	_selection = _this # 1;
	_currentDamage = _this # 2;
	_source = _this # 3;
	_projectile = _this # 4;

	_selections = _unit getVariable ["Revive_Selections", []];
	_getHit = _unit getVariable ["Revive_GetHit", []];
	_unitSide = side _unit;
	
	if !(_selection in _selections) then 
	{
		_selections set [count _selections, _selection];
		_unit setVariable ["Revive_Selections", _selections];
		_getHit set [count _getHit, 0];
		_unit setVariable ["Revive_GetHit", _getHit];
	};
	_i = _selections find _selection;
	_oldDmg = _getHit # _i;
	[Revive_Debug, "addRevive", format ["%1 received %2 damage", _unit, _currentDamage], true] call F90_fnc_debug;
	if (_currentDamage >= 1 && _currentDamage < 2) then 
	{
		_newDmg = 0.99;
		_unit allowDamage false;
		[_unit, true] call F90_fnc_setUnitReviveState;
		[_unit] spawn F90_fnc_bleedOut;
		
		if (_unitSide == SIDE_ENEMY) then 
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

		if (_unitSide != (side _source)) then 
		{
			[""] call F90_fnc_economyHandler;
		};
		_newDmg;
	}
	else
	{
		_getHit set [_i, _currentDamage];
		_unit setVariable ["Revive_GetHit", _getHit];
		_currentDamage;
	};
	if (_currentDamage >= 2) then 
	{
		_unit setDamage 1;
		_currentDamage;
	};
}];