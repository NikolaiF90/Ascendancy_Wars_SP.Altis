params ["_player", "_didJIP"];

if (_player getVariable ["isSneaky",false]) then {
    [_player] execVM "INC_undercover\Scripts\initUCR.sqf";
};