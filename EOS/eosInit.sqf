diag_log "[F90 eosInit] Starting EOS...";
null=[] execVM "eos\core\spawn_fnc.sqf";
onplayerConnected 
{
	[] execVM "eos\Functions\EOS_Markers.sqf";
};
/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call F90_fnc_eosLaunch;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;

EXAMPLE CALL - BASTION
 null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call Bastion_Spawn;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
*/
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=true;		// Counts killed units

null = [Outposts,[2,3,75],[0,0,100],[0,0],[0,0],[0,350,TRUE]] call F90_fnc_eosLaunch;
//null = [["EOSmot_1","EOSmot_2"],[0,0,100],[0,0,100],[3,1,90],[2,60],[0,0],[1,0,90],[0,350,EAST,FALSE]] call F90_fnc_eosLaunch;
//null = [["BAS_zone_1"],[0,1],[0,2],[0],[1,2],[0,0,EAST,TRUE],[0,2,120,TRUE,FALSE]] call F90_fnc_bLaunch;