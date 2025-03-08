_playerUID = getPlayerUID player;
_sideCommanders = [ 
    "76561199786409092", /// Барон, ВС РФ
	"76561199061768748" /// Штефан, ВСУ
];


if ((side player == civilian) || (_playerUID == "76561199287760678")) then {
	VSU_openPKP = ["Открыть ПКП ВСУ", "Открыть ПКП ВСУ", "", {
		missionNamespace setVariable ["WEST_pkpOpen", true, true];
		[format ["WEST PKP Opened by curator %1!", name player]] remoteExec ["diag_log", 2];
	}, {
		!(missionNamespace getVariable ["WEST_pkpOpen", true])
	}] call ace_interact_menu_fnc_createAction;

	RF_openPKP = ["Открыть ПКП РФ", "Открыть ПКП РФ", "", {
		missionNamespace setVariable ["EAST_pkpOpen", true, true];
		[format ["EAST PKP Opened by curator %1!", name player]] remoteExec ["diag_log", 2];
	}, {
		!(missionNamespace getVariable ["EAST_pkpOpen", true])
	}] call ace_interact_menu_fnc_createAction;


	VSU_closePKP = ["Закрыть ПКП ВСУ", "Закрыть ПКП ВСУ", "", {
		missionNamespace setVariable ["WEST_pkpOpen", false, true];
		[format ["WEST PKP Closed by curator %1!", name player]] remoteExec ["diag_log", 2];
	}, {
		missionNamespace getVariable ["WEST_pkpOpen", true]
	}] call ace_interact_menu_fnc_createAction;

	RF_closePKP = ["Закрыть ПКП РФ", "Закрыть ПКП РФ", "", {
		missionNamespace setVariable ["EAST_pkpOpen", false, true];
		[format ["EAST PKP Closed by curator %1!", name player]] remoteExec ["diag_log", 2];
	}, {
		missionNamespace getVariable ["EAST_pkpOpen", true]
	}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions"], VSU_openPKP] call ace_interact_menu_fnc_addActionToObject;
	[player, 1, ["ACE_SelfActions"], RF_openPKP] call ace_interact_menu_fnc_addActionToObject;
	[player, 1, ["ACE_SelfActions"], VSU_closePKP] call ace_interact_menu_fnc_addActionToObject;
	[player, 1, ["ACE_SelfActions"], RF_closePKP] call ace_interact_menu_fnc_addActionToObject;
};

if (side player == civilian) exitWith {};
if (!(_playerUID in _sideCommanders) && (_playerUID != "76561199287760678")) exitwith {};

	_openPKP = ["Открыть ПКП", "Открыть ПКП", "", {
		[str (side player)] remoteExec ["Nord_fnc_callOpenPKP", 2];
	}, {
		!(missionNamespace getVariable [(str (side player) + "_pkpOpen"), true]) && (missionNamespace getVariable [(str (side player) + "_canOpenPKP"), true]) && ((missionNamespace getVariable [(str (side player) + "_pkpUsesLeft"), 100]) > 0)
	}] call ace_interact_menu_fnc_createAction;


	_closePKP = ["Закрыть ПКП", "Закрыть ПКП", "", {
		missionNamespace setVariable [(str (side player) + "_pkpOpen"), false, true];
		[format ["%1 PKP Closed by commander %2!", str (side player), name player]] remoteExec ["diag_log", 2];
	}, {
		missionNamespace getVariable [(str (side player) + "_pkpOpen"), true]
	}] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions"], _openPKP] call ace_interact_menu_fnc_addActionToObject;
	[player, 1, ["ACE_SelfActions"], _closePKP] call ace_interact_menu_fnc_addActionToObject;