/*
	Function Description: 
	Function that take a defense from selected garrison and assign them as reinforcement.
	It determines the number of reinforcements to send based on the count of the selected defense groups.
	It then updates the necessary variables and triggers to reflect the changes. 
	
	Syntax: 
	[_selectedGarrison, _selectedTrigger] call F90_fnc_assignAsReinforcement; 
	
	Parameters: 
	- _selectedGarrison: The selected garrison to get reinforcements from. 
	- _selectedTrigger: The trigger associated with the selected garrison. 
	
	Return: 
	The function returns an array of the assigned reinforcement group(s).
*/
params ["_selectedGarrison", "_selectedTrigger"];

private _selectedIndex = _selectedGarrison # 0;
private _selectedDefense = _selectedTrigger getVariable "Zone_CachedGroup";
private _selectedDefenseCount = _selectedTrigger getVariable "Zone_GroupCount";
_reinforcementGarrison = _selectedGarrison;
// Determine how many reinforcement to sent
private _reinforcementCount = floor(_selectedDefenseCount / 2);
private _remainingDefense = _selectedDefenseCount - _reinforcementCount;
private _reinforcementGroup = [];
["assignAsReinforcement", format["_reinforcementCount = %1", _reinforcementCount]] call F90_fnc_debug;

_selectedTrigger setVariable ["Zone_GroupCount", _remainingDefense];

for "_i" from 0 to _reinforcementCount -1 do 
{
	private _selectedGroup = _selectedDefense # _i;
	_selectedDefense set [_i, 0];
	_reinforcementGroup set [_i, _selectedGroup];
};
["assignAsReinforcement", format["_reinforcementGroup = %1", _reinforcementGroup]] call F90_fnc_debug;
_selectedDefense = _selectedDefense - [0];
_selectedTrigger setVariable ["Zone_CachedGroup", _selectedDefense];
["assignAsReinforcement", format["_defenseGroup %1", _selectedDefense]] call F90_fnc_debug;

AWSP_ZoneTrigger set [_selectedIndex, _selectedTrigger];

_reinforcementGroup;