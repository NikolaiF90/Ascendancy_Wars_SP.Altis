F90_MISSIONID = ["AWSP", 5] call F90_fnc_generateRandomID;

["initVars", format ["Initializing variables for game id: %1", F90_MISSIONID]] call F90_fnc_debug;
RANK_PLAYER = "PRIVATE";
HONOR_PLAYER = 0;

SIDE_PLAYER = independent;
SIDE_ENEMY = east;
SIDE_ALLY = west;

MILCASH_OPFOR = 10000;
MILCASH_BLUFOR = 10000;
MILCASH_GUER = 10000;

AWSP_OPFORSkill = 0.25;
AWSP_GUERSkill = 0.35;
AWSP_BLUFORSkill = 0.27;

AWSP_DaysPerHour = 1; // The speed at which time passes in the game

AWSP_MilitaryZones = 
[
//	OUTPOSTS
	"outpost_0",
	"outpost_1",
	"outpost_2",
	"outpost_3",
	"outpost_4",
	"outpost_5",
	"outpost_6",
	"outpost_7",
//	RESOURCES
	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4",
	"resource_5",
	"resource_6",
	"resource_7",
	"resource_8",
//	FACTORIES
	"factory_0",
	"factory_1",
//	AIRPORTS 
	"airport_0",
	"airport_1",
	"airport_2"
];

AWSP_GUERCars = 
[
	"I_MRAP_03_F",
	"I_MRAP_03_gmg_F",
	"I_MRAP_03_hmg_F"
];

AWSP_GUERTanks = 
[
	"I_LT_01_AA_F",
	"I_LT_01_AT_F",
	"I_LT_01_scout_F",
	"I_LT_01_cannon_F",
	"I_MBT_03_cannon_F"
];

AWSP_OPFORCars = 
[
	"O_MRAP_02_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_LSV_02_AT_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_unarmed_F"
];

AWSP_OPFORTanks = 
[
	"O_MBT_02_cannon_F",
	"O_MBT_02_railgun_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F",
	"O_APC_Tracked_02_AA_F"
];

/*---BUILDING VARIABLES---*/

AWSP_MGBuilding = 
[
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Cargo_HQ_V4_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_Cargo_Patrol_V4_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Tower_V2_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Cargo_Tower_V4_F",
	"Land_Cargo_Tower_V1_No1_F",
	"Land_Cargo_Tower_V1_No2_F",
	"Land_Cargo_Tower_V1_No3_F",
	"Land_Cargo_Tower_V1_No4_F",
	"Land_Cargo_Tower_V1_No5_F",
	"Land_Cargo_Tower_V1_No6_F",
	"Land_Cargo_Tower_V1_No7_F"
];

/*---SHOP VARIABLES---*/

// Recruit FIA
AWSP_FIARecruits = 
[
	["Rifleman","I_G_Soldier_F",1000],
	["Machine Gunner", "I_G_Soldier_AR_F",1500],
	["Medic", "I_G_medic_F",1500],
	["AT Soldier", "I_G_Soldier_LAT_F",2000],
	["Grenadier","I_G_Soldier_GL_F",1600],
	["Engineer","I_G_engineer_F",1500]
];

AWSPRecruit_SelectedRecruit = [["Rifleman","I_G_Soldier_F",10]];

AWSP_DaysPerHour = AWSP_DaysPerHour * 24;
// Set the time multiplier to x (1 hour of real time = x hours in-game)
setTimeMultiplier AWSP_DaysPerHour;

initVarsDone = true;
["initVars", "Finished creating game variables"] call F90_fnc_debug;