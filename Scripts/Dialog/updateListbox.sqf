params ["_listbox", "_items"];

lbClear _listbox; 

// Fill items in the "_items" array into the LB
{
	lbAdd [_listbox, _x];
} forEach _items;
