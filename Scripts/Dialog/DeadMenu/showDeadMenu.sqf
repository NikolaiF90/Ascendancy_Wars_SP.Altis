/*
	Author: PrinceF90 
 
	Description: 
	Function to displays a dead menu dialog to the player. It retrieves the selected item from the DeadMenu_ListBox, checks if a valid selection is made, updates the slot list in the dialog, waits until the player makes a choice, and then closes the dialog if it is open. 
	
	Parameter(s): 
		None 
	
	Returns: 
		None 
	
	Examples: 
		[] call F90_fnc_showDeadMenu;
*/
while {Killed_ChoiceMade == false} do
{
	if (!dialog) then 
	{
		createDialog "deadMenu";

		DeadMenuList_SelectedList = [DeadMenu_ListBox] call F90_fnc_getSelectedList;
		if(DeadMenuList_SelectedList == -1)then{DeadMenuList_SelectedList = 0};
		[DeadMenu_ListBox] call F90_fnc_updateSlotList;
	};
	sleep 2;
};
waitUntil {Killed_ChoiceMade};

if (dialog) then 
{
	closeDialog 2;
};