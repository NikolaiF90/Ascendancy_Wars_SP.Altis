/*
Removes all persisted data for given save _slot.
*/

// _slot is optional - if not specified, all data persisted by
// this system will be removed (i.e. only with prefix = PSave_SaveGamePrefix).
params ["_slot"];

private "_variables";

if (isNil { _slot }) then
{
	["Clearing all saves."] call skhpersist_fnc_LogToRPT;
	_variables = [] call skhpersist_fnc_ListExistingVariables;
}
else
{
	[format ["Clearing save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;
	_variables = [_slot] call skhpersist_fnc_ListExistingVariables;
};

{
	profileNamespace setVariable [_x, nil];
} forEach _variables;

saveProfileNamespace;

hint format ["Save has been cleaned up!"];