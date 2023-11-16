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
[Persistent_Debug, "deadMenuLoad", "Loading previously saved game", true] call F90_fnc_debug;

DeadMenuList_SelectedList = [DeadMenu_ListBox] call F90_fnc_getSelectedList;
if(DeadMenuList_SelectedList == -1)then{DeadMenuList_SelectedList = 0}; 

[DeadMenuList_SelectedList] call F90_fnc_loadGame;