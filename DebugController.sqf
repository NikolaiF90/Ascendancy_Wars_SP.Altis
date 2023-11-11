/*
	Author: PrinceF90 
 
	Description: 
		This function is used for debugging purposes. It logs the provided  _text  message to the game's debug log and, if  _visibleInGame  is set to true, also displays the message in the in-game chat. 
	
	Parameters: 
		0: BOOL - Specifies whether debug mode is enabled or not. 
		1: STRING - The name of the file or module for the debug message. 
		2: STRING - The text of the debug message. 
		3: BOOL - (optional) Specifies whether the debug message should be visible in the in-game chat system. Default is false. 
	
	Returns: 
		0
*/
//	Example (OLD): ["MyScript","This is a debug message", true] call F90_fnc_debug;
//	Example (NEW): [true,"MyScript","This is a debug message", true] call F90_fnc_debug;

params ["_var1", "_var2", "_var3", "_var4"];

private ["_debugOn","_fileName","_text","_visibleInGame"];

if (typeName _var1 == "BOOL") then 
{
	_debugOn = _var1;
	_fileName = _var2;
	_text = _var3;
	
	if (isNil "_var4") then { _visibleInGame = false } else { _visibleInGame = _var4 };
};

// For old syntax compatibility
if (typeName _var1 == "STRING") then 
{
	_debugOn = true;
	_fileName = _var1; 
	_text = _var2;

	if (isNil "_var3") then { _visibleInGame = false } else { _visibleInGame = _var3 };
};

if (isNil "_fileName") exitWith { diag_log "F90Debug: (ERROR) F90_fnc_debug does not accept empty parameters!" };
if (_fileName == "") then { _fileName = "DEBUG" };

if(_debugOn)then
{
	diag_log format ["[F90 %1] %2", _fileName, _text];
	if (_visibleInGame) then 
	{
		systemChat format ["[F90 %1] %2", _fileName, _text];
	};
};