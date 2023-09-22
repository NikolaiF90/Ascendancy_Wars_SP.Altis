/*
Executes either a specified code or a function in given path,
depending on what has been provided in params.
*/

params ["_functionToCall", "_arrayOfParams"];

private _type = typeName _functionToCall;

if (_type == "STRING") then
{
	_arrayOfParams call compile preprocessFileLineNumbers _functionToCall;
}
else
{
	if (_type == "CODE") then
	{
		_arrayOfParams call _functionToCall;
	}
	else
	{
		[format ["Wrong function type provided (%1, expected STRING or CODE).", _type]] call skhpersist_fnc_LogToRPT;
	};
};
