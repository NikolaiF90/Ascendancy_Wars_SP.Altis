/*
	Removes all elements from given _array, safer than _array = []
*/
params ["_array"];

private _size = count _array;

for "_i" from (_size -1) to 0 do 
{
	_array deleteAt _i;
};