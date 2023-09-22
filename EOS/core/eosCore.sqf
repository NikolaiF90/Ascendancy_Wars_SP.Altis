/*
	Original EOS by BangaBob
	Reworked by Nikolai F90 v1.0

	Syntax:
	null = [["outpost_1", east],[_houseGarrisons,_garrisonSize],[_footPatrols,_patrolSize],[_lightVehicles,_vehicleSize],[_armoured,_statics,_choppers,_chopperSize],_settings, false] execVM "eos\core\eosCore.sqf";

	Parameters:
	0[0]	zoneMarker 			String 		The variable name of the zone marker 
	0[1]	zoneOwner 			Side 		The side of the zone owner e.g independent 	
	1[0]	houseGarrison		Number 		Amount of group to garrison houses 
	1[1]	garrisonSize 		Array		Array of min to max count of garrisons to spawn 
	2[0] 	footPatrols 		Number 		Amount of foot patrol groups to spawn 
	2[1] 	patrolSize 			Array 		Array of min to max count of patrols to spawn 
	3[0] 	lightVehicles 		Number 		Amount of light vehicles to spawn 
	3[1] 	vehicleSize 		Array 		Array of min to max count of vehicle cargo 
	4[0] 	armoured 			Number 		Amount of armoured vehicles to spawn 
	4[1] 	statics 			Number 		Amount of statics to spawn 
	4[2]	choppers 			Number 		Amount of choppers to spawn
	4[3]	chopperSize 		Array 		Array of min to max count of chopper cargo
	5[0]	faction 
	5[1]	markerType 
	5[2]	distance 
	5[3]	side 	
	5[4]	heightLimit 
	6		cache 	

*/
private [
	"_newpos",
	"_cargoType",
	"_vehType",
	"_dGrp",
	"_markerDir",
	"_zoneOwner",
	"_bGroup",
	"_fGrp",
	"_fSize",
	"_fGrps",
	"_eGrp",
	"_eGrps",
	"_dGrps",
	"_aMin",
	"_aSize",
	"_aGrps",
	"_aGrp",
	"_bMin",
	"_units",
	"_bSize",
	"_bGrps",
	"_bGrp",
	"_trig",
	"_cache",
	"_grp",
	"_crew",
	"_vehicle",
	"_activationCondition",
	"_spawnDistance",
	"_markerAlpha",
	"_settings",
	"_cGrp",
	"_cSize",
	"_cGrps",
	"_taken",
	"_clear",
	"_enemyFaction",
	"_faction",
	"_n",
	"_eosAct",
	"_zoneTrigger",
	"_debug",
	"_zoneMarker",
	"_zonePos",
	"_markerX",
	"_markerY"
];

_debug = true;

_zone = _this # 0;
_zoneMarker = _zone # 0;
_zoneOwner = _zone # 1;
_markerSize = getMarkerSize _zoneMarker;
_markerX = _markerSize # 0;
_markerY = _markerSize # 1;
_zonePos = markerpos _zoneMarker;
_markerDir = markerDir _zoneMarker;

//	House Garrison
_a = _this # 1;
_aGrps = _a # 0;
_aSize = _a # 1;
_aMin = _aSize # 0;

//	Foot Patrols
_b = _this # 2;
_bGrps = _b # 0;
_bSize = _b # 1;
_bMin = _bSize # 0;

//	Light Vehicles
_c = _this # 3;
_cGrps = _c # 0;
_cSize = _c # 1;

//	Armoured
_d = _this # 4;
_dGrps = _d # 0;

//	Statics
_eGrps = _d # 1;

//	Choppers
_fGrps = _d # 2;
_fSize = _d # 3;

_settings = _this # 5;
_faction = _settings # 0;
_spawnDistance = _settings # 1;
_heightLimit = _settings # 2;

_cache = _this # 6;


// INITIATE ZONE
_trig = format ["F90Trigger%1",_zoneMarker];

if (!_cache) then 
{
	if (_heightLimit) then 
	{
		_activationCondition = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
	}else
	{
		_activationCondition = "{vehicle _x in thisList && isplayer _x} count allUnits > 0";
	};

	_zoneTrigger = createTrigger ["EmptyDetector",_zonePos]; 
	_zoneTrigger setTriggerArea [(_spawnDistance + _markerX), (_spawnDistance + _markerY), _markerDir, FALSE]; 
	_zoneTrigger setTriggerActivation ["ANY","PRESENT",true];
	_zoneTrigger setTriggerTimeout [1, 1, 1, true];
	_zoneTrigger setTriggerStatements [_activationCondition,"",""];

	F90_MISSION_TRIGGERS setvariable [_trig,_zoneTrigger];	
}else
{
	_zoneTrigger = F90_MISSION_TRIGGERS getvariable _trig;	
};
		
