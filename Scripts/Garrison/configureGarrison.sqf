/*
	Configuration file for Zoning Garrison System
*/

Garrison_Debug = false; // True to turn on debugging
Garrison_SpawnDistance = 350; // Distance of player from the zone (in meters) for enemy units to spawn
Garrison_HeightLimit = false; // true, the zone will ignore spawning if player is in helicopter
Garrison_CheckInterval = 3; // Time in seconds to check for player presence in each zone
Garrison_ThreatRange = 5; // Distance other units from the zone until garrison detects them as a threat

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

AWSP_ZoneMarkers = 
[
	"respawn_guerrila",

	"outpost_0",
	"outpost_1",
	"outpost_2",
	"outpost_3",
	"outpost_4",
	"outpost_5",
	"outpost_6", 
	"outpost_7",

	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4",
	"resource_5",
	"resource_6",
	"resource_7",
	"resource_8",

	"factory_0",
	"factory_1",

	"airport_0",
	"airport_1",
	"airport_2"
];

configureGarrisonDone = true;