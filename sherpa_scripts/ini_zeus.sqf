if (!isDedicated) then {

    ["NORD - Ивентологи", "Старт ивента", { 
        [] call nord_fnc_start;
    }] call zen_custom_modules_fnc_register;

    ["NORD - Ивентологи", "Победа РФ", { 
        [] call nord_fnc_winRus;
    }] call zen_custom_modules_fnc_register;

    ["NORD - Ивентологи", "Победа Украины", { 
        [] call nord_fnc_winUkr;
    }] call zen_custom_modules_fnc_register;
    ["NORD", "Фикс красных панелек", { 
        [] call nord_panelakFix;
    }] call zen_custom_modules_fnc_register;
} else {
    // null
};
["NORD", "Разрушить % зданий", {
    params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
	_pos = "Land_HelipadEmpty_F" createVehicle _position;
	[  
    	"Разрушить % зданий",  
    	[  
			["SLIDER","Процент разрушения",[0,100,0,0]],
			["SLIDER:RADIUS","Радиус",[0,10000,50,0,_object,[190,30,30,0.95]]]
		], 
		{  
			(_this select 0) params ["_percent", "_radius"]; 
			(_this select 1) params ["_pos"];
            _buildings = _pos nearobjects ["house", _radius];
        	{
	        	_rnd = round random 100;
        		if (_rnd > _percent) then {
		    	_x setDamage 0.9;
		        } else {
			        _x setDamage 1;
	        	};
        	} forEach _buildings;
			deleteVehicle _pos;
		},  
    	{},  
		[_pos], 
		"nord_destroyBuildings_dialog"
   ] call zen_dialog_fnc_create; 
}] call zen_custom_modules_fnc_register; 

nord_fnc_start = {
    [{
        missionNamespace setVariable ["isEvent", true, true];
        [] spawn {
            ["audio\prigo.paa"] spawn BIS_fnc_textTiles;
            titleText ["<t color='#ff0000' size='8'>ВНИМАНИЕ!</t><br/>", "PLAIN", -1, true, true];
            sleep 3;
            titleText ["<t color='#f06767' size='4'>Старт через...</t><br/>", "PLAIN", -1, true, true];
            sleep 2;
            titleText ["<t color='#69f067' size='3'>3</t><br/>", "PLAIN", -1, true, true];
            sleep 1;
            titleText ["<t color='#7567f0' size='2'>2</t><br/>", "PLAIN", -1, true, true];
            sleep 1;
            titleText ["<t color='#f09b67' size='1'>1</t><br/>", "PLAIN", -1, true, true];
            sleep 1;
            titleText ["<t color='#f06767' size='4'>В бой!</t><br/>", "PLAIN", -1, true, true];
            playSound "battle_start";
        };
    }] remoteExec ["call", -2, false];
};

nord_fnc_winRus = {
    [{
        missionNamespace setVariable ["isEvent", false, true];
        [] spawn {
            playSound "rus_victory";
            ["audio\rus_victory.paa"] spawn BIS_fnc_textTiles;
            titleText ["<t color='#ffffff' size='8'>Победа</t><t color='#1616a8' size='8'> Р<t color='#a81616' size='8'>Ф!</t></t><br/>", "PLAIN", -1, true, true];
        };
    }] remoteExec ["call", -2, false];
};

nord_fnc_winUkr = {
    [{
        missionNamespace setVariable ["isEvent", false, true];
        [] spawn {
            playSound "ukr_victory";
            ["audio\ukr_victory.paa"] spawn BIS_fnc_textTiles;
            titleText ["<t color='#1469d9' size='8'>Победа</t><t color='#d9d214' size='8'> Украины!</t><br/>", "PLAIN", -1, true, true];
        };
    }] remoteExec ["call", -2, false];
};

nord_panelakFix = {
    [{
        _panelaks = ("Land_Panelak2_ruins" allObjects 0) + ("Land_Panelak3_ruins" allObjects 0);
        {
	        _pos = getPos _x;
        	_z = _pos select 2;
        	_meters = 4;
        	if (typeOf _x == "Land_Panelak3_ruins") then {_meters = 10;};
	        _z = _z-_meters;
	        _pos set [2, _z];
	        _x setPos _pos;
        } foreach _panelaks;
    }] remoteExec ["call", 2, false];
};
