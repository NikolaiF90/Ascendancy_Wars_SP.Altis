[Persistent_Debug, "createSaveSlot", "Creating save slots", false] call F90_fnc_debug;

private _slotCount = 8;
private _defaultSlotPrefix = "Empty slot ";

for "_i" from 0 to _slotCount do 
{
	_saveName = _defaultSlotPrefix + str _i;
	AWSP_SaveSlots pushBack _saveName;
};

[Persistent_Debug, "createSaveSlot", "Done creating save slots", false] call F90_fnc_debug;
