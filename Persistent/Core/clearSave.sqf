/*
	Removes all persisted data for given save _slot.
*/

// 	_slot is optional - if not specified, all data persisted by
// 	this system will be removed (i.e. only with prefix = PSave_SaveGamePrefix).
params ["_slot"];

private "_variables";

if (isNil { _slot }) then
{
	["clearSave","Clearing all saves."] call F90_fnc_debug;
	_variables = [] call F90_fnc_listExistingVariables;
}
else
{
	["clearSave", format ["Clearing save slot %1", _slot]] call F90_fnc_debug;
	_variables = [_slot] call F90_fnc_listExistingVariables;
};

{
	profileNamespace setVariable [_x, nil];
} forEach _variables;

saveProfileNamespace;

hint format ["Save has been cleaned up!"];