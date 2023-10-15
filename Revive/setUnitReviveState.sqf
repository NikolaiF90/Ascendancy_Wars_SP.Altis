/*
	Function to set unit revival state, if true, then the unit is conscious
*/
params ["_unit", "_conscious"];

if (_conscious) then 
{
	_unit setUnconscious true;
	_unit setCaptive true;
} else {
	_unit setUnconscious false;
	_unit setCaptive false;
	_unit allowDamage true;
};