/*
Compares two dates in form of arrays [year, month, day, hour, minute, second, millisecond].

Returns 1, if _date1 > _date2.
Returns 0, if _date1 == _date2.
Returns -1, if _date1 < _date2.
*/

params ["_date1", "_date2"];

private _CompareDateNumbers =
{
	params ["_n1", "_n2"];

	private _result = 0;

	if (_n1 != _n2) then
	{
		if (_n1 < _n2) then
		{
			_result = -1;
		}
		else
		{
			if (_n1 > _n2) then
			{
				_result = 1;
			};
		};
	};
	
	_result;
};

private _result = 0;

{
	private _n1 = _x;
	private _n2 = _date2 # _forEachIndex;
	private _partialResult = [_n1, _n2] call _CompareDateNumbers;

	if (_partialResult != 0) exitWith
	{
		_result = _partialResult;
	};
} forEach _date1;

_result;