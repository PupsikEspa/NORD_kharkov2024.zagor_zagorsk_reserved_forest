params ["_playerFPS"];

if (!isServer) exitWith{};

_playerUnit = _playerFPS select 0;
_avgPlayerFPS = (_playerFPS select 1) select 0;
_minPlayerFPS = (_playerFPS select 1) select 1;
_snapshotCount = (_playerFPS select 1) select 2;

//if (hasInterface) then {hint format ["Average FPS %1: %2; minimal: %3", name _playerUnit, _avgPlayerFPS, _minPlayerFPS];};
diag_log format ["[%1] FPS: average = %2; minimum = %3", name _playerUnit, _avgPlayerFPS, _minPlayerFPS];

_clientMapFPS = missionNamespace getVariable ("_clientMapFPS");
_clientMapFPS set [(getPlayerUID _playerUnit), [_avgPlayerFPS, _minPlayerFPS, _snapshotCount]];
missionNamespace setVariable ["_clientMapFPS", _clientMapFPS, true];