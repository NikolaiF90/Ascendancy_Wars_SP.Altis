/*
PARAMETERS:
	0	side	the side of the garrison owner
	1	STRING 	Type of the zone to garrison: (will influence garrisoned soldier)

RETURN:
	Array of garrisonData [a,b,c,d,e,f] 
	a = zone type
	b = side of the garrisons 
	c = infantry counts
	d = car counts
	e = tank counts
	f = static counts
*/

params ["_side", "_type"];

_garrisonData = [];
_infantry = [];
_cars = [];
_armour = [];
_statics = [];

switch (_type) do 
{
	case "Outpost":
	{
		_infantry = [2,7];
		_cars = [1,4];
		_armour = [0,0];
		_statics = [3,1];
	};
	case "Resource":
	{
		_infantry = [1,7];
		_cars = [0,0];
		_armour = [0,0];
		_statics = [0,0];
	};
	case "Factory":
	{
		_infantry = [4,7];
		_cars = [2,4];
		_armour = [0,0];
		_statics = [4,1];
	};
	case "Airport":
	{
		_infantry = [6,7];
		_cars = [3,4];
		_armour = [2,7];
		_statics = [6,1];
	};
};

_garrisonData pushback _type;
_garrisonData pushback _side;
_garrisonData pushback _infantry;
_garrisonData pushback _cars;
_garrisonData pushback _armour;
_garrisonData pushback _statics;

_garrisonData;