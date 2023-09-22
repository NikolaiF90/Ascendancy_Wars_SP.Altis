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
		class clearSave				{file = "Persistent\Core\clearSave.sqf";};
		class listExistingVariables	{file = "Persistent\Core\listExistingVariables.sqf";};
		class loadVarFromNamespace	{file = "Persistent\Core\loadVarFromNamespace.sqf";};
		class saveCustomContainers	{file = "Persistent\Core\saveCustomContainers.sqf";};
		class saveCustomUnits		{file = "Persistent\Core\saveCustomUnits.sqf";};
		class saveCustomVariables	{file = "Persistent\Core\saveCustomVariables.sqf";};
		class saveCustomVehicles	{file = "Persistent\Core\saveCustomVehicles.sqf";};
		class saveData				{file = "Persistent\Core\saveData.sqf";};
		class saveEnvironment		{file = "Persistent\Core\saveEnvironment.sqf";};
		class saveGame				{file = "Persistent\Core\saveGame.sqf";};
		class saveMapMarkers		{file = "Persistent\Core\saveMapMarkers.sqf";};
		class saveMetadata			{file = "Persistent\Core\saveMetadata.sqf";};
		class savePlayer 			{file = "Persistent\Core\savePlayer.sqf";};

		//	UTILS
		class compileCode				{file = "Persistent\Utils\compileCode.sqf";};
		class generateCargoData 		{file = "Persistent\Utils\generateCargoData.sqf";};
		class generateGroupData			{file = "Persistent\Utils\generateGroupData.sqf";};
		class generatePositioningData	{file = "Persistent\Utils\generatePositioningData.sqf";};
		class generateSaveTime			{file = "Persistent\Utils\generateSaveTime.sqf";};
		class generateUnitData			{file = "Persistent\Utils\generateUnitData.sqf";};
	};

};