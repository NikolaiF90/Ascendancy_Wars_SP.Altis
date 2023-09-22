/*
Restores map markers.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading map markers from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

{
    deleteMarker _x;
} forEach allMapMarkers;

private _markers = ["markers", _slot] call skhpersist_fnc_LoadData;

{
    private _name = [_x, "name"] call skhpersist_fnc_GetByKey;

    private _alpha = [_x, "alpha"] call skhpersist_fnc_GetByKey;
    private _brush = [_x, "brush"] call skhpersist_fnc_GetByKey;
    private _color = [_x, "color"] call skhpersist_fnc_GetByKey;
    private _dir = [_x, "dir"] call skhpersist_fnc_GetByKey;
    private _position = [_x, "position"] call skhpersist_fnc_GetByKey;
    private _shape = [_x, "shape"] call skhpersist_fnc_GetByKey;
    private _size = [_x, "size"] call skhpersist_fnc_GetByKey;
    private _text = [_x, "text"] call skhpersist_fnc_GetByKey;
    private _type = [_x, "type"] call skhpersist_fnc_GetByKey;
    
    private _marker = createMarker [_name, _position];
    
    _marker setMarkerAlpha _alpha;
    _marker setMarkerBrush _brush;
    _marker setMarkerColor _color;
    _marker setMarkerDir _dir;
    _marker setMarkerShape _shape;
    _marker setMarkerSize _size;
    _marker setMarkerText _text;
    _marker setMarkerType _type;
} forEach _markers;