/*
	Funtion to make the specified unit to bleedout and die after given time (see configuration)

	SYNTAX:
		[unit] spawn F90_fnc_bleedOut;
	PARAMETERS:
		unit: unit to apply bleedout
	RETURN:
		Nothing
*/
params ["_unit"];

if !(lifeState _unit == "INCAPACITATED") exitWith {};

private _health = 100;

for "_i" from 0 to Revive_BleedoutTime do 
{
	sleep 1;
	if (_i == (Revive_BleedoutTime / 2)) then 
	{
		if (damage _unit < 0.5) then
		{
			_unit setDamage 0.5;
		};
	};

	if (_i == Revive_BleedoutTime) then 
	{
		_unit setDamage 1;
	};
};