/*
	Function to find houses near player
*/
private ["_returnData"];
_returnData = nearestObjects [vehicle player, Ambient_HousesList, Ambient_HouseScannerRadius];
_returnData;