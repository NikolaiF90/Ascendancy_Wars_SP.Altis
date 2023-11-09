params ["_unit"];
diag_log "Recruiting...";
createDialog "recruitMenu";

AWSPRecruit_Buyer = _unit;
// forEach
{
	_soldier = _x # 0;
	lbAdd [RecruitMenu_ListBox,_soldier];
} forEach AWSP_FIARecruits;

while {true} do 
{
	_selectedRecruit = [3500] call F90_fnc_getSelectedList;
	_selectedItem = AWSP_FIARecruits # _selectedRecruit;
	_selectedClass = _selectedItem # 1;
	_selectedPrice = _selectedItem # 2;

	ctrlSetText [RecruitMenu_PriceText,str(_selectedPrice)];
	AWSPRecruit_SelectedRecruit set [0, _selectedItem];
	sleep 0.5;
};

