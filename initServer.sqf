if (isServer) then {
	_clientMapFPS = createHashMap;
	missionNamespace setVariable ["_clientMapFPS", _clientMapFPS, true];
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