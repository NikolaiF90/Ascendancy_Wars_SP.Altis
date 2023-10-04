/*
	Stores data for specified variables.
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveCustomVariables", format ["Saving custom variables to save slot %1.", _slot]] call F90_fnc_debug;

private _allVariables = [];

{
	private _namespace = _x # 0;
	private _name = _x # 1;
	private _value = [_namespace, _name] call F90_fnc_loadVarFromNamespace;

    _allVariables pushBack [_namespace, _name, _value];
} forEach PSave_CustomVariablesToSave;

["variables", _allVariables, _slot] call F90_fnc_saveData;