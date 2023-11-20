/*
	Author: PrinceF90 
 
	Description: 
	Function to load previously saved game from a dead menu. It retrieves the selected list item from a list box, checks if a valid selection is made, and then calls a function to load the game data corresponding to the selected list item. 
	
	Parameter(s): 
		None 
	
	Returns: 
		None 
	
	Examples: 
		[] call F90_fnc_deadMenuLoad;
*/

DeadMenuList_SelectedList = [DeadMenu_ListBox] call F90_fnc_getSelectedList;
if(DeadMenuList_SelectedList == -1)then{DeadMenuList_SelectedList = 0}; 
[Persistent_Debug, "deadMenuLoad", format ["Loading previously saved game from slot %1", DeadMenuList_SelectedList], true] call F90_fnc_debug;

[DeadMenuList_SelectedList] call F90_fnc_loadGame;