/*
Removes all load radio triggers.
*/

["Removing radio triggers."] call skhpersist_fnc_LogToRPT;

{
	if (!(isNil { _x })) then
	{
		deleteVehicle _x;
		TriggerSaveSystem_SlotTriggers set [_forEachIndex, nil];
	};
} forEach TriggerSaveSystem_SlotTriggers;