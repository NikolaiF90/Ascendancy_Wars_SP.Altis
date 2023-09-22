/*
Creates a radio trigger with given _text on _radio channel (e.g. ALPHA),
which will execute given _function.
*/
params ["_text", "_radio", "_function"];

[format ["Creating radio trigger %1.", _radio]] call skhpersist_fnc_LogToRPT;

private _trigger = createTrigger ["EmptyDetector", [0, 0, 0]];
_trigger setTriggerText _text;
_trigger setTriggerActivation [_radio, "PRESENT", true];
_trigger setTriggerStatements ["this", _function, ""];

[format ["Creating radio trigger %1 done, returning %2.", _radio, _trigger]] call skhpersist_fnc_LogToRPT;
_trigger;