class persistentMenu
{
	idd = 1002;
	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nikolai, v1.063, #Dijose)
		////////////////////////////////////////////////////////

		class loadMenu_background: RscText
		{
			idc = -1;
			text = " "; //--- ToDo: Localize;
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 1.012 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,0.95};
		};
		class statusInfo_background : RscText
		{
			idc = -1;
			text = " "; //--- ToDo: Localize;
			x = 0.190625 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.809531 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,0.95};
		};
		class persistent_text: RscText
		{
			idc = 2210;
			text = "PERSISTENT"; //--- ToDo: Localize;
			x = 0.0514062 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = 0.04 * safezoneH;
		};
		class slots_listbox: RscListbox
		{
			idc = 2200;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.231 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.25,0.25,0.2,0};
			sizeEx = 0.025 * safezoneH;
		};
		class newgame_button: RscButton
		{
			idc = 2201;
			text = "New Game"; //--- ToDo: Localize;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.45,0.1,1};
			colorActive[] = {0.38,0.36,0.18,1};
			tooltip = "Start a new game"; 
			action = "[] call F90_fnc_startNewGame";
			
		};
		class save_button: RscButton
		{
			idc = 2202;
			text = "Save Game"; //--- ToDo: Localize;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.45,0.1,1};
			colorActive[] = {0.38,0.36,0.18,1};
			tooltip = "Save current game into selected slot"; //--- ToDo: Localize;
			action = "[] call F90_fnc_dialogSave";
		};
		class load_button: RscButton
		{
			idc = 2203;
			text = "Load Game"; //--- ToDo: Localize;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.45,0.1,1};
			colorActive[] = {0.38,0.36,0.18,1};
			tooltip = "Load game from selected slot"; //--- ToDo: Localize;
			action = "[] call F90_fnc_dialogLoad";
		};
		class delete_button: RscButton
		{
			idc = 2204;
			text = "Delete"; //--- ToDo: Localize;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.45,0.1,1};
			colorActive[] = {0.38,0.36,0.18,1};
			tooltip = "Delete saves on selected slot"; //--- ToDo: Localize;
			action = "[] call F90_fnc_deleteSaveSlot";
		};
		class money_text: RscText
		{
			idc = 2205;
			text = "Money : 10000"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.02 * safezoneH;
		};
		class rank_text: RscText
		{
			idc = 2206;
			text = "Rank : Sergeant Major"; //--- ToDo: Localize;
			x = 0.195781 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = 0.02 * safezoneH;
		};
		class resource_text: RscText
		{
			idc = 2207;
			text = "Team Resource : 10000"; //--- ToDo: Localize;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.02 * safezoneH;
		};
		class previous_button: RscButton
		{
			idc = 2208;
			text = "<"; //--- ToDo: Localize;
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,0};
			colorActive[] = {0.38,0.36,0.18,1};
			sizeEx = 0.03 * safezoneH;
		};
		class next_button: RscButton
		{
			idc = 2209;
			text = ">"; //--- ToDo: Localize;
			x = 0.144219 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,0};
			colorActive[] = {0.38,0.36,0.18,1};
			sizeEx = 0.03 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class recruitMenu
{
	idd = 1003;

	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nikolai, v1.063, #Givabo)
		////////////////////////////////////////////////////////

		class recruit_background: RscText
		{
			idc = 3000;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.374 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,1};
		};
		class recruit_listbox: RscListbox
		{
			idc = 3500;
			x = 0.335 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.22 * safezoneH;
			colorBackground[] = {0.25,0.25,0.2,0};
		};
		class recruit_button: RscButton
		{
			idc = 3600;
			text = "Recruit"; //--- ToDo: Localize;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.45,0.1,1};
			action = "[AWSPRecruit_SelectedRecruit, AWSPRecruit_Buyer] call F90_fnc_spawnRecruit";
		};
		class recruitprice_text: RscText
		{
			idc = 3001;
			text = "10000"; //--- ToDo: Localize;
			x = 0.603125 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class pricetext_text: RscText
		{
			idc = 3002;
			text = "Price: "; //--- ToDo: Localize;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class deadMenu
{
	idd = 1004;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nikolai, v1.063, #Gygebi)
		////////////////////////////////////////////////////////

		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.376249 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.561 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			x = 0.396876 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.451 * safezoneH;
			colorBackground[] = {0.118,0.231,0.157,1};
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "You Has Been Killed In Action"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class Dead_List: RscListbox
		{
			idc = 1500;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class Dead_LoadButton: RscButton
		{
			idc = 1600;
			text = "LOAD GAME"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
			action = "Killed_Choice = 0; Killed_ChoiceMade = true";
		};
		class Dead_RespawnButton: RscButton
		{
			idc = 1601;
			text = "RESPAWN"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
			action = "Killed_Choice = 1; Killed_ChoiceMade = true";
		};

		class Dead_EndButton: RscButton
		{
			idc = 1601;
			text = "END GAME"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
			action = "Killed_Choice = 2; Killed_ChoiceMade = true";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class vehicleShopMenu
{
	idd = 1005;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nikolai, v1.063, #Matyjo)
		////////////////////////////////////////////////////////

		class vehicleShop_main: RscText
		{
			idc = 1000;

			x = 0.396875 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.506 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class RscText_1001: RscText
		{
			idc = 1001;

			x = 0.412344 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.429 * safezoneH;
			colorBackground[] = {0.118,0.231,0.157,1};
		};
		class RscText_1002: RscText
		{
			idc = 1002;

			text = "VEHICLE SHOP"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class vehicleShop_listBox: RscListBox
		{
			idc = 5001;

			x = 0.427812 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class RscText_1003: RscText
		{
			idc = 1003;

			x = 0.427812 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class RscText_1004: RscText
		{
			idc = 1004;

			x = 0.427812 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class vehicleShop_button: RscButton
		{
			idc = 5002;
			action = "[] call F90_fnc_purchaseVehicle";

			text = "PURCHASE"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.176,0.388,0.251,1};
		};
		class vehicleShop_priceText: RscText
		{
			idc = 5003;

			text = "Price: 0"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class vehicleShop_moneyText: RscText
		{
			idc = 5004;

			text = "Money: 0"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
		
	};
};