private ["_eosKills"];
_eosKills= F90_MISSION_SETTINGS getvariable "EOSkillCounter";

	if (isnil "_eosKills") then {_eosKills=0;}else{
		_eosKills= F90_MISSION_SETTINGS getvariable "EOSkillCounter";
				};		
				
_eosKills=_eosKills + 1;
F90_MISSION_SETTINGS setvariable ["EOSkillCounter",_eosKills,true];

hint format ["Units Killed: %1",_eosKills];