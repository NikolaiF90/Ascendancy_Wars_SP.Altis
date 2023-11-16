
private _date = date;
private _year = _date # 0;
private _month = _date # 1;
private _day = _date # 2;
private _hour = _date # 3; 
private _minute = _date # 4;
private _dayNightText = "";
private _hourText = "";
private _minuteText = "";

if (_hour >= 0 && _hour < 12) then
{
	_dayNightText = "a.m";
};

if (_hour >= 12 && _hour <= 23) then 
{
	_dayNightText = "p.m";
};

if (_hour >= 0 && _hour <= 9) then
{
	_hourText = format ["0%1", _hour];
};

if (_hour >= 10 && _hour <= 23) then
{
	_hourText = str _hour;
};

if (_minute >= 0 && _minute <= 9) then
{
	_minuteText = format ["0%1", _minute];
};

if (_minute >= 10 && _minute <= 59) then
{
	_minuteText = str _minute;
};

private _yearMonthString = format ["%1/%2/%3", _day, _month, _year];
private _timeString = format ["%1 : %2 %3", _hourText, _minuteText, _dayNightText];
private _loadingText = format ["%1 \n %2", _yearMonthString, _timeString];

titleText [_loadingText, "BLACK IN", 10];
