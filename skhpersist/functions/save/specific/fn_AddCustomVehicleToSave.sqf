/*
Makes specified _vehicle saveable.
*/

params ["_vehicle"];

private _vehicleId = objNull;

[format ["Trying to add vehicle %1 to save.", _vehicle]] call skhpersist_fnc_LogToRPT;

private _vehicleIndex = PSave_CustomVehiclesToSave find _vehicle;

if (_vehicleIndex == -1) then 
{
    _vehicleId = PSave_NextVehicleId;

    _vehicle setVariable ["PSave_ID", _vehicleId];

	[format ["Adding vehicle %1 to save (id: %2).", _vehicle, _vehicleId]] call skhpersist_fnc_LogToRPT;
	PSave_CustomVehiclesToSave pushBack _vehicle;

    PSave_NextVehicleId = PSave_NextVehicleId + 1;
}
else
{
	[format ["Vehicle %1 is already added for saving.", _vehicle]] call skhpersist_fnc_LogToRPT;

	_vehicleId = (PSave_CustomVehiclesToSave # _vehicleIndex) getVariable "PSave_ID";
};

_vehicleId;