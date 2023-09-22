diag_log "[F90 initVars] Initializing game variables";
F90_Debug = true;

MILCASH_OPFOR = 10000;
MILCASH_BLUFOR = 10000;
MILCASH_GUER = 10000;

Outposts = 
[
	["outpost_0", east],
	["outpost_1", east],
	["outpost_2", independent]
];

//--Dialog ID variables--
StartMenu_Main = 1002;
StartMenu_ListBox = 2200;


initVarDone = true;
diag_log "[F90 initVars] Finished creating game variables";