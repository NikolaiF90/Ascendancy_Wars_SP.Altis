["Initializing persistent save system."] call skhpersist_fnc_LogToRPT;

// ------------------------------------------------------------------------------------
// PREFIX FOR SAVE-RELATED VARIABLES
// ------------------------------------------------------------------------------------
PSave_SaveGamePrefix = "PSave_TestMission";

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
[] call skhpersist_fnc_InitTriggerSaveSystem;

// ------------------------------------------------------------------------------------
// ADDITIONAL SCRIPTS
// ------------------------------------------------------------------------------------
// Looks for cars near the player in a loop.
// Each car will get an action, which will allow to mark it for save.
[1000, "Car", "PSave_CustomVehiclesToSave", { PSave_CustomVehiclesToSave }] spawn skhpersist_fnc_FindObjectsToAddActions;

// ------------------------------------------------------------------------------------
// DON'T CHANGE THESE VARIABLES VALUES MANUALLY IN THIS FILE!
// ------------------------------------------------------------------------------------
PSave_LoadInProgress = false;
PSave_SaveInProgress = false;
PSave_NextVehicleId = 1; // used only when storing vehicles, which have saved units inside