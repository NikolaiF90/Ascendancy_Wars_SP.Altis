class F90
{
	class Base
	{
		class debug {file = "DebugController.sqf";};
	};

	class Ambient 
	{
		//	BASE
		class configureAmbient	{file = "Ambient\configureAmbient.sqf";};
		class scanHouses		{file = "Ambient\scanHouses.sqf";};

		//	PARKINGS
		class despawnVehicleCheck 	{file = "Ambient\Parkings\despawnVehicleCheck.sqf";};
		class findParking			{file = "Ambient\Parkings\findParking.sqf";};
		class parkingResetCheck		{file = "Ambient\Parkings\parkingResetCheck.sqf";};
		class spawnParkedCars 		{file = "Ambient\Parkings\spawnParkedCars.sqf";};
		class stealCarEH			{file = "Ambient\Parkings\stealCarEH.sqf";};
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

	class Init
	{
		class initAmbient			{file = "Init\initAmbient.sqf";};
		class initDialogSaveSystem 	{file = "Init\initDialogSaveSystem.sqf";};
		class initDialogVars		{file = "Init\initDialogVars.sqf";};
		class initEconomy			{file = "Init\initEconomy.sqf";};
		class initGarrison			{file = "Init\initGarrison.sqf";};
		class initPersistent		{file = "Init\initPersistent.sqf";};
		class initRevive			{file = "Init\initRevive.sqf";};
		class initShop 				{file = "Init\initShop.sqf";};
		class initShopItems			{file = "Init\initShopItems.sqf";};
		class initVars 				{file = "Init\initVars.sqf";};
	};

	class Persistent
	{
		//	BASE
		class configurePersistent	{file = "Persistent\configurePersistent.sqf";};

		//	CORE
		class clearSave				{file = "Persistent\Core\clearSave.sqf";};
		class listExistingVariables	{file = "Persistent\Core\listExistingVariables.sqf";};
		class loadData 				{file = "Persistent\Core\loadData.sqf";};
		class saveData				{file = "Persistent\Core\saveData.sqf";};
		class startNewGame 			{file = "Persistent\Core\startNewGame.sqf";};

		//	LOAD
		class loadCDARSData			{file = "Persistent\Load\loadCDARSData.sqf";};
		class loadVehicles			{file = "Persistent\Load\loadVehicles.sqf";};
		class loadGame 				{file = "Persistent\Load\loadGame.sqf";};
		class loadGarrison 			{file = "Persistent\Load\loadGarrison.sqf";};
		class loadMapMarkers		{file = "Persistent\Load\loadMapMarkers.sqf";};
		class loadMissionID			{file = "Persistent\Load\loadMissionID.sqf";};
		class loadPlayer			{file = "Persistent\Load\loadPlayer.sqf";};
		class loadPlayerInfo		{file = "Persistent\Load\loadPlayerInfo.sqf";};
		class loadTriggerData 		{file = "Persistent\Load\loadTriggerData.sqf";};
		class loadUnitData 			{file = "Persistent\Load\loadUnitData.sqf";};
		class loadUnitsInGroup		{file = "Persistent\Load\loadUnitsInGroup.sqf";};
		class loadVarFromNamespace	{file = "Persistent\Load\loadVarFromNamespace.sqf";};

		//	SAVE
		class saveCDARSData			{file = "Persistent\Save\saveCDARSData.sqf";};
		class saveCustomContainers	{file = "Persistent\Save\saveCustomContainers.sqf";};
		class saveCustomUnits		{file = "Persistent\Save\saveCustomUnits.sqf";};
		class saveCustomVariables	{file = "Persistent\Save\saveCustomVariables.sqf";};
		class saveVehicles			{file = "Persistent\Save\saveVehicles.sqf";};
		class saveEnvironment		{file = "Persistent\Save\saveEnvironment.sqf";};
		class saveGame				{file = "Persistent\Save\saveGame.sqf";};
		class saveGarrison			{file = "Persistent\Save\saveGarrison.sqf";};
		class saveMapMarkers		{file = "Persistent\Save\saveMapMarkers.sqf";};
		class saveMetadata			{file = "Persistent\Save\saveMetadata.sqf";};
		class saveMissionID 		{file = "Persistent\Save\saveMissionID.sqf";};
		class savePlayer 			{file = "Persistent\Save\savePlayer.sqf";};
		class savePlayerInfo 		{file = "Persistent\Save\savePlayerInfo.sqf";};

		//	UTILS
		class addUnitToVehicle	 		{file = "Persistent\Utils\addUnitToVehicle.sqf";};
		class addVehiclesToSave 		{file = "Persistent\Utils\addVehiclesToSave.sqf";};
		class applyCargoData			{file = "Persistent\Utils\applyCargoData.sqf";};
		class applyDamage				{file = "Persistent\Utils\applyDamage.sqf";};
		class applyPositioningData		{file = "Persistent\Utils\applyPositioningData.sqf";};
		class clearArray				{file = "Persistent\Utils\clearArray.sqf";};
		class compileCode				{file = "Persistent\Utils\compileCode.sqf";};
		class generateCargoData 		{file = "Persistent\Utils\generateCargoData.sqf";};
		class generateGroupData			{file = "Persistent\Utils\generateGroupData.sqf";};
		class generatePositioningData	{file = "Persistent\Utils\generatePositioningData.sqf";};
		class generateSaveTime			{file = "Persistent\Utils\generateSaveTime.sqf";};
		class generateTriggerData		{file = "Persistent\Utils\generateTriggerData.sqf";};
		class generateUnitData			{file = "Persistent\Utils\generateUnitData.sqf";};
		class getByKey 					{file = "Persistent\Utils\getByKey.sqf";};
	};

	class Revive 
	{
		class addPlayerHoldRevive		{file = "Revive\addPlayerHoldRevive.sqf";};
		class addRevive 				{file = "Revive\addRevive.sqf";};
		class bleedOut					{file = "Revive\bleedOut.sqf";};
		class configureRevive			{file = "Revive\configureRevive.sqf";};
		class debugRevive				{file = "Revive\debugRevive.sqf";};
		class dropInventory				{file = "Revive\dropInventory.sqf";};
		class revivePrisoner			{file = "Revive\revivePrisoner.sqf";};
		class setUnitReviveState		{file = "Revive\setUnitReviveState.sqf";};
		class unitReviveBody			{file = "Revive\unitReviveBody.sqf";};
	};

	class Scripts
	{
		//	Base
		class createUnit		{file = "Scripts\createUnit.sqf";};
		class generateRandomID	{file = "Scripts\generateRandomID.sqf";};
		class getInventory		{file = "Scripts\getInventory.sqf";};
		class showLoadingScreen {file = "Scripts\showLoadingScreen.sqf";};
		class showNotification 	{file = "Scripts\showNotification.sqf";};
		class patrolArea 		{file = "Scripts\UPS.sqf";};

		//	CDARS
		class assignAsReinforcement	{file = "Scripts\CDARS\assignAsReinforcement.sqf";};
		class configureCDARS		{file = "Scripts\CDARS\configureCDARS.sqf";};
		class createReinforcement	{file = "Scripts\CDARS\createReinforcement.sqf";};
		class eastCommanderHandler	{file = "Scripts\CDARS\eastCommanderHandler.sqf";};
		class findNearestGarrisons	{file = "Scripts\CDARS\findNearestGarrisons.sqf";};
		class initCDARS				{file = "Scripts\CDARS\initCDARS.sqf";};
		class sendReinforcement		{file = "Scripts\CDARS\sendReinforcement.sqf";};

		//	Economy
		class configureEconomy 		{file = "Scripts\Economy\configureEconomy.sqf";};
		class economyHandler		{file = "Scripts\Economy\economyHandler.sqf";};

		//	Garrison
		class clearZones			{file = "Scripts\Garrison\clearZones.sqf";};
		class configureGarrison		{file = "Scripts\Garrison\configureGarrison.sqf";};
		class createIcon 			{file = "Scripts\Garrison\createIcon.sqf";};
		class createZone 			{file = "Scripts\Garrison\createZone.sqf";};
		class generateZone  		{file = "Scripts\Garrison\generateZone.sqf";};
		class getPreference  		{file = "Scripts\Garrison\getPreference.sqf";};
		class getZoneOwnerData 		{file = "Scripts\Garrison\getZoneOwnerData.sqf";};
		class spawnGroup			{file = "Scripts\Garrison\spawnGroup.sqf";};
		class zoneHandler			{file = "Scripts\Garrison\zoneHandler.sqf";};

		//	SHOP
		class configureShop 	{file = "Scripts\Shop\configureShop.sqf";};
		class showRecruitMenu 	{file = "Scripts\Shop\showRecruitMenu.sqf";};
		class spawnRecruit 		{file = "Scripts\Shop\Recruit\spawnRecruit.sqf";};	
	};
};