_zoneMarker setmarkerAlpha 0.5;
if (!(getmarkercolor _zoneMarker == VictoryColor)) then 	//IF MARKER IS GREEN DO NOT CHANGE COLOUR
{
	private _iconName = format ["%1_icon", _zoneMarker];
	private _iconPos = getMarkerPos _zoneMarker;
	private _zoneIcon = createMarker [_iconName, _iconPos];
	_zoneIcon setMarkerType "loc_Bunker";
	_zoneIcon setMarkerSize [2,2];
	_zoneIcon setMarkerColor "colorOPFOR";
	_zoneIcon setMarkerText "CSAT Outpost";
	_zoneMarker setmarkercolor hostileColor;
};

switch (_zoneOwner) do {
	case east: 
	{
		_faction = 0;
	};
	case west:
	{
		_faction = 1;
	};
	case independent:
	{
		_faction = 2;
	};
	case civilian:
	{
		_faction = 3;
	};
};
					
waituntil {triggeractivated _zoneTrigger};	//WAIT UNTIL PLAYERS IN ZONE
if (!(getmarkercolor _zoneMarker == "colorblack"))then 
{

	// SPAWN HOUSE PATROLS
	for "_counter" from 1 to _aGrps do 
	{
		if (isnil "_aGrp") then {_aGrp=[];};
		if (_cache) then 
		{
			_cacheGrp=format ["HP%1",_counter];
			_units=_zoneTrigger getvariable _cacheGrp;	
			_aSize=[_units,_units];
			_aMin=_aSize select 0;
			if (_debug)then{player sidechat format ["ID:%1,restore - %2",_cacheGrp,_units];};
		};

		if (_aMin > 0) then 
		{
			_aGroup=[_zonePos,_aSize,_faction,_zoneOwner] call EOS_fnc_spawngroup;	
			if (!surfaceiswater _zonePos) then 
			{
				0=[_zonePos,units _aGroup,_markerX,0,[0,20],true,true] call shk_fnc_fillhouse;
			}else
			{
				0 = [_aGroup,_zoneMarker] call EOS_fnc_taskpatrol;
			};

			_aGrp set [count _aGrp,_aGroup];
			0=[_aGroup,"INFskill"] call eos_fnc_grouphandlers;

			if (_debug) then 
			{
				PLAYER SIDECHAT (format ["Spawned House Patrol: %1",_counter]);
				0= [_zoneMarker,_counter,"House Patrol",getpos (leader _aGroup)] call EOS_debug;
			};
		};
	};
		
	// SPAWN PATROLS
	for "_counter" from 1 to _bGrps do 
	{
		if (isnil "_bGrp") then {_bGrp=[];};
		if (_cache) then 
		{
			_cacheGrp=format ["PA%1",_counter];
			_units=_zoneTrigger getvariable _cacheGrp;	
			_bSize=[_units,_units];
			_bMin=_bSize select 0;
			
			if (_debug)then{player sidechat format ["ID:%1,restore - %2",_cacheGrp,_units];};
		};
		
		if (_bMin > 0) then 
		{	
			_pos = [_zoneMarker,true] call SHK_pos;			
			_bGroup=[_pos,_bSize,_faction,_zoneOwner] call EOS_fnc_spawngroup;
			0 = [_bGroup,_zoneMarker] call EOS_fnc_taskpatrol;
			_bGrp set [count _bGrp,_bGroup];
										
			0=[_bGroup,"INFskill"] call eos_fnc_grouphandlers;
			
			if (_debug) then 
			{
				PLAYER SIDECHAT (format ["Spawned Patrol: %1",_counter]);
				0= [_zoneMarker,_counter,"patrol",getpos (leader _bGroup)] call EOS_debug;
			};
		};
	};	
	
	//SPAWN LIGHT VEHICLES
	for "_counter" from 1 to _cGrps do 
	{	
		if (isnil "_cGrp") then {_cGrp=[];};	
	
		_newpos=[_zoneMarker,50] call EOS_fnc_findSafePos;
		if (surfaceiswater _newpos) then {_vehType=8;_cargoType=10;}else{_vehType=7;_cargoType=9;};
	
		_cGroup=[_newpos,_zoneOwner,_faction,_vehType]call EOS_fnc_spawnvehicle;
		if ((_cSize select 0) > 0) then
		{
			0=[(_cGroup select 0),_cSize,(_cGroup select 2),_faction,_cargoType] call eos_fnc_setcargo;
		};
						
		0=[(_cGroup select 2),"LIGskill"] call eos_fnc_grouphandlers;
		0 = [(_cGroup select 2),_zoneMarker] call EOS_fnc_taskpatrol;
		_cGrp set [count _cGrp,_cGroup];			
								
		if (_debug) then 
		{
			player sidechat format ["Light Vehicle:%1 - r%2",_counter,_cGrps];
			0= [_zoneMarker,_counter,"Light Veh",(getpos leader (_cGroup select 2))] call EOS_debug;
		};
	};	
		
	//SPAWN ARMOURED VEHICLES
	for "_counter" from 1 to _dGrps do 
	{
		if (isnil "_dGrp") then {_dGrp=[];};
	
		_newpos=[_zoneMarker,50] call EOS_fnc_findSafePos;
		if (surfaceiswater _newpos) then {_vehType=8;}else{_vehType=2;};
			
		_dGroup=[_newpos,_zoneOwner,_faction,_vehType]call EOS_fnc_spawnvehicle;
					
		0=[(_dGroup select 2),"ARMskill"] call eos_fnc_grouphandlers;
		0 = [(_dGroup select 2),_zoneMarker] call EOS_fnc_taskpatrol;
		_dGrp set [count _dGrp,_dGroup];
							
		if (_debug) then 
		{
			player sidechat format ["Armoured:%1 - r%2",_counter,_dGrps];
			0= [_zoneMarker,_counter,"Armour",(getpos leader (_dGroup select 2))] call EOS_debug;
		};
	};
		
	//SPAWN STATIC PLACEMENTS
	for "_counter" from 1 to _eGrps do 
	{
		if (surfaceiswater _zonePos) exitwith {};
		if (isnil "_eGrp") then {_eGrp=[];};
				
		_newpos=[_zoneMarker,50] call EOS_fnc_findSafePos;
			
		_eGroup=[_newpos,_zoneOwner,_faction,5]call EOS_fnc_spawnvehicle;
		
		0=[(_eGroup select 2),"STAskill"] call eos_fnc_grouphandlers;
		_eGrp set [count _eGrp,_eGroup];
							
		if (_debug) then 
		{
			player sidechat format ["Static:%1",_counter];
			0= [_zoneMarker,_counter,"Static",(getpos leader (_eGroup select 2))] call EOS_debug;
		};
	};	
		
	//SPAWN CHOPPER
	for "_counter" from 1 to _fGrps do 
	{
		if (isnil "_fGrp") then {_fGrp=[];};	
		if ((_fSize select 0) > 0) then {_vehType=4}else{_vehType=3};
		_newpos = [(markerpos _zoneMarker), 1500, random 360] call BIS_fnc_relPos;	
		_fGroup=[_newpos,_zoneOwner,_faction,_vehType,"fly"]call EOS_fnc_spawnvehicle;	
		_fGrp set [count _fGrp,_fGroup];
						
						
		if ((_fSize select 0) > 0) then 
		{
			_cargoGrp = createGroup _zoneOwner;
			0=[(_fGroup select 0),_fSize,_cargoGrp,_faction,9] call eos_fnc_setcargo;
			0=[_cargoGrp,"INFskill"] call eos_fnc_grouphandlers;
			_fGroup set [count _fGroup,_cargoGrp];
			null = [_zoneMarker,_fGroup,_counter] execvm "eos\functions\TransportUnload_fnc.sqf";
		}else
		{
			_wp1 = (_fGroup select 2) addWaypoint [(markerpos _zoneMarker), 0];  
			_wp1 setWaypointSpeed "FULL";  
			_wp1 setWaypointType "SAD";
		};
			
		0=[(_fGroup select 2),"AIRskill"] call eos_fnc_grouphandlers;
			
		if (_debug) then 
		{
			player sidechat format ["Chopper:%1",_counter];
			0= [_zoneMarker,_counter,"Chopper",(getpos leader (_fGroup select 2))] call EOS_debug;
		};
	};		
	
	//SPAWN ALT TRIGGERS	
	_clear = createTrigger ["EmptyDetector",_zonePos]; 
	_clear setTriggerArea [_markerX,_markerY,_markerDir,FALSE]; 
	_clear setTriggerActivation [_zoneOwner,"NOT PRESENT",true]; 
	_clear setTriggerStatements ["this","",""]; 
				
	_taken = createTrigger ["EmptyDetector",_zonePos]; 
	_taken setTriggerArea [_markerX,_markerY,_markerDir,FALSE];
	_taken setTriggerActivation ["ANY","PRESENT",true]; 
	_taken setTriggerStatements ["{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0","",""]; 
	_eosAct=true;
};	
while {_eosAct} do
	{
	// IF PLAYER LEAVES THE AREA OR ZONE DEACTIVATED
	if (!triggeractivated _zoneTrigger || getmarkercolor _zoneMarker == "colorblack") exitwith 
		{
		if (_debug) then {if (!(getmarkercolor _zoneMarker == "colorblack")) then {hint "Restarting Zone AND deleting units";}else{hint "EOS zone deactivated";};};		
//CACHE LIGHT VEHICLES
	if (!isnil "_cGrp") then 
				{				
						{	_vehicle = _x select 0;_crew = _x select 1;_grp = _x select 2;
									if (!alive _vehicle || {!alive _x} foreach _crew) then { _cGrps= _cGrps - 1;};	
												{deleteVehicle _x} forEach (_crew);		
														if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};												
																			{deleteVehicle _x} foreach units _grp;deleteGroup _grp;
						}foreach _cGrp;
if (_debug) then {player sidechat format ["ID:c%1",_cGrps];};};
											
// CACHE ARMOURED VEHICLES
		if (!isnil "_dGrp") then 
				{				
						{	_vehicle = _x select 0;_crew = _x select 1;_grp = _x select 2;
									if (!alive _vehicle || {!alive _x} foreach _crew) then {_dGrps= _dGrps - 1;};	
												{deleteVehicle _x} forEach (_crew);		
														if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};												
																			{deleteVehicle _x} foreach units _grp;deleteGroup _grp;
						}foreach _dGrp;
if (_debug) then {player sidechat format ["ID:c%1",_dGrps];};};

