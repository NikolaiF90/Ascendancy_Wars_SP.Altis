/*
	Function to add "Hold to revive" to specified unit
*/
private _unitName = (name _this splitString " ") # ((count (name _this splitString " ")) - 1);

[_this, 
	format ["revive %1", _unitName],
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_revivemedic_ca.paa",
	"a3\ui_f\data\igui\cfg\holdactions\holdaction_revive_ca.paa",
	"lifeState _target == 'INCAPACITATED' && _this == player && {_target != player && {_target distance _this < 3}}",
	"true",
	{ //action start
		private _caller = _this # 1;
		(_this # 0) setVariable ["Revive_IsBeingRevived", true, true];
		(_this # 1) playMove "AinvPknlMstpSnonWnonDnon_medic1";
		(_this # 1) playMove "AinvPknlMstpSnonWnonDnon_medic2";
		(_this # 1) playMove "AinvPknlMstpSnonWnonDnon_medic3";
	},
	nil,
	{ //action complete
		(_this # 0) setVariable ["Revive_IsBeingRevived", false, true];
		[_this # 0, false] call F90_fnc_setUnitReviveState;
		(_this # 0) setDamage 0;
		(_this # 1) playMoveNow "AinvPknlMstpSnonWnonDnon_medicEnd";
	},
	{ //action interrupted
		(_this # 0) setVariable ["Revive_IsBeingRevived", false, true];
		(_this # 1) playMoveNow "AinvPknlMstpSnonWnonDnon_medicEnd";
	},
	nil,
	Revive_Duration,
	1000,
	true,
	true,
	true] call BIS_fnc_holdActionAdd;