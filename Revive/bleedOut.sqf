/*
	Code Explanation: 
 
	This code is a function in Arma 3 that applies a bleedout effect to a specified unit and eventually causes the unit to die after a given time. Here is a breakdown of the code: 
	
	SYNTAX: 
	[unit] spawn F90_fnc_bleedOut; 
	
	PARAMETERS: 
	- _unit: Object - The unit to which the bleedout effect will be applied. 
	
	RETURN: 
	None 
*/
params ["_unit"];

private _health = 100;

for "_i" from 0 to Revive_BleedoutTime do 
{
	if !(lifeState _unit == "INCAPACITATED") exitWith {};
	if (_i == (Revive_BleedoutTime / 2)) then 
	{
		if (damage _unit < 0.5) then
		{
			_unit allowDamage true;
			_unit setDamage 0.5;
		};
	};

	if (_i == Revive_BleedoutTime) then 
	{
		_unit allowDamage true;
		_unit setDamage 1;
	};
	sleep 1;
};