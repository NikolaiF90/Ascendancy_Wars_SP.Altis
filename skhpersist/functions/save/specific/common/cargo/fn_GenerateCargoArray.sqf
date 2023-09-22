/*
Creates a cargo array for given _container.

Returns a generated cargo array.
*/

params ["_container"];

private _GetContainersArray =
{
    params ["_container"];

    private _containersArray = [];

    {
        private _class = _x # 0;
        private _instance = _x # 1;
        private _cargo = [_instance] call skhpersist_fnc_GenerateCargoArray;

        private _currentContainerArray = [];

        _currentContainerArray pushBack ["class", _class];
        _currentContainerArray pushBack ["cargo", _cargo];

        _containersArray pushBack _currentContainerArray;
    } forEach (everyContainer _container);
    
    _containersArray;
};

private _GetBackpacksArray =
{
    params ["_container"];

    private _backpacksArray = [];

    {
        private _class = typeOf _x;
        private _cargo = [_x] call skhpersist_fnc_GenerateCargoArray;

        private _currentBackpackArray = [];

        _currentBackpackArray pushBack ["class", _class];
        _currentBackpackArray pushBack ["cargo", _cargo];

        _backpacksArray pushBack _currentBackpackArray;
    } forEach (everyBackpack _container);
    
    _backpacksArray;
};

[format ["Generating cargo array for container %1.", _container]] call skhpersist_fnc_LogToRPT;

private _itemsArray = ["items", getItemCargo _container];
private _magazinesArray = ["magazines", magazinesAmmoCargo _container];
private _weaponsArray = ["weapons", weaponsItemsCargo _container];
private _containersArray = ["containers", [_container] call _GetContainersArray];
private _backpacksArray = ["backpacks", [_container] call _GetBackpacksArray];

private _cargo =
[
    _itemsArray,
    _magazinesArray,
    _weaponsArray,
    _containersArray,
    _backpacksArray
];

_cargo;