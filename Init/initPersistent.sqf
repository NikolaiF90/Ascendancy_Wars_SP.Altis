
configurePersistentDone = false;
[] call F90_fnc_configurePersistent;
waitUntil {configurePersistentDone};
[Persistent_Debug, "initPersistent", "Initiliazing AWSP Persistent Save System", false] call F90_fnc_debug;


//	DO NOT EDIT
//	AWSP PERSISTENT SAVE SYSTEM VARIABLES
//	-----------------------------------------------------------------------------------
Persistent_VehiclesToSave = [];	// Array of persistent vehicles





// ------------------------------------------------------------------------------------
// PREFIX FOR SAVE-RELATED VARIABLES
// ------------------------------------------------------------------------------------
PSave_SaveGamePrefix = "F90_AWSP";

// ------------------------------------------------------------------------------------
// ARRAYS WITH CUSTOM OBJECTS TO BE SAVED
// ------------------------------------------------------------------------------------
PSave_CustomContainersToSave = [];
PSave_CustomUnitsToSave = [];
PSave_CustomVariablesToSave = [];
PSave_CustomVehiclesToSave = [];

// ------------------------------------------------------------------------------------
// EVENT HANDLERS (provide paths to .sqf files or the code directly)
// ------------------------------------------------------------------------------------

// Functions to call before load.
// Params: _slot (save slot)
PSave_BeforeLoadEH = [];

// Functions to call before save.
// Params: _slot (save slot)
PSave_BeforeSaveEH = [];

// Functions to call after load.
// Params: _slot (save slot)
PSave_AfterLoadEH = [];

// Functions to call after save.
// Params: _slot (save slot)
PSave_AfterSaveEH = [];
// ------------------------------------------------------------------------------------
// SAVE SYSTEMS
// ------------------------------------------------------------------------------------

// You can create and use your own save system if you want, instead of the default one.
[] call F90_fnc_initDialogSaveSystem;


// ------------------------------------------------------------------------------------
// DON'T CHANGE THESE VARIABLES VALUES MANUALLY IN THIS FILE!
// ------------------------------------------------------------------------------------
PSave_LoadInProgress = false;
PSave_SaveInProgress = false;
PSave_NextVehicleId = 1; // used only when storing vehicles, which have saved units inside

[Persistent_Debug, "initPersistent", "Done intializing persistent save system", false] call F90_fnc_debug;