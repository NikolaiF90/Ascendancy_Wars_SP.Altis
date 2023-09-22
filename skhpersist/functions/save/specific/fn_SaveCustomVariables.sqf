/*
Stores data for specified variables.
Data is saved to given save _slot.
*/

params ["_slot"];

[format ["Saving custom variables to save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _allVariables = [];

{
	private _namespace = _x # 0;
	private _name = _x # 1;
	private _value = [_namespace, _name] call skhpersist_fnc_LoadVariableFromNamespace;

    _allVariables pushBack [_namespace, _name, _value];
} forEach PSave_CustomVariablesToSave;

["variables", _allVariables, _slot] call skhpersist_fnc_SaveData;