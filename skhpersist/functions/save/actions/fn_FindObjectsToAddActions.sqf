/*
Looks for nearby objects of given _objectsType, which player may want to add to the stored data.
Only objects found in given _radius will be processed by this function.
It adds an action, which will allow the player to persist them - in case player performs an action,
object will be stored in specified _array, which is further processed during saving.
*/
params ["_radius", "_objectsType", "_arrayName", "_GetArrayFunction"];

[format ["Looking for objects of type %1 to add mark actions to.", _objectsType]] call skhpersist_fnc_LogToRPT;

while {alive player} do
{
    sleep 1;
    private _objectsArray = player nearObjects [_objectsType, _radius];
    
    if (!PSave_LoadInProgress) then
    {
        {
            if (isNil { _x getVariable "PSave_MarkingActionSet" }) then
            {
                _x addAction ["Mark for save",
                {
                    private _params = _this # 3;
                    private _object = _params # 0;
                    private _GetArrayFunction = _params # 1;
                    [_object, [] call _GetArrayFunction] call skhpersist_fnc_MarkForSave;
                },
                [_x, _GetArrayFunction], 1, false, true, "",
                format ["%1 find _target == -1", _arrayName],
                5];

                _x addAction ["Unmark for save",
                {
                    private _params = _this # 3;
                    private _object = _params # 0;
                    private _GetArrayFunction = _params # 1;
                    [_object, [] call _GetArrayFunction] call skhpersist_fnc_UnmarkForSave;
                },
                [_x, _GetArrayFunction], 1, false, true, "",
                format ["%1 find _target != -1", _arrayName],
                5];

                _x setVariable ["PSave_MarkingActionSet", true];
            };
        } forEach _objectsArray;
    };
};