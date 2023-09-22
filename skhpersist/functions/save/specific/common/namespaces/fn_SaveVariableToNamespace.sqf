/*
Saves variable with given _key and _value in given _namespace.
_namespace should be provided as String (used only when saving / loading variables.)
*/

params ["_namespace", "_key", "_value"];

switch (_namespace) do
{
	case "local":
	{
		localNamespace setVariable [_key, _value];
	};
	case "mission":
	{
		missionNamespace setVariable [_key, _value];
	};
	case "parsing":
	{
		parsingNamespace setVariable [_key, _value];
	};
	case "profile":
	{
		profileNamespace setVariable [_key, _value];
	};
	case "ui":
	{
		uiNamespace setVariable [_key, _value];
	};
};