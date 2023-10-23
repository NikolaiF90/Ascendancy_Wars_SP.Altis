/*
	Function Name: generateZoneData 
 
	Description: 
	This function generates zone data based on the owner's side. It takes the side of the zone owner as a parameter and returns an array containing various zone data elements. 
	
	Syntax: 
	[parameters] call generateZoneData 
	
	Parameters: 
	- _side (string): The side of the zone owner (east, west, or independent). 
	
	Return: 
	An array containing the following zone data elements: 
	- _zoneOwner (string): The owner of the zone. 
	- _colorOwner (string): The color associated with the zone owner. 
	- _zoneTextOwner (string): The formatted text representing the zone owner. 
	- _seizeCondition (string): The seize condition of the zone. 
	- _attacker (string): The attacker side. 
	- _sideAttacker (string): The side of the attacker. 
	- _colorAttacker (string): The color associated with the attacker side. 
	- _zoneTextAttacker (string): The formatted text representing the attacker side. 
*/
params ["_side"];

private ["_returnData", "_zoneOwner", "_colorOwner", "_zoneTextOwner", "_seizeCondition", "_attacker", "_sideAttacker", "_colorAttacker", "_zoneTextAttacker"];
switch (_side) do 
{
	case east: 
	{
		_zoneOwner = "EAST";
		_colorOwner = "colorOPFOR";
		_zoneTextOwner = format["CSAT %1", _zoneType];
		_seizeCondition = "GUER SEIZED";
		_attacker = "GUER";
		_sideAttacker = independent;
		_colorAttacker = "colorGUER";
		_zoneTextAttacker = format["LDF %1", _zoneType];
	};
	case west:
	{
		_zoneOwner = "WEST";
		_colorOwner = "colorBLUFOR";
		_zoneTextOwner = format["NATO %1", _zoneType];
	};
	case independent:
	{
		_zoneOwner = "GUER";
		_colorOwner = "colorGUER";
		_zoneTextOwner = format["LDF %1", _zoneType];
		_seizeCondition = "EAST SEIZED";
		_attacker = "EAST";
		_sideAttacker = east;
		_colorAttacker = "colorOPFOR";
		_zoneTextAttacker = format["CSAT %1", _zoneType];
	};
};

_returnData = [_zoneOwner,_colorOwner,_zoneTextOwner,_seizeCondition,_attacker,_sideAttacker,_colorAttacker,_zoneTextAttacker];
_returnData;