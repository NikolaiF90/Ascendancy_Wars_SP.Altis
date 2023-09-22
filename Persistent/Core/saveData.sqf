/*
	Stores a single _key -> _value pair in profileNamespace on given save _slot.
	!! WARNING !! It doesn't persist them automatically!
*/

params ["_key", "_value", "_slot"];

["saveData", format["['%1',%2] saved into slot %3",_key, _value, _slot]] call F90_fnc_debug;

profileNamespace setVariable [format ["%1.%2.%3", PSave_SaveGamePrefix, _slot, _key], _value];