// CACHE PATROL INFANTRY					
	if (!isnil "_bGrp") then 
				{		_n=0;					
						{	_n=_n+1;_units={alive _x} count units _x;_cacheGrp=format ["PA%1",_n];
	if (_debug) then{player sidechat format ["ID:%1,cache - %2",_cacheGrp,_units];};
						_zoneTrigger setvariable [_cacheGrp,_units];		
						{deleteVehicle _x} foreach units _x;deleteGroup _x;
						}foreach _bGrp;
				};
						
// CACHE HOUSE INFANTRY
	if (!isnil "_aGrp") then 
				{		_n=0;					
						{	_n=_n+1;_units={alive _x} count units _x;_cacheGrp=format ["HP%1",_n];
	if (_debug) then{player sidechat format ["ID:%1,cache - %2",_cacheGrp,_units];};
						_zoneTrigger setvariable [_cacheGrp,_units];		
						{deleteVehicle _x} foreach units _x;deleteGroup _x;
						}foreach _aGrp;
				};
					
// CACHE MORTARS			
	if (!isnil "_eGrp") then 
				{			
						{	_vehicle = _x select 0;_crew = _x select 1;_grp = _x select 2;
									if (!alive _vehicle || {!alive _x} foreach _crew) then {_eGrps= _eGrps - 1;};			
														{deleteVehicle _x} forEach (_crew);
															if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};													
																	{deleteVehicle _x} foreach units _grp;deleteGroup _grp;
						}foreach _eGrp;};	
						
