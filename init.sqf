//_mainDialog = createDialog "startMenu";
//if(!_mainDialog) then {diag_log "[F90 init] Couldn't open dialog"} else {diag_log "[F90 init] Dialog should visible"};

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
player addAction ["Info Tab", {[] call F90_fnc_openInfoTab;}];
[player] apply {
	_x call F90_fnc_addRevive;
};

while {!F90_MissionStarted} do 
{
	closeDialog 2;
	[] call F90_fnc_openInfoTab;
	hint "Use the scroll menu and select 'InfoTab' to start a new game or load saves";
	sleep 8;
	hint "";
};
