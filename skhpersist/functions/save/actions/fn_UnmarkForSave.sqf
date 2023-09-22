/*
Removes given _object from _array of objects, which should be saved.
*/
params ["_object", "_array"];

[format ["Unmarking object %1.", _object]] call skhpersist_fnc_LogToRPT;
_array deleteAt (_array find _object);

hint format ["%1 will NOT be saved!", typeOf _object];