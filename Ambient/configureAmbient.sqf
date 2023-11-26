/*
	Author: PrinceF90 
 
	Description: 
	This code is a configuration for an ambient system. It sets various parameters related to spawning and managing ambient objects in the game world. 
	
	Parameter(s): 
	N/A
	
	Returns: 
	N/A
	
	Example(s): 
	N/A
*/
Ambient_Debug = false;
Ambient_CheckInterval = 5; // NUMBER - The time interval in seconds to run the ambient check. 
Ambient_HouseScannerRadius = 300; // NUMBER - The radius in meters to scan for houses from the player.

//	Ambient Parking Setting. Doesn't matter if feature is turned off
Ambient_ParkingEnabled = true;	// BOOLEAN - Enables or disables ambient parking. True will spawn parked cars. 
Ambient_EnableAlarm = true;	// BOOLEAN - Enables or disables car alarms going off if stolen by the player.
Ambient_ParkingSpawnChance = 20; // NUMBER - The percentage chance that a house will spawn a parked car. 
Ambient_WreckSpawnChance = 2; // NUMBER - The percentage chance that spawned cars will be wrecked. 
Ambient_ParkingDespawnDistance = 400; // NUMBER - The range in meters for a vehicle to despawn

Ambient_Towns = []; // ARRAY - An array of town names (not specified in the code). 

//	Include DLC 
Ambient_EnableTanoanCars = true; // BOOLEAN - Enables or disables the spawning of Tanoan cars. 
Ambient_EnableLivonianCars = false; // BOOLEAN - Enables or disables the spawning of Livonian cars. 
Ambient_EnableIDAPCars = false; // TBOOLEAN - Enables or disables the spawning of IDAP cars.

Ambient_CustomHouses = []; // ARRAY - An array of custom house classnames.
Ambient_CustomCivCars = []; // ARRAY - An array of custom civilian car classnames. 

//	Do not edit anything below here
Ambient_NextSpawn = 0;

Ambient_HousesArray = [];
Ambient_CheckedHouses = [];
Ambient_SpawnedCars = [];

