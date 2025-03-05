if (isServer) then {
	_clientMapFPS = createHashMap;
	missionNamespace setVariable ["_clientMapFPS", _clientMapFPS, true];

	missionNamespace setVariable ["PKP_DELTA", 20, true]; //В СЕКУНДАХ, КУЛДАУН МЕЖДУ ОТКРЫТИЯМИ ПКП
	missionNamespace setVariable ["PKP_DURATION", 10, true]; //В СЕКУНДАХ, ДЛИТЕЛЬНОСТЬ ПКП
	missionNamespace setVariable ["EAST_pkpUsesLeft", 2, true]; //Количество волн для РФ; Хочется без ограничений - въебите 100+
	missionNamespace setVariable ["WEST_pkpUsesLeft", 2, true]; //Количество волн для ВСУ; Хочется без ограничений - въебите 100+
	missionNamespace setVariable ["EAST_lastOpenPKP", 0, true]; //технический параметр, не менять
	missionNamespace setVariable ["WEST_lastOpenPKP", 0, true]; //технический параметр, не менять
	missionNamespace setVariable ["CIV_pkpOpen", false, true]; //технический параметр, не менять
	missionNamespace setVariable ["EAST_pkpOpen", false, true]; //открыт ли ПКП РФ на старте миссии (не минусует волну)
	missionNamespace setVariable ["WEST_pkpOpen", false, true]; //открыт ли ПКП ВСУ на старте миссии (не минусует волну)
	missionNamespace setVariable ["EAST_canOpenPKP", true, true]; //ВСЕГДА ставьте противоположное значение от EAST_pkpOpen
	missionNamespace setVariable ["WEST_canOpenPKP", true, true]; //ВСЕГДА ставьте противоположное значение от WEST_pkpOpen

	["zen_modules_moduleCreateTeleporter_PKP", [gate_baseRF, getPosATL gate_baseRF, "БАЗА РФ"]] call CBA_fnc_serverEvent;
	["zen_modules_moduleCreateTeleporter_PKP", [gate_baseVSU, getPosATL gate_baseVSU, "БАЗА ВСУ"]] call CBA_fnc_serverEvent;

	save_var_hohol = 1;
	clean_var_hohol = 1;
	[] execVM "scripts\ehKillCrew.sqf";
	[] execVM "sherpa_scripts\detectHeight.sqf";
	[] spawn {
		execVM "sherpa_scripts\ini_markerFPS.sqf"
	};
	[] execVM "sherpa_scripts\ini_zeus.sqf";
		
		sherpa_event_kill_fix = addMissionEventHandler ["EntityKilled", {
			params ["_killed", "_killer", "_instigator"];      
					if ((_killed isKindOf "CAManBase")) then {
						_killed unassignItem "B_UavTerminal";
						_killed removeItem "B_UavTerminal";
						_killed unassignItem "O_UavTerminal";
						_killed removeItem "O_UavTerminal";
						if (side player == EAST) then {
							player addItem "O_UavTerminal";
							player assignItem "O_UavTerminal";
						};
						if (side player == WEST) then {
							player addItem "B_UavTerminal";
							player assignItem "B_UavTerminal";
						};
					};
			        _dubeKiller = name _killer;     
			        if (_killer == _killed) then {
				_killer = _killed getVariable ["ace_medical_lastDamageSource", _killer];      
				            if ((_killed isKindOf "CAManBase")) then {
					if (([side group _killed, side group _killer] call BIS_fnc_sideIsEnemy)) then {
						_killer addPlayerScores [1, 0, 0, 0, 0];
					};
				};
			} else {
				_killer
			};     
			        if (isNull _instigator) then {
				_instigator = UAVControl vehicle _killer select 0
			};      
			        if (isNull _instigator) then {
				_instigator = _killer
			};
		}];    
		publicVariableServer "sherpa_event_kill_fix";
		missionNamespace setVariable ["isEvent", false, true];
	};