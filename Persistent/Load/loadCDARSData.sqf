params ["_slot"];

["loadCDARSData", format ["Loading CDARS data from slot %1", _slot]] call F90_fnc_debug;

configureCDARSDone = false;
[] call F90_fnc_configureCDARS;

waitUntil {configureCDARSDone};

// Determines side activity. Increased based on player activity.
// Useful for generating side mission and updating intel 
CDARS_OPFORActivity = ["CDARSOPFORActivity", _slot] call F90_fnc_loadData;
CDARS_BLUFORActivity = ["CDARSBLUFORActivity", _slot] call F90_fnc_loadData;

// Increased when player do global activities such as attacking enemy garrison and decreased when not doing anything
CDARS_GUERActivity = ["CDARSGUERActivity", _slot] call F90_fnc_loadData;
CDARS_PlayerLastKnownLocation = ["CDARSPlayerLastKnownLocation", _slot] call F90_fnc_loadData;

CDARS_OPFORLaunchedAttacks = 0; // Attacks launched by enemy commander
CDARS_OPFORReinforcementStatusCheck = 60; // Time interval in seconds to check for reinforcement status
CDARS_OPFORReturnCountdown = 5; // Countdown * CDARS_OPFORReinforcementStatusCheck until OPFOR commander decided to send back their troops
CDARS_OPFORReplenishStatusInterval = 10; // Time interval in seconds for enemy commander to check for replenishing units