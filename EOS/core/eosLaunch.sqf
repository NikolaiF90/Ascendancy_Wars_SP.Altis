/*
	EOS by BangaBob
	Reworked by Nikolai F90 v1.0

	Syntax:
	null = [["outpost_1", east],[3,1,100],[2,3,75],[0,0,100],[0,0],[0,0],[0,0,0],[0,350,TRUE]] call F90_fnc_eosLaunch;

	Parameters:
	0		zone			Array		Array of zone marker and owner 		
	1[0]	houseGuard		Number		Number of groups to spawn
	1[1]	multiplier		Number		Number to multiply the amount of spawned house guard
	1[2]	probability		Number		Probability of house guards being spawned
	2[0]	infantry		Number		Number of patrol groups to spawn
	2[1]	multiplier		Number		Number to multiply the amount of spawned foot patrols
	2[2]	probability 	Number 		Probability of foot patrols being spawned 
	3[0]	lightVehicle	Number		Number of vehicle groups to spawn
	3[1]	multiplier 		Number 		Number to multiply the vehicle's cargo 
	3[2]	probability  	Number 		Probability of light vehicles being spawned 
	4[0]	armoured		Number 		Number of armoured vehicle groups to spawn
	4[1]	probability		Number		Probability of armoured vehicles being spawned
	5[0]	statics			Number 		Number of statics to spawn 
	5[1] 	probability 	Number 		Probability of statics being spawned
	6[0]	choppers		Number 		Number of choppers to spawn 
	6[1]	multiplier 		Number 		Number to multiply the chopper's cargo 
	6[2]	probability 	Number 		Probability of choppers being spawned
	7[0]	faction
	7[1]	spawnDistance	
	7[2]	heightLimit 
 
*/
private 
[
	"_houseGarrisons",
	"_garrisonProbability",
	"_chopperSize",
	"_vehicleSize",
	"_garrisonSize",
	"_patrolSize",
	"_chopperMultiplier",
	"_choppers",
	"_statics",
	"_armoured",
	"_lightVehicles",
	"_vehicleMultiplier",
	"_patrolMultiplier",
	"_footPatrols",
	"_garrisonMultiplier"
];

_zone = _this # 0;

_HouseInfantry = _this # 1;
_houseGarrisons = _HouseInfantry # 0;
_garrisonMultiplier = _HouseInfantry # 1;
_garrisonProbability = _HouseInfantry # 2;

_infantry =	_this # 2;
_footPatrols = _infantry # 0;
_patrolMultiplier = _infantry # 1;
_patrolProbability = _infantry # 2;

_LVeh = _this # 3;
_lightVehicles = _LVeh # 0;
_vehicleMultiplier = _LVeh # 1;
_vehicleProbability = _LVeh # 2;

_AVgrp = _this # 4;
_armoured = _AVgrp # 0;
_armouredProbability = _AVgrp # 1;

_SVgrp = _this # 5;
_statics = _SVgrp # 0;
_staticsProbability = _SVgrp # 1;

_CHGrp = _this # 6;
_choppers = _CHGrp # 0;
_chopperMultiplier = _CHGrp # 1;
_chopperProbability = _CHGrp # 2;

_settings = _this # 7;

if (_garrisonProbability > floor random 100) then {
	if (_garrisonMultiplier==0) then {_garrisonSize=[1,1]};
	if (_garrisonMultiplier==1) then {_garrisonSize=[2,4]};
	if (_garrisonMultiplier==2) then {_garrisonSize=[4,8]};
	if (_garrisonMultiplier==3) then {_garrisonSize=[8,12]};
	if (_garrisonMultiplier==4) then {_garrisonSize=[12,16]};
	if (_garrisonMultiplier==5) then {_garrisonSize=[16,20]};
	}else{_houseGarrisons=0;_garrisonSize=[1,1];};
	
if (_patrolProbability > floor random 100) then {	
	if (_patrolMultiplier==0) then {_patrolSize=[1,1]};
	if (_patrolMultiplier==1) then {_patrolSize=[2,4]};
	if (_patrolMultiplier==2) then {_patrolSize=[4,8]};
	if (_patrolMultiplier==3) then {_patrolSize=[8,12]};
	if (_patrolMultiplier==4) then {_patrolSize=[12,16]};
	if (_patrolMultiplier==5) then {_patrolSize=[16,20]};
	}else{_footPatrols=0;_patrolSize=[1,1];};	

if (_vehicleProbability > floor random 100) then {	
	if (_vehicleMultiplier==0) then {_vehicleSize=[0,0]};
	if (_vehicleMultiplier==1) then {_vehicleSize=[2,4]};
	if (_vehicleMultiplier==2) then {_vehicleSize=[4,8]};
	if (_vehicleMultiplier==3) then {_vehicleSize=[8,12]};
	if (_vehicleMultiplier==4) then {_vehicleSize=[12,16]};
	if (_vehicleMultiplier==5) then {_vehicleSize=[16,20]};
}else{_lightVehicles=0;_vehicleSize=[0,0];};

if (_armouredProbability > floor random 100) then {
}else{_armoured=0;};

if (_staticsProbability > floor random 100) then {
}else{_statics=0;};

if (_chopperProbability > floor random 100) then {
	if (_chopperMultiplier==0) then {_chopperSize=[0,0]};
	if (_chopperMultiplier==1) then {_chopperSize=[2,4]};
	if (_chopperMultiplier==2) then {_chopperSize=[4,8]};
	if (_chopperMultiplier==3) then {_chopperSize=[8,12]};
	if (_chopperMultiplier==4) then {_chopperSize=[12,16]};
	if (_chopperMultiplier==5) then {_chopperSize=[16,20]};
}else{_choppers=0;_chopperSize=[0,0]};

{
	_eosMarkers= F90_MISSION_MARKERS getvariable "EOSmarkers";
	if (isnil "_eosMarkers") then {_eosMarkers=[];};
		_eosMarkers set [count _eosMarkers,_x];
		F90_MISSION_MARKERS setvariable ["EOSmarkers",_eosMarkers,true];
		null = [_x,[_houseGarrisons,_garrisonSize],[_footPatrols,_patrolSize],[_lightVehicles,_vehicleSize],[_armoured,_statics,_choppers,_chopperSize],_settings, false] execVM "eos\core\eosCore.sqf";
}foreach _zone;