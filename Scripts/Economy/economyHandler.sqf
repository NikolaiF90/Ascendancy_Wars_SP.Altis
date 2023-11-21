/*
	Author: PrinceF90 
 
	Description: 
		This function is an economy handler that performs various operations related to money. It can get the current amount of money for a unit, set the amount of money for a unit, add money to the unit's current amount, or deduct money from the unit's current amount. 
	
	Parameter(s): 
		0: STRING - _operation: The operation to be performed. Possible values are "GETMONEY", "SETMONEY", "ADDMONEY", or "DEDUCTMONEY". 
		1: ANY - _args: The arguments for the specified operation. Can be OBJECT or ARRAY depending on the operation.
	
	Returns: 
		The return value depends on the operation performed. It can be the current amount of money for a unit or None if no return value is applicable. 
	
	Examples: 
		// Get the current amount of money for a unit 
		["GETMONEY", [player]] call economyHandler; 
	
		// Set the amount of money for a unit 
		["SETMONEY", [player, 5000]] call economyHandler; 
	
		// Add money to the unit's current amount 
		["ADDMONEY", [player, 1000]] call economyHandler; 
	
		// Deduct money from the unit's current amount 
		["DEDUCTMONEY", [player, 2000]] call economyHandler;
*/

params ["_operation", "_args"];

private _returnValue = nil;

if (isNil {_operation}) then 
{
	_operation == "DEFAULT";
}else 
{
	if (_operation == "") then 
	{
		_operation == "DEFAULT";
	};
};

if (_operation == "GETMONEY") then 
{
	if (isNil {_args}) exitWith {[ECONOMY_Debug, "economyHandler", "(ERROR) Handler 'GETMONEY' prevented from running because _args is not provided", true] call F90_fnc_debug};

	private _unit = _args;
	private _money = _unit getVariable ["Milcash", ECONOMY_DefaultCIVMoney];
	_returnValue = _money;
};

if (_operation == "SETMONEY") then 
{
	if (isNil {_args}) exitWith {[ECONOMY_Debug, "economyHandler", "(ERROR) Handler 'SETMONEY' prevented from running because _args is not provided", true] call F90_fnc_debug};

	private _unit = _args # 0;
	private _amount = _args # 1;
	_unit setVariable ["Milcash", _amount];
};

if (_operation == "ADDMONEY") then 
{
	if (isNil {_args}) exitWith {[ECONOMY_Debug, "economyHandler", "(ERROR) Handler 'ADDMONEY' prevented from running because _args is not provided", true] call F90_fnc_debug};

	private _unit = _args # 0;
	private _amount = _args # 1;
	private _money = _unit getVariable ["Milcash", ECONOMY_DefaultCIVMoney];
	
	_money = _money + _amount;
	_unit setVariable ["Milcash", _money];
	_returnValue = _money;
};

if (_operation == "DEDUCTMONEY") then 
{
	if (isNil {_args}) exitWith {[ECONOMY_Debug, "economyHandler", "(ERROR) Handler 'DEDUCTMONEY' prevented from running because _args is not provided", true] call F90_fnc_debug};

	private _unit = _args # 0;
	private _amount = _args # 1;
	private _money = _unit getVariable ["Milcash", ECONOMY_DefaultCIVMoney];
	
	_money = _money - _amount;
	_unit setVariable ["Milcash", _money];
	_returnValue = _money;
};

_returnValue;