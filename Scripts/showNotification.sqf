/*
	A function to show a notification to player. The notification is based on provided parameters.

	SYNTAX:
		[type, variable1] call F90_fnc_showNotification;
	PARAMETERS:
		type: Notification type. Should be STRING of one of the following:
			= "CAPTURED"
			= "LOSS"
		variable1: (Optional) attached variable
			= if type is "CAPTURED" or "LOSS", the aattached variable should be(what is captured or loss) in STRING format
	RETURN:
		Nothing
*/

params ["_type", "_variable1"];

if (_type == "CAPTURED") then
{
	if (isNil "_variable1") then 
	{
		private _notification = "tempTask";
		private _desc = "You have successfully captured a zone";
		private _title = "ZONE CAPTURED";
		[player, _notification, [_desc,_title,""], objNull, "SUCCEEDED"] call BIS_fnc_taskCreate;
	}else 
	{
		if (typeName _variable1 == "STRING") then 
		{
			private _notification = "tempTask";
			private _desc = format ["You have successfully captured an enemy %1", _variable1];
			private _title = format ["%1 CAPTURED", _variable1];
			[player, _notification, [_desc,_title,""], objNull, "SUCCEEDED"] call BIS_fnc_taskCreate;
		} else
		{
			private _errorType = typeName _variable1;
			["ERROR", format ["Provided variable is %1, expected STRING. Check where you call F90_fnc_showNotification", _errorType]] call F90_fnc_debug;
		};
	}
};

if (_type == "LOSS") then
{
	if (isNil "_variable1") then 
	{
		private _notification = "tempTask";
		private _desc = "Enemy captured a zone under your control";
		private _title = "ZONE LOSS";
		[player, _notification, [_desc,_title,""], objNull, "SUCCEEDED"] call BIS_fnc_taskCreate;
	}else 
	{
		if (typeName _variable1 == "STRING") then 
		{
			private _notification = "tempTask";
			private _desc = format ["Enemy has captured your %1", _variable1];
			private _title = format ["%1 LOSS", _variable1];
			[player, _notification, [_desc,_title,""], objNull, "FAILED"] call BIS_fnc_taskCreate;
		} else
		{
			private _errorType = typeName _variable1;
			["ERROR", format ["Provided variable is %1, expected STRING. Check where you call F90_fnc_showNotification", _errorType]] call F90_fnc_debug;
		};
	}
};




