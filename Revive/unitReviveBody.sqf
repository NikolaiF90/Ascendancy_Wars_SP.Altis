/*
	Function to make ai unit revive another unit
*/
params ["_medic", "_body"];

private ["_pos", "_leader", "_patientName"];

_patientName = (name _body splitString " ") # ((count (name _body splitString " ")) - 1);

_medic groupChat format ["I am going to revive %1, cover me!", _patientName];
_pos = getPos _body;

_medic doMove _pos;
//[_medic, _pos] remoteExec ["doMove", _medic];
waitUntil {moveToCompleted _medic};
_medic setFormDir (_medic getDir _body);
//[_medic, _medic getDir _body] remoteExec ["setFormDir", _medic];
sleep 0.5;

doStop _medic; //stop here prevents unit from making radio messages after doMove
_medic setPos (position _body);
_medic lookAt _body;
_body setVariable ["BeingRevived", true, true];
_medic playMove "AinvPknlMstpSnonWnonDnon_medic1";
_medic playMove "AinvPknlMstpSnonWnonDnon_medic2";
sleep Revive_Duration;

_medic playMoveNow "AinvPknlMstpSnonWnonDnon_medicEnd";
_body setVariable ["BeingRevived", nil, true];
[_body, false] call F90_fnc_setUnitReviveState;
//[_body, false] remoteExec ["F90_fnc_setUnitReviveState", _body];
_body setDamage 0;
_leader = leader _medic;
_medic setFormDir (_medic getDir _leader);
//[_medic, _medic getDir _leader] remoteExec ["setFormDir", _medic];
_medic doFollow _leader;
//[_medic, _leader] remoteExec ["doFollow", _medic];