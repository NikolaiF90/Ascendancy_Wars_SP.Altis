/*
Stores a single _key -> _value pair in profileNamespace on given save _slot.
It doesn't persist them automatically!
*/

params ["_key", "_value", "_slot"];

[format ["Saving data for key %1 on save slot %2.", _key, _slot, _value]] call skhpersist_fnc_LogToRPT;

profileNamespace setVariable [format ["%1.%2.%3", PSave_SaveGamePrefix, _slot, _key], _value];