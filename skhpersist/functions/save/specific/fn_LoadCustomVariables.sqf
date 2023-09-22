/*
Restores data of specified variables.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading custom variables from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _allVariables = ["variables", _slot] call skhpersist_fnc_LoadData;

[PSave_CustomVariablesToSave] call skhpersist_fnc_ClearArray;

{
	private _namespace = _x # 0;
    private _key = _x # 1;
	private _value = _x # 2;

	[_namespace, _key, _value] call skhpersist_fnc_SaveVariableToNamespace;

	PSave_CustomVariablesToSave pushBack [_namespace, _key];
} forEach _allVariables;