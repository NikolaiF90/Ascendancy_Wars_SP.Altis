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
			Ambient_HousesArray = Ambient_HousesArray - Ambient_CheckedHouses;
			if (count Ambient_HousesArray > 0) then 
			{
				{
					private _house = _x;

					[_house] call F90_fnc_findParking;
				} forEach Ambient_HousesArray;
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