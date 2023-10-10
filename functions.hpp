class F90
{
	class Base
	{
		class debug {file = "DebugController.sqf";};
	};

	class Dialog 
	{
		class createSaveSlot 	{file = "Scripts\Dialog\createSaveSlot.sqf";};
		class deleteSaveSlot 	{file = "Scripts\Dialog\deleteSaveSlot.sqf";};
		class dialogLoad	 	{file = "Scripts\Dialog\dialogLoad.sqf";};
		class dialogSave 		{file = "Scripts\Dialog\dialogSave.sqf";};
		class getSelectedList 	{file = "Scripts\Dialog\getSelectedList.sqf";};
		class openInfoTab 		{file = "Scripts\Dialog\openInfoTab.sqf";};
		class updatePlayerInfo 	{file = "Scripts\Dialog\updatePlayerInfo.sqf";};
		class updateSlotList	{file = "Scripts\Dialog\updateSlotList.sqf";};
	};

	class EOS
	{
		class eosCore	{file = "EOS\core\eosCore.sqf";};
		class bLaunch	{file = "EOS\core\bLaunch.sqf";};
		class eosLaunch {file = "EOS\core\eosLaunch.sqf";};
	};

	class Init
	{
		class initDialogSaveSystem 	{file = "Init\initDialogSaveSystem.sqf";};
		class initDialogVars		{file = "Init\initDialogVars.sqf";};
		class initGarrison			{file = "Init\initGarrison.sqf";};
		class initPersistent		{file = "Init\initpersistent.sqf";};
		class initVars 				{file = "Init\initVars.sqf";};
	};

	class Persistent
	{
		//	CORE
		class clearSave				{file = "Persistent\Core\clearSave.sqf";};
		class listExistingVariables	{file = "Persistent\Core\listExistingVariables.sqf";};
		class loadData 				{file = "Persistent\Core\loadData.sqf";};
		class saveData				{file = "Persistent\Core\saveData.sqf";};
		class startNewGame 			{file = "Persistent\Core\startNewGame.sqf";};

		//	LOAD
		class loadGame 				{file = "Persistent\Load\loadGame.sqf";};
		class loadGarrison 			{file = "Persistent\Load\loadGarrison.sqf";};
		class loadMissionID			{file = "Persistent\Load\loadMissionID.sqf";};
		class loadPlayer			{file = "Persistent\Load\loadPlayer.sqf";};
		class loadPlayerInfo		{file = "Persistent\Load\loadPlayerInfo.sqf";};
		class loadUnitData 			{file = "Persistent\Load\loadUnitData.sqf";};
		class loadUnitsInGroup		{file = "Persistent\Load\loadUnitsInGroup.sqf";};
		class loadVarFromNamespace	{file = "Persistent\Load\loadVarFromNamespace.sqf";};

		//	SAVE
		class saveCustomContainers	{file = "Persistent\Save\saveCustomContainers.sqf";};
		class saveCustomUnits		{file = "Persistent\Save\saveCustomUnits.sqf";};
		class saveCustomVariables	{file = "Persistent\Save\saveCustomVariables.sqf";};
		class saveCustomVehicles	{file = "Persistent\Save\saveCustomVehicles.sqf";};
		class saveEnvironment		{file = "Persistent\Save\saveEnvironment.sqf";};
		class saveGame				{file = "Persistent\Save\saveGame.sqf";};
		class saveGarrison			{file = "Persistent\Save\saveGarrison.sqf";};
		class saveMapMarkers		{file = "Persistent\Save\saveMapMarkers.sqf";};
		class saveMetadata			{file = "Persistent\Save\saveMetadata.sqf";};
		class saveMissionID 		{file = "Persistent\Save\saveMissionID.sqf";};
		class savePlayer 			{file = "Persistent\Save\savePlayer.sqf";};
		class savePlayerInfo 		{file = "Persistent\Save\savePlayerInfo.sqf";};

		//	UTILS
		class compileCode				{file = "Persistent\Utils\compileCode.sqf";};
		class generateCargoData 		{file = "Persistent\Utils\generateCargoData.sqf";};
		class generateGroupData			{file = "Persistent\Utils\generateGroupData.sqf";};
		class generatePositioningData	{file = "Persistent\Utils\generatePositioningData.sqf";};
		class generateSaveTime			{file = "Persistent\Utils\generateSaveTime.sqf";};
		class generateUnitData			{file = "Persistent\Utils\generateUnitData.sqf";};
		class getByKey 					{file = "Persistent\Utils\getByKey.sqf";};
	};

	class Revive 
	{
		class addPlayerHoldRevive		{file = "Revive\addPlayerHoldRevive.sqf";};
		class addRevive 				{file = "Revive\addRevive.sqf";};
		class handleDamageEH			{file = "Revive\handleDamageEH.sqf";};
		class setUnitReviveState		{file = "Revive\setUnitReviveState.sqf";};
		class unitReviveBody			{file = "Revive\unitReviveBody.sqf";};
	};

	class Scripts
	{
		//	Base
		class generateRandomID	{file = "Scripts\generateRandomID.sqf";};
		class showNotification 	{file = "Scripts\showNotification.sqf";};
		class patrolArea 		{file = "Scripts\UPS.sqf";};

		//	Garrison
		class clearZones		{file = "Scripts\Garrison\clearZones.sqf";};
		class createIcon 		{file = "Scripts\Garrison\createIcon.sqf";};
		class generateGarrison 	{file = "Scripts\Garrison\generateGarrison.sqf";};
		class spawnGarrison		{file = "Scripts\Garrison\spawnGarrison.sqf";};
		class spawnGroup		{file = "Scripts\Garrison\spawnGroup.sqf";};
		class spawnStatic		{file = "Scripts\Garrison\spawnStatic.sqf";};
		class spawnVehicle		{file = "Scripts\Garrison\spawnVehicle.sqf";};

		//	SHOP
		class purchaseSelected 	{file = "Scripts\Shop\Recruit\purchaseSelected.sqf";};
		class spawnRecruit 		{file = "Scripts\Shop\Recruit\spawnRecruit.sqf";};	
	};
};