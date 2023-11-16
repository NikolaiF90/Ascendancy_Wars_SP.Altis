doneConfigureEconomy = false;
[] call F90_fnc_configureEconomy;
waitUntil {doneConfigureEconomy};

commanderX setVariable ["Milcash", ECONOMY_PlayerStartingMoney];