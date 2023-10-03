F90_Debug = true;
F90_MISSIONID = "AWSP" + (str floor random 9) + (str floor random 9) + (str floor random 9) + (str floor random 9) + (str floor random 9) + (str random 9);

["initVars", format ["Initializing variables for game id: %1", F90_MISSIONID]] call F90_fnc_debug;
MILCASH_Player = 10000;

MILCASH_OPFOR = 10000;
MILCASH_BLUFOR = 10000;
MILCASH_GUER = 10000;

AWSP_OPFORSkill = 0.25;
AWSP_GUERSkill = 0.3;

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
	["Rifleman","I_G_Soldier_F",10],
	["Machine Gunner", "I_G_Soldier_AR_F",20],
	["Medic", "I_G_medic_F",30],
	["AT Soldier", "I_G_Soldier_LAT_F",40],
	["Grenadier","I_G_Soldier_GL_F",50],
	["Engineer","I_G_engineer_F",60]
];

AWSPRecruit_SelectedRecruit = [["Rifleman","I_G_Soldier_F",10]];

//--Dialog ID variables--
StartMenu_Main = 1002;
StartMenu_ListBox = 2200;
RecruitMenu_ListBox = 3500;
RecruitMenu_PriceText = 3001;


initVarDone = true;
diag_log "[F90 initVars] Finished creating game variables";