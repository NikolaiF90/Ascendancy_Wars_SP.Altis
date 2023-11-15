/*
	Use debug controller to debug the scripts.
	Just set debug = true and the Debug Controller will automatically
	output any debug results into .rpt file 

	["myScriptName", format ["%1 goes here", _text]] call F90_fnc_debug;

*/
AWSP_Debug = true;
[AWSP_Debug, "init", "[F90 Init] Starting Ascendancy Wars SP", false] call F90_fnc_debug;

F90_MissionStarted = false;
#include "L_ambiCivs\init.sqf"

[] call F90_fnc_initEconomy;
[] spawn F90_fnc_initShopItems;
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
	if (!dialog) then 
	{
		[commanderX] call F90_fnc_openInfoTab;
	};
	sleep 5;
};

waitUntil {F90_MissionStarted};

[] call F90_fnc_initAmbient;