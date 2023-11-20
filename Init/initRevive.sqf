/*
    Author: PrinceF90 
 
    Description: 
    This script handles the revive functionality in the game. It allows players to revive incapacitated allies or be revived by an ally. If no ally is available for revival, the player is given an option to commit suicide. 
    
    Parameter(s): 
    0: None 
    
    Returns: 
    None 
    
    Examples: 
    
    // Adding revive functionality to the player 
    player call F90_fnc_addRevive;
*/
configureReviveDone = false;
[] call F90_fnc_configureRevive;
waitUntil {configureReviveDone};

player call F90_fnc_addRevive;

waitUntil {time > 0};

[] spawn 
{
    while {true} do 
    {
        {
            if ((lifeState _x == "INCAPACITATED")) then 
            {
                private ["_medic"];
                private _medicCandidates = units group player;

                {
                    if (!(incapacitatedState _x == "UNCONSCIOUS")&&(!captive _x)&&(_x != player)) exitWith {_medic = _x;};
                } forEach _medicCandidates;

                if (!isnil "_medic") then 
                {
                    [_medic, _x] call F90_fnc_unitReviveBody;
                }else
                {
                    if (_x == commanderX) then 
                    {
                        hint "There is no ally to revive you. Use zeus to spawn teammate to revive you";
                    };
                };
            };

            if (_x == commanderX) then 
            {
                if ((lifeState _x == "INCAPACITATED")) then 
                {
                    if (isNil {_suicideAction}) then 
                    {
                        _suicideAction = commanderX addAction ["Suicide", 
                        {
                            params ["_target", "_caller", "_actionId", "_arguments"];
                            _target setDamage 1;
                            _target removeAction _actionId;
                        },nil, 6, false, true, "", "true", -1, true];
                    };
                } else 
                {
                    if !(isNil {_suicideAction}) then
                    {
                        _x removeAction _suicideAction;
                        _suicideAction = nil;
                    };
                };   
            };
        } forEach (units group player);
        sleep Revive_CheckInterval;
    };
};