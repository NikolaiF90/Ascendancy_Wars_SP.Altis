/*
	Use debug controller to debug the scripts.
	Just set debug = true and the Debug Controller will automatically
	output any debug results into .rpt file 

	["myScriptName", format ["%1 goes here", _text]] call F90_fnc_debug;

*/
diag_log "[F90 Init] Starting Ascendancy Wars SP";
F90_Debug = true;
F90_MissionStarted = false;
#include "L_ambiCivs\init.sqf"

[] call F90_fnc_initEconomy;
initDialogVarsDone = false;
[] call F90_fnc_initDialogVars;

waitUntil {initDialogVarsDone};
initVarsDone = false;
[] call F90_fnc_initVars;
waitUntil {initVarsDone};

[] call F90_fnc_initPersistent;
flagfia_0 addAction ["Recruit", {params ["_target", "_caller", "_actionId", "_arguments"]; [_caller] call F90_fnc_showRecruitMenu;}];
player addAction ["<t color='#2DC2DD'>Info Tab</t>", {params ["_target", "_caller", "_actionId", "_arguments"]; [_caller] call F90_fnc_openInfoTab;}, nil, 6, false, true, "", "true", -1, true];
[] call F90_fnc_initRevive;

while {!F90_MissionStarted} do 
{
	closeDialog 2;
	[commanderX] call F90_fnc_openInfoTab;
	hint "Use the scroll menu and select 'InfoTab' to start a new game or load saves";
	sleep 8;
	hint "";
};

waitUntil {F90_MissionStarted};

[] call F90_fnc_initAmbient;