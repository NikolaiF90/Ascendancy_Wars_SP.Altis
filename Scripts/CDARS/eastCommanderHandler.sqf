/*

*/

params ["_handlerAction", "_args"];

if (isNil {_handlerAction}) then 
{
	_handlerAction == "DEFAULT";
}else 
{
	if (_handlerAction == "") then 
	{
		_handlerAction == "DEFAULT";
	}
};

if (_handlerAction == "DEFAULT") then 
{
	private _grp = createGroup independent;
	private _indBoss = _grp createUnit ["I_Officer_Parade_Veteran_F", [0,0,0], [], 0, "FORM"];
	if (CDARS_GUERActivity == 0) then 
	{
		_indBoss sideChat "Keep it up. Stay low and you'll be good!";
	};
	if (CDARS_GUERActivity > 0 && CDARS_GUERActivity <= 5) then 
	{
		_indBoss sideChat "If you keep on doing that, the enemy might track you soon.";
	};
	if (CDARS_GUERActivity > 5 && CDARS_GUERActivity <= 15) then 
	{
		CDARS_PlayerLastKnownLocation = position player;
		_indBoss sideChat "Recent intel stated that the enemy had known about your location.";
		_indBoss sideChat "I suggest you to stay low, or move to another location.";
	};
	if (CDARS_GUERActivity > 15 && CDARS_GUERActivity <= 30) then 
	{
		if (CDARS_BountyHunterSent == -1) then 
		{
			CDARS_BountyHunterSent = 1;
			_indBoss sideChat "They enemy commander might send someone to hunt you down by now.";
			if (count CDARS_PlayerLastKnownLocation > 0) then 
			{
				// send bounty hunter
			} else 
			{
				CDARS_PlayerLastKnownLocation = position player;
			};
		};
	};
	if (CDARS_GUERActivity > 50) then 
	{
		if (CDARS_OPFORLaunchedAttacks == 0) then 
		{
			CDARS_OPFORLaunchedAttacks = CDARS_OPFORLaunchedAttacks + 1;
		};
	};
	deleteVehicle _indBoss;
};

if (_handlerAction == "REPLENISH") then 
{
	if (isNil {_args}) exitWith {["eastCommanderHandler", "(ERROR) Handler 'REPLENISH' prevented from running because _args is not provided"] call F90_fnc_debug};

	private _zoneIndex = _args # 0;
	private _group = nil;
	if (count _args > 1) then {_group = _args # 1;};
	
	if !(isNil {_group}) then
	{
		private _groupArray = [];
		{
			_groupArray pushBack _x;
		} forEach units _group;
		private _leader = _groupArray # 0;
		private _groupVehicle = assignedVehicle _leader;

		if !(_groupVehicle == objNull) then 
		{
			_groupArray orderGetIn true;
		};
		private _zone = AWSP_Zones # _zoneIndex;
		private _zonePos = _zone # 2;
		_group move _zonePos;
		[_group, _zoneIndex] spawn 
		{
			params ["_group", "_zoneIndex"];
			private _zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
			private _zone = AWSP_Zones # _zoneIndex;
			private _zonePos = _zone # 2;
			private _replenished = false;

			private _groupArray = [];
			{
				_groupArray pushBack _x;
			} forEach units _group;
			private _leader = _groupArray # 0;
			
			while {true} do
			{
				if (isNil {_group}) exitWith {};

				private _activeUnits = [];
				if ((position _leader) distance _zonePos <= 50) then 
				{
					private _cachedGroup = _zoneTrigger getVariable "Zone_CachedGroup";
					{
						if (!captive _x && alive _x) then 
						{
							_activeUnits pushBack _x;
						};
					} forEach units _group;

					if (count _activeUnits > 0 && !_replenished) then 
					{
						["eastCommanderHandler", format["OPFOR replenished %1 units to %2",count _activeUnits, _zone # 1]] call F90_fnc_debug;

						_replenished = true;
						_cachedGroup pushBack (count _activeUnits);

						_groupCount = count _cachedGroup;
						_zoneTrigger setVariable ["Zone_CachedGroup", _cachedGroup];
						_zoneTrigger setVariable ["Zone_GroupCount", _groupCount];
					};
				};

				if (_replenished && !(triggerActivated _zoneTrigger)) exitWith 
				{
					{
						deleteVehicle _x;
					} forEach _activeUnits;
					deleteGroup _group;
				};
				sleep CDARS_OPFORReplenishStatusInterval;
			};
		};
	};
};

if (_handlerAction == "SEND_REINFORCEMENT") then 
{
	if (isNil {_args}) exitWith {["eastCommanderHandler", "(ERROR) Handler 'SEND_REINFORCEMENT' from running because _args is not provided"] call F90_fnc_debug};
	private _zoneIndex = _args;
	private _reinforcementGroups = [];
	
	_reinforcementGroups = [_zoneIndex, east] call F90_fnc_sendReinforcement;

	if (count _reinforcementGroups > 0) then
	{
		// Create a new thread to check for reinforcement status; 
		[_zoneIndex, _reinforcementGroups] spawn 
		{
			params ["_zoneIndex", "_reinforcementGroups"];
			private _returnCountdown = CDARS_OPFORReturnCountdown;
			while {true} do 
			{
				private _zoneTrigger = AWSP_ZoneTrigger # _zoneIndex;
				private _zone = AWSP_Zones # _zoneIndex;
				private _zoneSide = _zone # 4;
				private _cachedGroup = _zoneTrigger getVariable "Zone_CachedGroup";

				if (count _reinforcementGroups == 0) exitWith {_zoneTrigger setVariable ["Zone_UnderAttack", false];}; 
				_returnCountdown = _returnCountdown - 1;
				
				if (_returnCountdown == 0) exitWith
				{
					if (_zoneSide == east) then 
					{
						if (count _cachedGroup > 0) then 
						{
							{
								["REPLENISH", [_zoneIndex, _x]] spawn F90_fnc_eastCommanderHandler;
							} forEach _reinforcementGroups;	
						} else 
						{
							// Capture the zone
						};
					} else 
					{
						// Go back
					};
					_zoneTrigger setVariable ["Zone_UnderAttack", false];
				};

				if (_zoneSide != east) then 
				{
					_zoneTrigger setVariable ["Zone_UnderAttack", true];
				};

				private _inactiveGroups = [];
				{
					if (isNil {_x}) then 
					{
						_reinforcementGroups set [_forEachIndex, 0];
					} else 
					{
						private _group = _x;
						private _activeUnits = [];

						{
							if (!captive _x && alive _x) then 
							{
								_activeUnits pushBack _x;
							};
						} forEach (units _group);

						if (count _activeUnits == 0) then 
						{
							_inactiveGroups pushBack _x;
						};

						if (count _activeUnits != count (units _group)) then 
						{
							_returnCountdown = 10;
						};
					};
				} forEach _reinforcementGroups;
				_reinforcementGroups = _reinforcementGroups - _inactiveGroups;
				_reinforcementGroups = _reinforcementGroups - [0];
				sleep CDARS_OPFORReinforcementStatusCheck;
			};
		};
	};
};