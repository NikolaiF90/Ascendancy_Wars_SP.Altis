/*
Function to generate zone garrison preference based on provided zone type

PARAMETERS:
	0	side	the side of the garrison owner
	1	STRING 	Type of the zone to garrison: (will influence garrisoned soldier)

RETURN:
	Array of garrisonData [a,b,c,d] 
	a = zone type
	b = side of the garrisons 
	c = group count
	d = group size
*/

params ["_side", "_type"];

private _garrisonData = [];
private _groupCount = 0;
private _groupSize = [];


switch (_type) do 
{
	case "Outpost":
	{
		_groupCount = 3;
		_groupSize = [4,5];
	};
	case "Resource":
	{
		_groupCount = 2;
		_groupSize = [2,4];
	};
	case "Factory":
	{
		_groupCount = 2;
		_groupSize = [4,7];
	};
	case "Airport":
	{
		_groupCount = 4;
		_groupSize = [5,7];
	};
};

_garrisonData pushback _type;
_garrisonData pushback _side;
_garrisonData pushback _groupCount;
_garrisonData pushback _groupSize;

_garrisonData;