params ["_slot"];

["saveCDARSData", format ["Saving CDARS data into slot %1", _slot]] call F90_fnc_debug;

["CDARSOPFORActivity", CDARS_OPFORActivity, _slot] call F90_fnc_saveData;
["CDARSBLUFORActivity", CDARS_BLUFORActivity, _slot] call F90_fnc_saveData;
["CDARSGUERActivity", CDARS_GUERActivity, _slot] call F90_fnc_saveData;
["CDARSPlayerLastKnownLocation", CDARS_PlayerLastKnownLocation, _slot] call F90_fnc_saveData;