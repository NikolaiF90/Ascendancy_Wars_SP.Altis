/*
	Function to create zone icon at position of provided marker
*/

params ["_marker", "_zoneType", "_side"];

private _iconName = format ["%1_icon", _marker];
private _iconPos = markerPos _marker;
private _zoneIcon = createMarker [_iconName, _iconPos];

switch (_zoneType) do 
{
	case "Outpost":
	{
		_zoneIcon setMarkerType "loc_Ruin";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "Resource":
	{
		_zoneIcon setMarkerType "loc_Rock";
		_zoneIcon setMarkerSize [1.5,1.5];
	};
	case "Factory":
	{
		_zoneIcon setMarkerType "loc_Power";
		_zoneIcon setMarkerSize [1,1];
	};
	case "Airport":
	{
		_zoneIcon setMarkerType "b_plane";
		_zoneIcon setMarkerSize [1,1];
	};
};

switch (_side) do {
	case west: 
	{
		_zoneIcon setMarkerColor "colorBLUFOR";
		_zoneIcon setMarkerText format["NATO %1", _zoneType];
	};
	case east:
	{
		_zoneIcon setMarkerColor "colorOPFOR";
		_zoneIcon setMarkerText format["CSAT %1", _zoneType];
		_garrisonSkill = AWSP_OPFORSkill;
	};
	case independent:
	{
		_zoneIcon setMarkerColor "colorGUER";
		_zoneIcon setMarkerText format["LDF %1", _zoneType];
		_garrisonSkill = AWSP_GUERSkill;
	};
	case civilian: 
	{
		_zoneIcon setMarkerColor "colorCIV";
		_zoneIcon setMarkerText format["Civilian %1", _zoneType];
	};
};

_zoneIcon;