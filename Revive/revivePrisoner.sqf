/*
	Code Explanation:

	This code is a function in Arma 3 that handles the revive system and performs various actions on a target unit. Here is a breakdown of the code:

	SYNTAX:
	To call this function, use the syntax: [target, caller, actionId, arguments] call F90_fnc_scriptName;

	PARAMETERS:
	- _target: Object - The target unit on which the actions will be performed.
	- _caller: Object - The unit performing the actions.
	- _actionId: Any - The ID of the action being performed.
	- _arguments: Any - Additional arguments for the function.

	CODE:
	1. The "_caller" unit plays three specific move animations related to being a medic.
	2. The script waits for a duration defined by the "Revive_Duration" variable.
	3. The "_target" unit is commanded to stop and stop watching any specific target.
	4. The AI of the "_target" unit is disabled for both "TARGET" and "AUTOCOMBAT" modes.
	5. The damage of the "_target" unit is set to 0, indicating that it is in a healthy state.
	6. The action with the ID stored in the "_target" unit's "Revive_PrisonerActionID" variable is removed.
	7. The "_target" unit's "Revive_PrisonerActionID" variable is set to null.
	8. The "_surrendered" variable is assigned the value of the "_target" unit's "Revive_Surrendered" variable, defaulting to false if not previously set.
	9. The "F90_fnc_setUnitReviveState" function is called with parameters "_target" and false to set the revive state of the "_target" unit to false.
	10. The "_target" unit is set as captive.
	11. If the "_surrendered" variable is false, the "F90_fnc_dropInventory" function is called with the "_target" unit as the parameter to drop its inventory.
	12. The "_target" unit's "Revive_Surrendered" variable is set to true.
	13. An action to capture the prisoner is added to the "_target" unit using the addAction command. The action ID is stored in the "_captureActionID" variable.
	14. The "_target" unit immediately plays the "Stand" and "Surrender" actions.

	RETURN:
	None.
*/
params ["_target", "_caller", "_actionId", "_arguments"];

_caller playMove "AinvPknlMstpSnonWnonDnon_medic1";
_caller playMove "AinvPknlMstpSnonWnonDnon_medic2";
_caller playMove "AinvPknlMstpSnonWnonDnon_medicEnd";
sleep Revive_Duration;

doStop _target;
_target doWatch nil;
_target disableAI "TARGET";
_target disableAI "AUTOCOMBAT";
_target disableAI "RADIOPROTOCOL";

_target setDamage 0;
_target removeAction (_target getVariable "Revive_PrisonerActionID");
_target setVariable ["Revive_PrisonerActionID", nil];

private _surrendered = _target getVariable ["Revive_Surrendered", false];
[_target, false] call F90_fnc_setUnitReviveState;
_target setCaptive true;

if !(_surrendered) then 
{
	[_target] call F90_fnc_dropInventory;
};

_target setVariable ["Revive_Surrendered", true];
private _captureActionID = _target addAction ["Capture prisoner", {params ["_target", "_caller", "_actionId", "_arguments"];_target removeAction _actionId;hint "You have captured the prisoner";}];
_target setVariable ["Revive_CaptureActionID", _captureActionID];
_target playActionNow "Stand";
_target playActionNow "Surrender";