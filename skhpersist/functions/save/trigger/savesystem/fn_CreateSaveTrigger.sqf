/*
Creates a trigger to be used for persistent save.
*/

["Creating save radio trigger."] call skhpersist_fnc_LogToRPT;

["Persistent Save", "JULIET", "[] call skhpersist_fnc_SaveGameOnNextSlot"] call skhpersist_fnc_CreateRadioTrigger;