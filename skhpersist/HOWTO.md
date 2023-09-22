# How to...

## ...add container to save?

`Put in the container's init field:

`this spawn { _this call skhpersist_fnc_AddCustomContainerToSave }`

or you can use this inside a script (make sure it's called after save system initialization):

`container call skhpersist_fnc_AddCustomContainerToSave `

## ...add unit and its group to save?

Put in the unit's init field:

`this spawn { _this call skhpersist_fnc_AddCustomUnitToSave }`

or you can use this inside a script (make sure it's called after save system initialization):

`unit call skhpersist_fnc_AddCustomUnitToSave `

This will save all units in group.

## ...add variable to save?

`[variable, namespace] call skhpersist_fnc_AddCustomVariableToSave`

`namespace` can be:
- "local" - will save variable from localNamespace
- "mission" - will save variable from missionNamespace
- "parsing" - will save variable from parsingNamespace
- "profile" - will save variable from profileNamespace
- "ui" - will save variable from uiNamespace

## ...add vehicle to save?

Either add it manually via action or use the code:

`this spawn { _this call skhpersist_fnc_AddCustomVehicleToSave }`

or you can use this inside a script (make sure it's called after save system initialization):

`vehicle call skhpersist_fnc_AddCustomVehicleToSave `

