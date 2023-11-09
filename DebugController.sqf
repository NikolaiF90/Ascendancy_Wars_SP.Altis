/*
	Author: PrinceF90 
 
	Description: 
		This function is used for debugging purposes. It logs the provided  _text  message to the game's debug log and, if  _visibleInGame  is set to true, also displays the message in the in-game chat. 
	
	Parameters: 
		0: STRING - The name of the file or source where the debug message originates from. 
		1: STRING - The debug message to be logged. 
		2: BOOL (optional) - Determines whether the debug message should be displayed in the in-game chat. Defaults to false if not provided. 
	
	Returns: 
		None 
	
	Example:
		["MyScript", "This is a debug message"] call F90_fnc_debug;
		["MyScript", format ["This is a debug %1", _message], true] call F90_fnc_debug;
*/

params ["_fileName", "_text", "_visibleInGame"];

if (isNil "_fileName") exitWith { diag_log "F90Debug: (ERROR) F90_fnc_debug does not accept empty parameters!" };

if (_fileName == "") then { _fileName = "DEBUG" };
if (isNil "_visibleInGame") then { _visibleInGame = false };

if(F90_Debug)then
{
	diag_log format ["[F90 %1] %2", _fileName, _text];
	if (_visibleInGame) then 
	{
		systemChat format ["[F90 %1] %2", _fileName, _text];
	};
};