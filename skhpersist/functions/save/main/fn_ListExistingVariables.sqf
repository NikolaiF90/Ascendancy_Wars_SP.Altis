/*
Lists all variables stored by this mission in profileNamespace
on given save _slot.

Returns array with persisted data.
*/

// _slot is optional - if not specified, all data persisted by
// this system will be returned (i.e. only with prefix = PSave_SaveGamePrefix).
params ["_slot"];

// Function to find desired variables in allVariables
F90_fnc_extractWithKey = 
{
    private["_array", "_searchKey", "_extracted"];
    _array = _this # 0;
    _searchKey = _this # 1;
    _extracted = [];
    
    {
        if (_x find _searchKey > -1) then {
            _extracted pushBack _x;
        }
    } forEach _array;
    
    _extracted
};

private _variables = allVariables profileNamespace;
private _searchKey = "F90_AWS";

private _extractedVars = [_variables, _searchKey] call F90_fnc_extractWithKey;

private _result = [];

if (isNil { _slot }) then
{
    ["Listing variables for all saves."] call skhpersist_fnc_LogToRPT;
}
else
{
    [format ["Listing variables for save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;
};

{
    private _splittedVariable = _x splitString ".";
    if (_splittedVariable # 0 == F90_AWSP) then
    {
        if (isNil { _slot }) then
        {
            _result pushBack _x;
        }
        else
        {
            if (count _splittedVariable >= 2 && (parseNumber (_splittedVariable # 1)) == _slot) then
            {
                _result pushBack _x;
            };
        }
    };
} forEach _extractedVars;

_result;