diag_log "[F90 initVars] Initializing game variables";
F90_Debug = true;

MILCASH_Player = 10000;

MILCASH_OPFOR = 10000;
MILCASH_BLUFOR = 10000;
MILCASH_GUER = 10000;

Outposts = 
[
	["outpost_0", east],
	["outpost_1", east],
	["outpost_2", independent]
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