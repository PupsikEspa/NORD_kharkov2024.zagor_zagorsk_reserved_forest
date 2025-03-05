params ["_side"];

if (!isServer) exitWith{};

missionNamespace setVariable [(_side + "_pkpOpen"), true, true];
_timeOpened = serverTime;
missionNamespace setVariable [(_side + "_lastOpenPKP"), _timeOpened, true];
missionNamespace setVariable [(_side + "_canOpenPKP"), false, true];
_left = missionNamespace getVariable [(_side + "_pkpUsesLeft"), 100];
missionNamespace setVariable [(_side + "_pkpUsesLeft"), _left - 1, true];
diag_log format ["%1 PKP Opened by commander! Left: %2", _side, _left];

[{
	_side = _this select 0;
	serverTime - (missionNamespace getVariable [(_side + "_lastOpenPKP"), 0]) >= (missionNamespace getVariable ["PKP_DURATION", 0])
}, {
	_side = _this select 0;
	missionNamespace setVariable [(_side + "_pkpOpen"), false, true];
	diag_log format ["%1 PKP Closed by timer!", _side];
}, [_side]] call CBA_fnc_waitUntilAndExecute;

[{
	serverTime - (missionNamespace getVariable [(_side + "_lastOpenPKP"), 0]) >= (missionNamespace getVariable ["PKP_DELTA", 0])
}, {
	_side = _this select 0;
	missionNamespace setVariable [(_side + "_canOpenPKP"), true, true];
	diag_log format ["%1 PKP can be now opened!", _side];
}, [_side]] call CBA_fnc_waitUntilAndExecute;
