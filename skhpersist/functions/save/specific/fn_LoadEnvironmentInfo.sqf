/*
Restores environment info, such as date, time, weather etc.
Data is loaded from given save _slot.
*/

params ["_slot"];

[format ["Loading environment info from save slot %1.", _slot]] call skhpersist_fnc_LogToRPT;

private _environment = ["environment", _slot] call skhpersist_fnc_LoadData;

private _date = [_environment, "date"] call skhpersist_fnc_GetByKey;
private _rain = [_environment, "rain"] call skhpersist_fnc_GetByKey;
private _fog = [_environment, "fog"] call skhpersist_fnc_GetByKey;
private _overcast = [_environment, "overcast"] call skhpersist_fnc_GetByKey;

setDate _date;
0 setRain _rain;
0 setFog _fog;
0 setOvercast _overcast;
forceWeatherChange;