Ambient_HousesList = 
[ 
	// Altis/Stratis
	"Land_i_House_Small_01_V1_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_House_Small_01_V3_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_i_House_Small_03_V1_F",
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_Shop_01_V1_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_01_V3_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_02_V2_F",
	"Land_i_Shop_02_V3_F",
	"Land_i_Addon_01_V1_F",
	"Land_i_Addon_01_V2_F",
	"Land_i_Addon_01_V3_F",
	"Land_i_Addon_02_V1_F",
	"Land_i_Addon_02_V2_F",
	"Land_i_Addon_02_V3_F",
	"Land_i_Addon_03_V1_F",
	"Land_i_Addon_03_V2_F",
	"Land_i_Addon_03_V3_F",

	// Tanoa
	"Land_house_small_01_F", 
	"Land_house_small_02_F",
	"Land_house_small_03_F",
	"Land_house_small_04_F",
	"Land_house_small_05_F",
	"Land_house_small_06_F",
	"Land_house_big_01_F",
	"Land_house_big_02_F",
	"Land_house_big_03_F",
	"Land_house_big_04_F",
	"Land_house_big_05_F",
	"Land_slum_01_F",
	"Land_slum_02_F",
	"Land_slum_03_F",
	"Land_slum_04_F",
	"Land_slum_05_F",
	"Land_slum_house_01_F",
	"Land_slum_house_02_F",
	"Land_slum_house_03_F",
	"Land_slum_house_04_F",
	"Land_slum_house_05_F",
	"Land_house_native_01_F",
	"Land_house_native_02_F",
	"Land_hotel_01_F",
	"Land_hotel_02_F",
	"Land_shop_city_01_F",
	"Land_shop_city_02_F",
	"Land_shop_city_03_F",
	"Land_shop_city_04_F",
	"Land_shop_city_05_F",
	"Land_shop_city_06_F",
	"Land_shop_city_07_F",
	"Land_shop_town_01_F",
	"Land_shop_town_02_F",
	"Land_shop_town_03_F",
	"Land_shop_town_04_F",
	"Land_shop_town_05_F",
	"Land_Warehouse_01_F",
	"Land_Warehouse_02_F",
	"Land_Warehouse_03_F",
	"Land_Temple_Native_01_F",
	"Land_Temple_Native_02_F",
	"Land_GarageShelter_01_F",
	"Land_School_01_F",
	"Land_FuelStation_02_workshop_F",
	"Land_FuelStation_01_shop_F",
	"Land_Multistoreybuilding_01_F",
	"Land_Multistoreybuilding_03_F",
	"Land_Multistoreybuilding_04_F",

	// Malden
	"Land_i_House_Small_01_b_blue_F",
	"Land_i_House_Small_01_b_pink_F",
	"Land_i_House_Small_01_b_yellow_F",
	"Land_i_House_Small_01_b_brown_F",
	"Land_i_House_Small_01_b_white_F",
	"Land_i_House_Small_01_b_whiteblue_F",
	"Land_i_House_Small_02_b_blue_F",
	"Land_i_House_Small_02_b_pink_F",
	"Land_i_House_Small_02_b_yellow_F",
	"Land_i_House_Small_02_b_brown_F",
	"Land_i_House_Small_02_b_white_F",
	"Land_i_House_Small_02_b_whiteblue_F",
	"Land_i_House_Small_02_c_blue_F",
	"Land_i_House_Small_02_c_pink_F",
	"Land_i_House_Small_02_c_yellow_F",
	"Land_i_House_Small_02_c_brown_F",
	"Land_i_House_Small_02_c_white_F",
	"Land_i_House_Small_02_c_whiteblue_F",
	"Land_i_House_Big_01_b_blue_F",
	"Land_i_House_Big_01_b_pink_F",
	"Land_i_House_Big_01_b_yellow_F",
	"Land_i_House_Big_01_b_brown_F",
	"Land_i_House_Big_01_b_white_F",
	"Land_i_House_Big_01_b_whiteblue_F",
	"Land_i_House_Big_02_b_blue_F",
	"Land_i_House_Big_02_b_pink_F",
	"Land_i_House_Big_02_b_yellow_F",
	"Land_i_House_Big_02_b_brown_F",
	"Land_i_House_Big_02_b_white_F",
	"Land_i_House_Big_02_b_whiteblue_F",
	"Land_i_Shop_01_b_blue_F",
	"Land_i_Shop_01_b_pink_F",
	"Land_i_Shop_01_b_yellow_F",
	"Land_i_Shop_01_b_brown_F",
	"Land_i_Shop_01_b_white_F",
	"Land_i_Shop_01_b_whiteblue_F",
	"Land_i_Shop_02_b_blue_F",
	"Land_i_Shop_02_b_pink_F",
	"Land_i_Shop_02_b_yellow_F",
	"Land_i_Shop_02_b_brown_F",
	"Land_i_Shop_02_b_white_F",
	"Land_i_Shop_02_b_whiteblue_F",

	// Livonia
	"Land_House_1B01_F",
	"Land_House_1W01_F",
	"Land_House_1W02_F",
	"Land_House_1W03_F",
	"Land_House_1W04_F",
	"Land_House_1W05_F",
	"Land_House_1W06_F",
	"Land_House_1W07_F",
	"Land_House_1W08_F",
	"Land_House_1W09_F",
	"Land_House_1W10_F",
	"Land_House_1W11_F",
	"Land_House_1W12_F",
	"Land_House_2B01_F",
	"Land_House_2B02_F",
	"Land_House_2B03_F",
	"Land_House_2B04_F",
	"Land_House_2W01_F",
	"Land_House_2W02_F",
	"Land_House_2W03_F",
	"Land_House_2W04_F",
	"Land_House_2W05_F",
	"Land_workshop_01_f",
	"Land_workshop_02_f",
	"Land_workshop_03_f",
	"Land_barn_01_f",
	"Land_barn_02_f",
	"Land_barn_03_f",	
	"Land_barn_01_large_f",
	"Land_barn_02_large_f",
	"Land_barn_03_large_f",
	"Land_Camp_House_01_brown_F",
	"Land_VillageStore_01_f",
	"Land_policestation_01_f",
	"Land_caravan_01_rust_f",

	// JBAD buildings
	"Land_jbad_house1", 
	"Land_jbad_house3",
	"Land_jbad_house5",
	"Land_jbad_house6",
	"Land_jbad_house7",
	"Land_jbad_house8",
	"Land_jbad_house1",
	"Land_jbad_House_c_1_v2",
	"Land_jbad_House_c_2",
	"Land_jbad_House_c_3",
	"Land_jbad_House_c_4",
	"Land_jbad_House_c_5",
	"Land_jbad_House_c_9",
	"Land_jbad_House_c_10",
	"Land_jbad_House_c_11",
	"Land_jbad_House_c_12",
	"Land_Jbad_Ind_FuelStation_Build",
	"Land_jbad_A_GeneralStore_01",
	"Land_jbad_A_GeneralStore_01a",
	"Land_Jbad_A_Mosque_small_1",
	"Land_Jbad_A_Mosque_small_2",
	"Land_Jbad_A_Stationhouse",
	"Land_Jbad_A_Villa",
	"Land_Jbad_Ind_Garage01",
	"Land_jbad_House_1_old",
	"Land_jbad_House_3_old",
	"Land_jbad_House_4_old",
	"Land_jbad_House_6_old",
	"Land_jbad_House_7_old",
	"Land_jbad_House_8_old",
	"Land_jbad_House_9_old",
	"Land_jbad_House_8_old",
	"Land_jbad_House_7_old",
	"Land_jbad_House_4_old",
	"Land_jbad_House3",
	"Land_jbad_House7",
	"Land_jbad_House5",
	"Land_jbad_shop_01",
	"Land_jbad_House6",
	"Land_jbad_House_1",
	"Land_jbad_House_3_old_h",
	"Land_jbad_House_6_old",
	"Land_jbad_House_1_old",
	"Land_Jbad_opx2_hut2",
	"Land_jbad_opx2_h1",
	"Land_jbad_House_c_11",
	"Land_jbad_House_c_5",
	"Land_Jbad_opx2_hut4",
	"Land_Jbad_opx2_hut1",
	"Land_Jbad_opx2_hut3",
	"Land_jbad_market_stalls_02",
	"Land_jbad_opx2_garages",
	"Land_jbad_House_c_1",
	"Land_jbad_House_c_1_v2",
	"Land_jbad_opx2_cornershop1",
	"Land_jbad_opx2_construct1",
	"Land_jbad_opx2_store1",
	"Land_jbad_opx2_complex9",
	"Land_jbad_mosque_big_addon",
	"Land_jbad_opx2_big_f",
	"Land_jbad_opx2_construct4",
	"Land_jbad_opx2_big_d",
	"Land_jbad_opx2_big_c",
	"Land_jbad_House_c_9",
	"Land_jbad_market_stalls_01",
	"Land_jbad_opx2_big_e",
	"Land_jbad_House_c_10",
	"Land_jbad_opx2_corner2",
	"Land_jbad_opx2_apartmentcomplex5",
	"Land_jbad_opx2_complex3",
	"Land_jbad_opx2_apartmentcomplex4",
	"Land_Shop_City_07_F",
	"Land_jbad_opx2_big_b",
	"Land_Shop_City_03_F",
	"Land_jbad_opx2_complex4",
	"Land_jbad_opx2_corner1",
	"Land_jbad_opx2_complex1",
	"Land_jbad_grainstore3",
	"Land_jbad_opx2_big",
	"Land_jbad_opx2_stores2",
	"Land_jbad_opx2_construct2",
	"Land_Jbad_opx2_hut_invert1",
	"Land_jbad_opx2_tower1",
	"Land_Jbad_A_Villa",
	"Land_jbad_opx2_construct3",
	"Land_Jbad_Ind_Garage01",
	"Land_jbad_Ind_TankSmall2",
	"Land_jbad_opx2_apartmentcomplex_wip",
	"Land_jbad_opx2_complex7",
	"Land_jbad_opx2_block1",
	"Land_jbad_opx2_complex5",
	"Land_jbad_House_9_old",
	"Land_jbad_opx2_apartmentcomplex",
	"Land_jbad_mosque_big_minaret_1",
	"Land_jbad_opx2_complex6",
	"Land_jbad_opx2_complex8",
	"Land_jbad_opx2_complex2",
	"Land_Jbad_Ind_sawmillpen",
	"Land_Jbad_Ind_PowerStation",
	"Land_jbad_opx2_policestation",
	"Land_jbad_mosque_big_wall_gate",
	"Land_jbad_mosque_big_minaret_2",
	"Land_jbad_mosque_big_wall_corner",
	"Land_jbad_mosque_big_wall",
	"Land_jbad_mosque_big_hq",
	"Land_jbad_House_c_3",
	"Land_jbad_House_c_2",
	"Land_House_Big_04_F",
	"Land_jbad_House_c_4",
	"Land_jbad_dum_istan2",
	"Land_Jbad_Ind_Workshop01_03",
	"Land_Jbad_Ind_Workshop01_02",
	"Land_Jbad_Ind_Workshop01_01",
	"Land_jbad_A_GeneralStore_01",
	"Land_jbad_opx2_garage1",
	"Land_jbad_House8",
	"Land_jbad_grainstore2",
	"Land_jbad_grainstore",
	"Land_jbad_shop_04",
	"Land_jbad_shop_03",
	"Land_jbad_shop_02",
	"Land_Jbad_A_Minaret",
	"Land_Jbad_A_Mosque_small_2",
	"Land_Jbad_Ind_Shed_01",

	// Lythium
	"land_ffaa_casa_urbana_1",
	"land_ffaa_casa_urbana_2",
	"land_ffaa_casa_urbana_3",
	"land_ffaa_casa_urbana_4",
	"land_ffaa_casa_urbana_5",
	"land_ffaa_casa_urbana_6",
	"land_ffaa_casa_urbana_7",
	"land_ffaa_casa_urbana_7A",
	"land_ffaa_casa_urbana_8",
	"land_ffaa_casa_af_1",
	"land_ffaa_casa_af_2",
	"land_ffaa_casa_af_3",
	"land_ffaa_casa_af_3A",
	"land_ffaa_casa_af_4",
	"land_ffaa_casa_af_4A",
	"land_ffaa_casa_af_5",
	"land_ffaa_casa_af_6",
	"land_ffaa_casa_af_7",
	"land_ffaa_casa_af_8",
	"land_ffaa_casa_af_9",
	"land_ffaa_casa_af_10",
	"land_ffaa_casa_af_10A",
	"land_ffaa_casa_sha_1",
	"land_ffaa_casa_sha_2",
	"land_ffaa_casa_sha_3",
	"land_ffaa_casa_barrancon_1",
	"land_ffaa_casa_barracon_2",
	"land_ffaa_casa_caseta_peq",
	"land_ffaa_casa_acc_1",

	// Chernarus redux
	"land_housev_1l1",
	"land_housev_1l2",
	"land_housev_1t",
	"land_housev_2i",
	"land_housev_2l",
	"land_housev_2t1",
	"land_housev_2t2",
	"land_housev_3i1",
	"land_housev_3i2",
	"land_housev_3i3",
	"land_housev_3i4",
	"land_housev_01a",
	"land_housev_01b",
	"Land_ds_houseV_1L2",
	"Land_ds_houseV_1t",
	"Land_ds_houseV_2l",
	"Land_ds_houseV_2L",
	"Land_ds_houseV_2T1",
	"Land_ds_houseV_2T2",
	"Land_ds_houseV_3l1",
	"Land_ds_houseV_3l2",
	"Land_ds_houseV_3l3",
	"Land_ds_houseV_3l4",

	// Western Sahara
	"Land_House_L_9_EP1_lxWS",
	"Land_House_L_1_EP1_lxWS",
	"Land_House_L_3_EP1_lxWS",
	"Land_House_L_7_EP1_lxWS",
	"Land_House_L_8_EP1_lxWS",
	"Land_Misc_Well_L_EP1_lxWS",
	"Land_Shed_06_F",
	"Land_Slum_House03_F",
	"Land_WoodenShelter_01_F",
	"Land_Shed_05_F",
	"Land_Shed_07_F",
	"Land_SM_01_shelter_narrow_F",
	"Land_Shed_04_F",
	"Land_SM_01_shed_F",

	"Land_MetalShelter_01_F",
	"Land_Shed_02_F",
	"Land_GuardHouse_01_F",
	"Land_TBox_F",
	"Land_dp_smallFactory_F",
	"Land_dp_bigTank_F",
	"Land_SCF_01_feeder_lxWS",
	"Land_House_Small_02_F",
	"Land_SM_01_shelter_wide_F",
	"Land_House_K_3_EP1_lxWS",
	"Land_Slum_House02_F",
	"Land_MilOffices_V1_F",
	"Land_i_Shed_Ind_F",
	"Land_cmp_Shed_F",
	"Land_House_C_5_EP1_off_lxWS",
	"land_tower_lxws",
	"Land_House_C_5_V3_EP1_off_lxWS",
	"Land_cmp_Tower_F",
	"Land_House_K_1_EP1_lxWS",
	"Land_House_C_12_EP1_off_lxWS",
	"Land_House_C_11_EP1_off_lxWS",
	"Land_A_Mosque_small_2_EP1_lxWS",
	"Land_SM_01_shed_unfinished_F",
	"Land_dp_smallTank_F",
	"Land_House_C_5_V1_EP1_off_lxWS",
	"Land_Shed_Small_F",
	"Land_Addon_05_F",
	"Land_Warehouse_03_F",
	"Land_Communication_anchor_F",
	"Land_Dome_Small_F",
	"Land_Shed_Big_F",
	"Land_Research_house_V1_F",
	"Land_Slum_House01_F",
	"Land_Shed_01_F",
	"Land_House_C_5_V2_EP1_off_lxWS",
	"Land_Barracks_01_grey_F",
	"Land_i_House_Small_03_V1_F",
	"Land_Shed_03_F",
	"Land_Metal_Shed_F",
	"Land_TentHangar_V1_F",
	"Land_Airport_02_controlTower_F",
	"Land_Airport_01_hangar_F",
	"Land_i_Garage_V2_F",
	"Land_Slum_01_F",
	"Land_CarService_F",
	"Land_FuelStation_02_roof_lxWS",
	"Land_House_Small_01_F",
	"Land_FuelStation_Build_F"
];
Ambient_HousesList = Ambient_HousesList + Ambient_CustomHouses;

