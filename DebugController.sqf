/*
	Script Debug Controller by PrinceF90 v1.0
	Usage:
	["myScript.sqf", format ["%1 goes here", _text]] call F90_fnc_debug;
*/

params ["_file", "_text"];

if(F90_Debug)then
{
	diag_log format ["[F90 %1] %2", _file, _text];
};