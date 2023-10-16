["createSaveSlot", "Creating save slots for player..."] call F90_fnc_debug;

private _slotCount = 8;
private _defaultSlotPrefix = "Empty slot ";

for "_i" from 0 to _slotCount do 
{
	_saveName = _defaultSlotPrefix + str _i;
	AWSP_SaveSlots pushBack _saveName;
};

if(F90_Debug)then
{
	diag_log "[F90 createSaveSlot] Done creating save slots for player";
};

