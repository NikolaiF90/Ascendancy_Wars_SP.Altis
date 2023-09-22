/*
Generates radio triggers for loading and saving.
*/

params ["_slot"];

private _CreateLoadTriggers =
{
	["Adding radio triggers."] call skhpersist_fnc_LogToRPT;

	private _AddLeadingZeroToDateNumber =
	{
		params ["_number", "_leadingZeroes"];
		private _numberStr = format ["%1", _number];

		if (_number < 10) then
		{
			if (_leadingZeroes == 1) then
			{
				_numberStr = format ["0%1", _number];
			}
			else // _leadingZeroes == 2
			{
				_numberStr = format ["00%1", _number];
			}
		};

		_numberStr;
	};

	private _variables = [] call skhpersist_fnc_ListExistingVariables;
	_variables sort true;
	private _newestSlotData = [];

	{
		private _splittedVariable = _x splitString ".";

		if ((_splittedVariable # 2) == "metadata") then
		{
			private _slot = parseNumber (_splittedVariable # 1);
			private _metadataArray = ["metadata", _slot] call skhpersist_fnc_LoadData;
			private _systemTime = [_metadataArray, "systemTime"] call skhpersist_fnc_GetByKey;

			if (count _newestSlotData == 0) then
			{
				_newestSlotData = [_slot, _systemTime];
			}
			else
			{
				private _comparisonResult = [_systemTime, _newestSlotData # 1] call skhpersist_fnc_CompareDates;
				if (_comparisonResult == 1) then
				{
					_newestSlotData = [_slot, _systemTime];
				};
			};

			private _systemTimeStr = format ["%1.%2.%3 %4:%5:%6,%7",
										     [_systemTime # 2, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 1, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 0, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 3, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 4, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 5, 1] call _AddLeadingZeroToDateNumber,
										     [_systemTime # 6, 2] call _AddLeadingZeroToDateNumber
											 ];
											
			private _radio = "";

			switch (_slot) do
			{
				case 1: { _radio = "ALPHA" };
				case 2: { _radio = "BRAVO" };
				case 3: { _radio = "CHARLIE" };
				case 4: { _radio = "DELTA" };
				case 5: { _radio = "ECHO" };
				case 6: { _radio = "FOXTROT" };
				case 7: { _radio = "GOLF" };
				case 8: { _radio = "HOTEL" };
				case 9: { _radio = "INDIA" };
			};

			private _triggerText = format ["Load (%1)", _systemTimeStr];
			private _triggerScript = format ["[%1] call skhpersist_fnc_LoadGame", _slot];
			private _trigger = [_triggerText, _radio, _triggerScript] call skhpersist_fnc_CreateRadioTrigger;
			TriggerSaveSystem_SlotTriggers set [_slot - 1, _trigger];
		}
	} forEach _variables;

	if (count _newestSlotData == 0) then
	{
		TriggerSaveSystem_NextSaveSlot = 1;
	}
	else
	{
		TriggerSaveSystem_NextSaveSlot = (_newestSlotData # 0) + 1;

		if (TriggerSaveSystem_NextSaveSlot > TriggerSaveSystem_SaveSlots) then
		{
			TriggerSaveSystem_NextSaveSlot = 1;
		};
	};
};

[] call skhpersist_fnc_ClearLoadTriggers;
[] call _CreateLoadTriggers;
