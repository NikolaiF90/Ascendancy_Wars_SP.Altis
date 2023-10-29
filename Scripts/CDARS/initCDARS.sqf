/*
	Description: This function is responsible for configuring the CDARS settings. 
	It determines side activity, updates intel, and manages various variables related to player and enemy activities. 
 
	Syntax:  
	[] call F90_fnc_configureCDARS;  
	
	Parameters: 
	None 
	
	Return: 
	None 
*/

configureCDARSDone = false;
[] call F90_fnc_configureCDARS;

waitUntil {configureCDARSDone};

// Determines side activity. Increased based on player activity.
// Useful for generating side mission and updating intel 
CDARS_OPFORActivity = 0;
CDARS_BLUFORActivity = 0;
// Increased when player do global activities such as attacking enemy garrison and decreased when not doing anything
CDARS_GUERActivity = 0; 
CDARS_PlayerLastKnownLocation = []; // Todo: Add to persistent

CDARS_OPFORLaunchedAttacks = 0; // Attacks launched by enemy commander
CDARS_BountyHunterSent = -1; // 1 means bounty hunter has been sent
CDARS_OPFORReinforcementStatusCheck = 60; // Time interval in seconds to check for reinforcement status
CDARS_OPFORReturnCountdown = 5; // Countdown * CDARS_OPFORReinforcementStatusCheck until OPFOR commander decided to send back their troops
CDARS_OPFORReplenishStatusInterval = 10; // Time interval in seconds for enemy commander to check for replenishing units


[] spawn 
{
	while {true} do 
	{	
		// Activity Handler 
		if (CDARS_GUERActivity > 0) then 
		{
			CDARS_GUERActivity = CDARS_GUERActivity - 2;
			if (CDARS_GUERActivity < 0) then 
			{
				CDARS_GUERActivity = 0;
			};
		};
		["DEFAULT"] spawn F90_fnc_eastCommanderHandler;
		sleep (CDARS_ActivityIntervals * 60);
	};
};