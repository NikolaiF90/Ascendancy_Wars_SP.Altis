/*
Makes specified _variable from a _namespace saveable.
*/

params ["_variable", "_namespace"];

[format ["Trying to add variable %1 to save.", _variable]] call skhpersist_fnc_LogToRPT;

private _variableExists = false;

{
	private _currentKey = _x # 1;
	private _currentNamespace = _x # 0;

	if (_variable == _currentKey && _namespace == _currentNamespace) exitWith { _variableExists = true };
} forEach PSave_CustomVariablesToSave;

if (!_variableExists) then 
{
	[format ["Adding variable %1 from namespace %2 to save.", _variable, _namespace]] call skhpersist_fnc_LogToRPT;
	PSave_CustomVariablesToSave pushBack [_namespace, _variable];
}
else
{
	[format ["Variable %1 from namespace %2 is already added for saving.", _variable, _namespace]] call skhpersist_fnc_LogToRPT;
};