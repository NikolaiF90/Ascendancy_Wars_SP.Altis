/*
	Creates a group array for given _leader.
	It will contain all units under _leader's command (except for him).

	Returns a generated group array.
*/

params ["_leader"];

private _groupArray = units group _leader;
private _unitsData = [];

["generateGroupData",format ["Generating group data for leader %1.", _leader]] call F90_fnc_debug;

{
    if (_x != _leader && alive _x) then
    {
        _unitsData pushBack ([_x, false] call F90_fnc_generateUnitData);
    };
} forEach _groupArray;

_unitsData;