// CACHE HELICOPTER TRANSPORT
	if (!isnil "_fGrp") then 
				{			
						{	_vehicle = _x select 0;_crew = _x select 1;_grp = _x select 2; _cargoGrp = _x select 3;
									if (!alive _vehicle || {!alive _x} foreach _crew) then {_fGrps= _fGrps - 1;};			
														{deleteVehicle _x} forEach (_crew);
															if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};													
																	{deleteVehicle _x} foreach units _grp;deleteGroup _grp;
																	if (!isnil "_cargoGrp") then {
																	{deleteVehicle _x} foreach units _cargoGrp;deleteGroup _cargoGrp;};
																	
						}foreach _fGrp;};	
						
_eosAct=false;
if (_debug) then {hint "Zone Cached";};
};
	if (triggeractivated _clear and triggeractivated _taken)exitwith 
			{// IF ZONE CAPTURED BEGIN CHECKING FOR ENEMIES
				_cGrps=0;_aGrps=0;_bGrps=0;_dGrps=0;_eGrps=0;_fGrps=0;		
				while {triggeractivated _zoneTrigger AND !(getmarkercolor _zoneMarker == "colorblack")} do 
						{
							if (!triggeractivated _clear) then
							{
								_zoneMarker setmarkercolor hostileColor;
								_zoneMarker setmarkerAlpha 1;
								if (_debug) then {hint "Zone Lost";};
										}else{
											_zoneMarker setmarkercolor VictoryColor;
											_zoneMarker setmarkerAlpha 0.5;
											if (_debug) then {hint "Zone Captured";};
											};
				sleep 1;};
// PLAYER LEFT ZONE				
_eosAct=false;		
			};sleep 0.5;};

deletevehicle _clear;deletevehicle _taken;	
	
if (!(getmarkercolor _zoneMarker == "colorblack")) then {	
	null = [[_zoneMarker, _zoneOwner],[_aGrps,_aSize],[_bGrps,_bSize],[_cGrps,_cSize],[_dGrps,_eGrps,_fGrps,_fSize],_settings,true] execVM "eos\core\eosCore.sqf";
	}else{_zoneMarker setmarkeralpha 0;};