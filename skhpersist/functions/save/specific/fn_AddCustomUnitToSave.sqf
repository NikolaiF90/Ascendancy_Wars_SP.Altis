/*
Makes specified _unit saveable.
*/

params ["_unit"];

[format ["Trying to add unit %1 to save.", _unit]] call skhpersist_fnc_LogToRPT;

private _groupLeader = leader group _unit;

if (_unit != _groupLeader && alive _groupLeader) then
{
	[format ["Only group leaders should be added to save, adding %1 instead of %2.", _groupLeader, _unit]] call skhpersist_fnc_LogToRPT;
	[_groupLeader] call skhpersist_fnc_AddCustomUnitToSave;
}
else
{
	if (PSave_CustomUnitsToSave find _unit == -1) then 
	{
		[format ["Adding unit %1 to save.", _unit]] call skhpersist_fnc_LogToRPT;

		_unit addEventHandler ["killed", {
			params ["_deadUnit"];
			
			[format ["Saveable unit %1 killed, looking for second in command...", _deadUnit]] call skhpersist_fnc_LogToRPT;
			
			private _secondInCommand = (units _deadUnit select { alive _x }) param [0, objNull];
			
			if (!(isNull _secondInCommand)) then
			{
				[format ["Second in command found (%1), adding to save.", _secondInCommand]] call skhpersist_fnc_LogToRPT;
				[_secondInCommand] call skhpersist_fnc_AddCustomUnitToSave;
			}
			else
			{
				[format ["Second in command not found, unit %1 was the last one in group.", _deadUnit]] call skhpersist_fnc_LogToRPT;
			};

			[format ["Removing killed unit %1 from save.", _deadUnit]] call skhpersist_fnc_LogToRPT;
			[_deadUnit] joinSilent grpNull;
			PSave_CustomUnitsToSave deleteAt (PSave_CustomUnitsToSave find _deadUnit);
		}];

		PSave_CustomUnitsToSave pushBack _unit;
	}
	else
	{
	[format ["Unit %1 is already added for saving.", _unit]] call skhpersist_fnc_LogToRPT;
	};
};