Ambient_CivilianCarList = 
[
	"C_Hatchback_01_F",
	"C_Hatchback_01_rallye_F",
	"C_Hatchback_01_sportF",
	"C_Offroad_01_F",
	"C_Offroad_01_repair_F",
//	"C_Offroad_01_sport_F",
	"C_Offroad_01_covered_F",
	"C_SUV_01_F",
	"C_SUV_01_sport_F",
	"C_Van_01_box_F",
	"C_Van_01_transport_F",
	"C_Van_01_fuel_F"
];

Ambient_CivilianCarList = Ambient_CivilianCarList + Ambient_CustomCivCars;
if (Ambient_EnableTanoanCars) then 
{
	Ambient_CivilianCarList = Ambient_CivilianCarList + ["C_Offroad_02_unarmed_F"];
};
if (Ambient_EnableLivonianCars) then 
{
	Ambient_CivilianCarList = Ambient_CivilianCarList + ["c_tractor_01_f"];
};
if (Ambient_EnableIDAPCars) then 
{
	if (isclass (configfile/"CfgWeapons"/"U_C_IDAP_Man_cargo_F")) then
	{
		private _cfg = (configFile >> "CfgVehicles");

		for "_i" from 0 to ((count _cfg) -1) do 
		{
			if (isClass ((_cfg # _i) ) ) then
			{
				private _cfgName = configName (_cfg # _i);

				if ( (_cfgName isKindOf "car") && {getNumber ((_cfg # _i) >> "scope") == 2} && {["IDAP",str _cfgname] call BIS_fnc_inString}&& {!(["UGV",str _cfgname] call BIS_fnc_inString)}) then
				{
					Ambient_CivilianCarList pushBack _cfgName;
				};
			};
		};
	};
	
};


Ambient_WreckedCarList = 
[
	"land_wreck_offroad_f",
	"land_wreck_van_f",
	"land_wreck_hunter_f",
	"land_wreck_car2_f",
	"land_wreck_car3_f",
	"land_wreck_uaz_f",
	"land_wreck_hmmvw_f",
	"land_wreck_truck_f",
	"land_wreck_truck_dropside_f",
	"land_wreck_skodovka_f"
];

configureAmbientDone = true;
