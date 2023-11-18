/*
	Configuration file for Zoning Garrison System
*/

Garrison_Debug = true; // True to turn on debugging
Garrison_SpawnDistance = 350; // Distance of player from the zone (in meters) for enemy units to spawn
Garrison_HeightLimit = false; // true, the zone will ignore spawning if player is in helicopter
Garrison_CheckInterval = 3; // Time in seconds to check for player presence in each zone
Garrison_ThreatRange = 5; // Distance other units from the zone until garrison detects them as a threat
configureGarrisonDone = true;

AWSP_WestUnits = 
[
	"B_Soldier_TL_F",
	"B_soldier_LAT_F",
	"B_Soldier_F",
	"B_Soldier_GL_F",
	"B_engineer_F",
	"B_medic_F",
	"B_soldier_AR_F",
	"B_Soldier_A_F"
];

AWSP_EastUnits = 
[
	"O_Soldier_TL_F",
	"O_Soldier_LAT_F",
	"O_Soldier_F",
	"O_Soldier_GL_F",
	"O_engineer_F",
	"O_medic_F",
	"O_Soldier_AR_F",
	"O_Soldier_A_F"
];

AWSP_IndependentUnits = 
[
	"I_Soldier_TL_F",
	"I_soldier_F",
	"I_Soldier_AA_F",
	"I_Soldier_GL_F",
	"I_engineer_F",
	"I_medic_F",
	"I_Soldier_AR_F",
	"I_Soldier_A_F"
];