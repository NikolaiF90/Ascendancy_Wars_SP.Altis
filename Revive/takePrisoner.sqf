/*
	Function to add "Hold to revive" to specified unit
*/
_this addAction ["Take prisoner", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_caller playMove "AinvPknlMstpSnonWnonDnon_medic1";
	_caller playMove "AinvPknlMstpSnonWnonDnon_medic2";
	_caller playMove "AinvPknlMstpSnonWnonDnon_medicEnd";
	sleep 10;
	[_target, false] call DREAD_fnc_unitSetReviveState;
	_target setCaptive true;
	_target setDamage 0;
}, nil, 5, false, true, "", "lifeState _target == 'INCAPACITATED' && _this == player"];