/*
Loasds variable with given _key from given _namespace.
_namespace should be provided as String (used only when saving / loading variables.)

Returns variable's value.
*/

params ["_namespace", "_key"];

private _value = objNull;

switch (_namespace) do
{
	case "local":
	{
		_value = localNamespace getVariable _key;
	};
	case "mission":
	{
		_value = missionNamespace getVariable _key;
	};
	case "parsing":
	{
		_value = parsingNamespace getVariable _key;
	};
	case "profile":
	{
		_value = profileNamespace getVariable _key;
	};
	case "ui":
	{
		_value = uiNamespace getVariable _key;
	};
};

_value;