//_mainDialog = createDialog "startMenu";
//if(!_mainDialog) then {diag_log "[F90 init] Couldn't open dialog"} else {diag_log "[F90 init] Dialog should visible"};

/*
	Use debug controller to debug the scripts.
	Just set debug = true in initVars.sqf and the Debug Controller will automatically
	output any debug results into .rpt file 

	["myScriptName", format ["%1 goes here", _text]] call F90_fnc_debug;

*/
diag_log "[F90 Init] Starting Ascendancy Wars SP";

initVarDone = false;
[] call F90_fnc_initVars;

waitUntil {initVarDone};

[] call F90_fnc_eosInit;
[] call F90_fnc_initPersistent;
player addAction ["Persistent", {[] call F90_fnc_openPersistentTab;}];
#include "L_ambiCivs\init.sqf"

flagfia_0 addAction ["Recruit", "Scripts\Shop\recruitFia.sqf"];

