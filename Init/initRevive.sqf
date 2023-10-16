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
                    if (_x == player) then 
                    {
                        hint "There is no ally to revive you. Use zeus to spawn teammate to revive you";
                    };
                };
            };
        } forEach (units group player);
        sleep Revive_CheckInterval;
    };
};