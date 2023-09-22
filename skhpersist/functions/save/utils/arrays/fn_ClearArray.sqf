/*
Removes all elements from given _array, leaving the reference untouched.
*/

params ["_array"];

private _size = count _array;

for [{ _i = _size }, { _i >= 0 }, { _i = _i - 1 }] do
{
	_array deleteAt _i;
};