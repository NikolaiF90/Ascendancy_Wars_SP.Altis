if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};

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
                    if ((!captive _x)&&(_x != player)) exitWith {_medic = _x;};
                } forEach _medicCandidates;

                if (!isnil "_medic") then 
                {
                    [_medic, _x] call F90_fnc_unitReviveBody;
                }else
                {
                    if (_x == player) then 
                    {
                        hint "There is no ally to revive you. Respawn is recommended";
                    };
                };
            };
        } forEach (units group player);
        sleep AWSP_GroupAliveCheck;
    };
};