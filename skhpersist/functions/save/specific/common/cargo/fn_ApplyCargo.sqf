/*
Adds cargo from _cargoArray to given _container.
*/

params ["_container", "_cargoArray"];

[format ["Applying cargo array to container %1.", _container]] call skhpersist_fnc_LogToRPT;

clearItemCargo _container;
clearMagazineCargo _container;
clearWeaponCargo _container;
clearBackpackCargo _container;

private _IsContainerEmpty =
{
    params ["_container"];

    if (!(magazineCargo _container isEqualTo [])) exitWith { false };
    if (!(weaponCargo _container isEqualTo [])) exitWith { false };
    if (!(itemCargo _container isEqualTo [])) exitWith { false };
    if (!(backpackCargo _container isEqualTo [])) exitWith { false };

    true;
};

private _AddAllToCargo =
{
    params ["_container", "_cargoArray", "_AddToCargo"];
    
    {
        private _name = _x;
        private _count = (_cargoArray # 1) # _forEachIndex;
        [_container, _name, _count] call _AddToCargo;
    } forEach (_cargoArray # 0);
};

private _AddAllMagazinesToCargo =
{
    params ["_container", "_cargoArray"];

    {
        private _name = _x # 0;
        private _ammo = _x # 1;

        _container addMagazineAmmoCargo [_name, 1, _ammo];
    } forEach _cargoArray;
};

private _AddAllWeaponsToCargo =
{
    params ["_container", "_cargoArray"];

    {
        _container addWeaponWithAttachmentsCargo [_x, 1];
    } forEach _cargoArray;
};

private _AddAllContainersToCargo =
{
    params ["_container", "_cargoArray"];

    {
        private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
        private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;

        // There's no need to add a container (such as uniform or vest) - it was already done
        // when adding items.
        
        {
            private _currentClass = _x # 0;
            private _currentInstance = _x # 1;

            if (_currentClass == _class && [_currentInstance] call _IsContainerEmpty) exitWith
            {
                [_currentInstance, _cargo] call skhpersist_fnc_ApplyCargo;
            };
        } forEach (everyContainer _container);

    } forEach _cargoArray;
};

private _AddAllBackpacksToCargo =
{
params ["_container", "_cargoArray"];

    {
        private _class = [_x, "class"] call skhpersist_fnc_GetByKey;
        private _cargo = [_x, "cargo"] call skhpersist_fnc_GetByKey;

        _container addBackpackCargo [_class, 1];

        {
            if (typeOf _x == _class && [_x] call _IsContainerEmpty) exitWith
            {
                [_x, _cargo] call skhpersist_fnc_ApplyCargo;
            };
        } forEach (everyBackpack _container);

    } forEach _cargoArray;
};

private _itemsArray = [_cargoArray, "items"] call skhpersist_fnc_GetByKey;
private _magazinesArray = [_cargoArray, "magazines"] call skhpersist_fnc_GetByKey;
private _weaponsArray = [_cargoArray, "weapons"] call skhpersist_fnc_GetByKey;
private _containersArray = [_cargoArray, "containers"] call skhpersist_fnc_GetByKey;
private _backpacksArray = [_cargoArray, "backpacks"] call skhpersist_fnc_GetByKey;

[_container, _itemsArray, { params ["_c", "_n", "_cnt"]; _c addItemCargo [_n, _cnt]; }] call _AddAllToCargo;
[_container, _magazinesArray] call _AddAllMagazinesToCargo;
[_container, _weaponsArray] call _AddAllWeaponsToCargo;
[_container, _containersArray] call _AddAllContainersToCargo;
[_container, _backpacksArray] call _AddAllBackpacksToCargo;
