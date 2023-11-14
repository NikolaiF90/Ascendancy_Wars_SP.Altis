params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

Respawn_Debug = true;
[Respawn_Debug, "onPlayerKilled", format ["%1 killed", _oldUnit], true] call F90_fnc_debug;

private _oldGroup = group _oldUnit;
private _newGroup = createGroup (side _oldUnit);

private _oldPos = position _oldUnit;
private _respawnPos = markerPos "respawn_guerrila";

private _newUnit = _newGroup createUnit ["I_G_Soldier_F", _respawnPos, [], 0, "FORM"];
[_newUnit] joinSilent _oldGroup;

selectPlayer _newUnit;
_oldUnit switchcamera "EXTERNAL";
sleep 4;
3.5 fadeSound 0;
titleText ["","BLACK OUT",0.8];

private _camera = "camera" camcreate _oldPos;
_camera cameraEffect ["Internal","BACK"];
_camera camsetPos _oldPos;
_camera camsetTarget _oldPos;
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
	_camera camSetPos [(_oldPos select 0)+1, _oldPos select 1,_camZ / 10];
	_camera camcommit 0;
	_camZ = _camZ + 1;
	sleep 0.01;
};

sleep 1;
3.5 fadeSound 1;
titleText ["","BLACK IN",5];
_camera cameraeffect ["Terminate","BACK"];
_camera camcommit 0;
camdestroy _camera;

detach _newUnit;
_newUnit switchmove "";
_newUnit enablesimulation true;
_newUnit switchcamera "INTERNAL";
sleep 2;

if (_oldUnit == commanderX) then 
{
	commanderX = _newUnit;
};