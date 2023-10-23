/*
	Stores map markers.
	Data is saved to given save _slot.
*/

params ["_slot"];

["saveMapMarkers",format ["Saving map markers to save slot %1.", _slot]] call F90_fnc_debug;

private _markersArray = [];
private _userMarkersCounter = 1;
private _allMarkers = allMapMarkers;

{
    private _marker = [];
    
    private _name = _x;

    if ((_name splitString ' ') # 0 == "_USER_DEFINED") then
    {
        _name = format ["_USER_DEFINED %1_STORED", _userMarkersCounter];
        _userMarkersCounter = _userMarkersCounter + 1;
    };

    _marker pushBack ["name", _name];
    
    _marker pushBack ["alpha", markerAlpha _x];
    _marker pushBack ["brush", markerBrush _x];
    _marker pushBack ["color", markerColor _x];
    _marker pushBack ["dir", markerDir _x];
    _marker pushBack ["position", markerPos _x];
    _marker pushBack ["shape", markerShape _x];
    _marker pushBack ["size", markerSize _x];
    _marker pushBack ["text", markerText _x];
    _marker pushBack ["type", markerType _x];
    
    _markersArray pushBack _marker;
} forEach _allMarkers;

["markers", _markersArray, _slot] call F90_fnc_saveData;