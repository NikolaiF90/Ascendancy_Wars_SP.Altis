/*
	Use debug controller to debug the scripts.
	Just set debug = true in initVars.sqf and the Debug Controller will automatically
	output any debug results into .rpt file 

	["myScriptName", format ["%1 goes here", _text]] call F90_fnc_debug;

*/
diag_log "[F90 Init] Starting Ascendancy Wars SP";
F90_Debug = true;
F90_MissionStarted = false;
#include "L_ambiCivs\init.sqf"

initDialogVarsDone = false;
[] call F90_fnc_initDialogVars;

waitUntil {initDialogVarsDone};
initVarsDone = false;
[] call F90_fnc_initVars;
waitUntil {initVarsDone};
[] call F90_fnc_initGarrison;

[] call F90_fnc_initPersistent;
flagfia_0 addAction ["Recruit", "Scripts\Shop\recruitFia.sqf"];
player addAction ["<t color='#2DC2DD'>Info Tab</t>", {[] call F90_fnc_openInfoTab;}, nil, 6, false];
[] call F90_fnc_initRevive;

while {!F90_MissionStarted} do 
{
	closeDialog 2;
	[] call F90_fnc_openInfoTab;
	hint "Use the scroll menu and select 'InfoTab' to start a new game or load saves";
	sleep 8;
	hint "";
};

waitUntil {F90_MissionStarted};

[] call F90_fnc_initAmbient;