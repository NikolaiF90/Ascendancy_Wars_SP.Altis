/* General config */
L_ambiCivs_maxCivs                 	= 25;		// Maximum number of civilians spawned at the same time
L_ambiCivs_minSpawnDistance 		= 100;		// Minimum distance to players when spawning civilians
L_ambiCivs_maxDistanceToPlayers    	= 300;		// Maximum distance to players, both for spawning and deleting civilians
L_ambiCivs_inhabitChance 			= 0.8;		// Population density. 0 = No house will be rendered suitable, 1 = every house will be suitable

L_ambiCivs_increaseWithElevation 	= true;		// Increase the spawn and delete range if players are elevated (so they can look "into" the city)
	L_ambiCivs_elevationMultiplier	    = 3;		// Maximum factor the distance will be multiplied with
	L_ambiCivs_maxElevationDifference   = 500;		// At which height the maximum multiplicator will be applied
	
L_ambiCivs_autoBehaviour			= true;		// Whether the civilans should use default behaviour or not. Disabling this will just spawn them and nothing else.
L_ambiCivs_customInitFunction		= "";		// Function that will be called when spawning a civilian. Arguments passed are [Civilian,Assigned House]. E.g: L_ambiCivs_customInitFunction = MyFunction;


/* Performance - Lower numbers = Quicker results but worse performance, especially with high player counts. */
L_ambiCivs_deleteCheckInterval 		= 4;		// How often the script checks in on spawned civilians in seconds
L_ambiCivs_spawnCheckInterval 		= 1;		// How often the script will try to spawn a new civilian in seconds


/* Enabled from the start? True = Yes, False = No */
L_ambiCivs_enabled = true;


/* Debug mode? (Shows debug markers on map on the machine the script is run from) */
L_ambiCivs_debug = false;

