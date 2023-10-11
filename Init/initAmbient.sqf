configureAmbientDone = false;
[] call F90_fnc_configureAmbient;
waitUntil {configureAmbientDone};

[] spawn 
{
	while {true} do 
	{
		Ambient_HousesArray = [] call F90_fnc_scanHouses;

		if (Ambient_ParkingEnabled) then 
		{
			if (count Ambient_HousesArray > 0) then 
			{
				for "_i" from 0 to (count Ambient_HousesArray -1) do 
				{
					private _house = Ambient_HousesArray # _i;

					["initAmbient", format ["Finding parking spot for house %1 : %2", _i, _house]] call F90_fnc_debug;
					[_house] call F90_fnc_findParking;
					Ambient_CheckedHouses pushBack _house;
				};
			};
			
			if (count Ambient_CheckedHouses > 0) then 
			{
				{
					[_x] call F90_fnc_parkingResetCheck;
				}forEach Ambient_CheckedHouses;
			};

			if (count Ambient_SpawnedCars > 0) then 
			{
				{
					[_x] call F90_fnc_despawnVehicleCheck;
				}forEach Ambient_SpawnedCars;
			};
		};

		sleep Ambient_CheckInterval;
	};
};