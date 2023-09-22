class F90
{
	class Base
	{
		class debug {file = "DebugController.sqf"};
	};

	class Dialog 
	{
		class createSaveSlot 	{file = "Scripts\Dialog\createSaveSlot.sqf";};
		class getSelectedList 	{file = "Scripts\Dialog\getSelectedList.sqf";};
		class openPersistentTab {file = "Scripts\Dialog\openPersistentTab.sqf";};
		class startLoadGame 	{file = "Scripts\Dialog\startLoadGame.sqf";};
		class startNewGame 		{file = "Scripts\Dialog\startNewGame.sqf";};
		class updateSlotList	{file = "Scripts\Dialog\updateSlotList.sqf";};
	};

	class EOS
	{
		class eosInit 	{file = "EOS\eosInit.sqf";};
		//--CORE--//
		class eosCore	{file = "EOS\core\eosCore.sqf";};
		class bLaunch	{file = "EOS\core\bLaunch.sqf";};
		class eosLaunch {file = "EOS\core\eosLaunch.sqf";};
	};

	class Init
	{
		class initDialogSaveSystem 	{file = "Init\initDialogSaveSystem.sqf";};
		class initPersistent		{file = "Init\initpersistent.sqf";};
		class initVars 				{file = "Init\initVars.sqf";};
	};

	class Persistent
	{
		//	CORE
		class saveData		{file = "Persistent\Core\saveData.sqf";};
		class saveGame		{file = "Persistent\Core\saveGame.sqf";};
		class saveMetadata	{file = "Persistent\Core\saveMetadata.sqf";};
		class savePlayer 	{file = "Persistent\Core\savePlayer.sqf";};

		//	UTILS
		class generateUnitData {file = "Persistent\Utils\generateUnitData.sqf";};
	};

};