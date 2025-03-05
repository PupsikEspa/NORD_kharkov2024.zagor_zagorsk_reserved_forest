params ["_side"];

if (!isServer) exitWith{};

missionNamespace setVariable [(_side + "_pkpOpen"), true];
_timeOpened = serverTime;
missionNamespace setVariable [(_side + "_lastOpenPKP"), _timeOpened];
missionNamespace setVariable [(_side + "_canOpenPKP"), false];
_left = missionNamespace getVariable [(_side + "_pkpUsesLeft"), 100];
missionNamespace setVariable [(_side + "_pkpUsesLeft"), _left - 1];
diag_log format ["%1 PKP Opened by commander! Left: %2", _side, _left];

[{
	serverTime - (missionNamespace getVariable [(str (side player) + "_lastOpenPKP"), 0]) >= (missionNamespace getVariable ["PKP_DURATION", 0])
}, {
	_side = _this select 0;
	missionNamespace setVariable [(_side + "_pkpOpen"), false];
	diag_log format ["%1 PKP Closed by timer!", _side];
}, [_side]] call CBA_fnc_waitUntilAndExecute;

[{
	serverTime - (missionNamespace getVariable [(str (side player) + "_lastOpenPKP"), 0]) >= (missionNamespace getVariable ["PKP_DELTA", 0])
}, {
	_side = _this select 0;
	missionNamespace setVariable [(_side + "_canOpenPKP"), true];
	diag_log format ["%1 PKP can be now opened!", _side];
}, [_side]] call CBA_fnc_waitUntilAndExecute;


//canOpenPKP
//!(missionNamespace getVariable ["_pkpOpen", true]) &&
//	(serverTime - (missionNamespace getVariable [(str (side player) + "_lastOpenPKP"), 0]) >= (missionNamespace getVariable ["PKP_DELTA", 0]))