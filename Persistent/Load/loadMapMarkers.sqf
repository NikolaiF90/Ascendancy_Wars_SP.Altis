/*
Restores map markers.
Data is loaded from given save _slot.
*/

params ["_slot"];

["loadMapMarkers", "Loading map markers"] call F90_fnc_debug;

private _allMarkers = allMapMarkers;

{
    deleteMarker _x;
} forEach _allMarkers;

private _markers = ["markers", _slot] call F90_fnc_LoadData;

{
    private _name = [_x, "name"] call F90_fnc_GetByKey;

    private _alpha = [_x, "alpha"] call F90_fnc_GetByKey;
    private _brush = [_x, "brush"] call F90_fnc_GetByKey;
    private _color = [_x, "color"] call F90_fnc_GetByKey;
    private _dir = [_x, "dir"] call F90_fnc_GetByKey;
    private _position = [_x, "position"] call F90_fnc_GetByKey;
    private _shape = [_x, "shape"] call F90_fnc_GetByKey;
    private _size = [_x, "size"] call F90_fnc_GetByKey;
    private _text = [_x, "text"] call F90_fnc_GetByKey;
    private _type = [_x, "type"] call F90_fnc_GetByKey;
    
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

["loadMapMarkers", "Map markers loaded"] call F90_fnc_debug;