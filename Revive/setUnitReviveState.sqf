/*
	Function to set unit revival state, if true, then the unit is  reviveable
*/
params ["_unit", "_revive"];

if (_revive) then 
{
	_unit setUnconscious true;
	_unit setCaptive true;
//	_unit allowDamage false;
} else {
	_unit setUnconscious false;
	_unit setCaptive false;
//	_unit allowDamage true;
};