class startMenu
{
	idd = 1002;
	class controlsBackground 
	{

	};
	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Nikolai, v1.063, #Boradu)
		////////////////////////////////////////////////////////

		class start_frame: RscFrame
		{
			idc = 2100;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.458906 * safezoneW;
			h = 0.638 * safezoneH;
			colorBackground[] = {0.16,0.3,0.2,1};
		};

		class start_color: RscText
		{
			idc = 2101;
			text = " ";
			x = -2 * safezoneW + safezoneX;
			y = -2 * safezoneH + safezoneY;
			w = 44.5 * safezoneW;
			h = 29 * safezoneH;
			colorBackground[] = {0.16,0.3,0.2,1};
		};
		class newgame_frame: RscFrame
		{
			idc = 2102;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class newgame_color: RscText
		{
			idc = 2103;
			text = " ";
			x = -0.5 * safezoneW + safezoneX;
			y = 18 * safezoneH + safezoneY;
			w = 20 * safezoneW;
			h = 7.5 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class loadgame_frame: RscFrame
		{
			idc = 2104;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class loadgame_color: RscText
		{
			idc = 2105;
			text = " ";
			x = 21 * safezoneW + safezoneX;
			y = 18 * safezoneH + safezoneY;
			w = 20 * safezoneW;
			h = 7.5 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class parameters_frame: RscFrame
		{
			idc = 2106;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.396 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class parameters_color: RscText
		{
			idc = 2107;
			text = " ";
			x = 21 * safezoneW + safezoneX;
			y = -1 * safezoneH + safezoneY;
			w = 20 * safezoneW;
			h = 18 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class load_listbox: RscListbox
		{
			idc = 2200;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.396 * safezoneH;
			colorBackground[] = {0.22,0.43,0.28,1};
		};
		class newgame_text: RscText
		{
			idc = 2201;
			text = "New Game"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class loadgame_text: RscText
		{
			idc = 2202;
			text = "Load Game"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class parameters_text: RscText
		{
			idc = 2203;
			text = "Parameters"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,1,1,1};
		};

		class newgame_edit: RscEdit
		{
			idc = 2204;
			text = "Enter a save name"; //--- ToDo: Localize;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			tooltip = "Enter a save name"; //--- ToDo: Localize;
		};
		class newgame_button: RscButton
		{
			idc = 2205;
			text = "Start New Game"; //--- ToDo: Localize;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.16,0.3,0.2,1};
			action = "[] call F90_fnc_startNewGame";
			//action = "[] call skhpersist_fnc_SaveGameOnNextSlot";
		};
		class loadgame_button: RscButton
		{
			idc = 2206;
			text = "Load Selected Save"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.16,0.3,0.2,1};
			action = "[] call F90_fnc_startLoadGame";
		};
		class deletegame_button: RscButton
		{
			idc = 2207;
			text = "Delete Selected Save"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.16,0.3,0.2,1};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};


/* #Jocami
$[
	1.063,
	["startMenu1",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1800,"start_frame",[2,"",["-2 * safezoneW + safezoneX","-2 * safezoneH + safezoneY","44.5 * safezoneW","29 * safezoneH"],[-1,-1,-1,-1],[0.16,0.3,0.2,1],[-1,-1,-1,-1],"","-1"],["idc = 2100;"]],
	[1004,"start_color",[2,"",["-2 * safezoneW + safezoneX","-2 * safezoneH + safezoneY","44.5 * safezoneW","29 * safezoneH"],[-1,-1,-1,-1],[0.16,0.3,0.2,1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"newgame_frame",[2,"",["-0.5 * safezoneW + safezoneX","18 * safezoneH + safezoneY","20 * safezoneW","7.5 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],["idc = 2101;"]],
	[1005,"newgame_color",[2,"",["-0.5 * safezoneW + safezoneX","18 * safezoneH + safezoneY","20 * safezoneW","7.5 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"load_listbox: RscListBox",[2,"",["-0.5 * safezoneW + safezoneX","-1 * safezoneH + safezoneY","20 * safezoneW","18 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],["idc = 2201;"]],
	[1802,"loadgame_frame",[2,"",["21 * safezoneW + safezoneX","18 * safezoneH + safezoneY","20 * safezoneW","7.5 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],["idc = 2102;"]],
	[1006,"loadgame_color",[2,"",["21 * safezoneW + safezoneX","18 * safezoneH + safezoneY","20 * safezoneW","7.5 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"parameters_frame",[2,"",["21 * safezoneW + safezoneX","-1 * safezoneH + safezoneY","20 * safezoneW","18 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],["idc = 2103;"]],
	[1007,"parameters_color",[2,"",["21 * safezoneW + safezoneX","-1 * safezoneH + safezoneY","20 * safezoneW","18 * safezoneH"],[-1,-1,-1,-1],[0.22,0.43,0.28,1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"newgame_text",[2,"New Game",["7 * safezoneW + safezoneX","17 * safezoneH + safezoneY","4.5 * safezoneW","3 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2204;"]],
	[1002,"loadgame_text",[2,"Load Game",["28 * safezoneW + safezoneX","17 * safezoneH + safezoneY","4.5 * safezoneW","3 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2205;"]],
	[1003,"parameters_text",[2,"Parameters",["28 * safezoneW + safezoneX","-2 * safezoneH + safezoneY","4.5 * safezoneW","3 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 2206;"]],
	[1400,"newgame_edit",[2,"Enter a save name",["1 * safezoneW + safezoneX","20.5 * safezoneH + safezoneY","17 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[1,1,1,1],[-1,-1,-1,-1],"Enter a save name","-1"],["idc = 2207;"]],
	[1600,"newgame_button",[2,"Start New Game",["1 * safezoneW + safezoneX","22 * safezoneH + safezoneY","17 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[0.16,0.3,0.2,1],[-1,-1,-1,-1],"","-1"],["idc = 2208;"]],
	[1601,"loadgame_button",[2,"Load Selected Save",["22 * safezoneW + safezoneX","20.5 * safezoneH + safezoneY","17 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[0.16,0.3,0.2,1],[-1,-1,-1,-1],"","-1"],["idc = 2209;"]],
	[1602,"deletegame_button",[2,"Delete Selected Save",["22 * safezoneW + safezoneX","22 * safezoneH + safezoneY","17 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[0.16,0.3,0.2,1],[-1,-1,-1,-1],"","-1"],["idc = 2210;"]]
]
*/
