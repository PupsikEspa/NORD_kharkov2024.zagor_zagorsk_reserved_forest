if (isServer) exitWith{};

_clientMapFPS = missionNamespace getVariable ("_clientMapFPS");
_clFPS = _clientMapFPS getOrDefault [(getPlayerUID player), []]; 

if ((count _clFPS) < 3) then {
	_clFPS = [diag_fps, diag_fpsMin, 1];
	//systemChat format["DIAG_FPS: %1", diag_fps];
    //systemChat format["After local FPS: %1, mininal: %2, count: %3", (_clFPS select 0), (_clFPS select 1), (_clFPS select 2)];
	[[player, _clFPS]] remoteExec ["Nord_fnc_setGlobalFPS", 2];
};

localNamespace setVariable ["_clFPS", _clFPS];;

[{
	_clFPS = localNamespace getVariable ("_clFPS");
	//systemChat format["Before local FPS: %1, mininal: %2, count: %3", (_clFPS select 0), (_clFPS select 1), (_clFPS select 2)];
	_avgFPS = _clFPS select 0;
	_minFPS = _clFPS select 1;
	_snapshotCount = _clFPS select 2;
	_avgFPS = ((_avgFPS * _snapshotCount) + diag_fps) / (_snapshotCount + 1);
	_minFPS = ((_minFPS * _snapshotCount) + diag_fpsMin) / (_snapshotCount + 1);
	_snapshotCount = _snapshotCount + 1;
	_clFPS = [_avgFPS, _minFPS, _snapshotCount];
	//systemChat format["DIAG_FPS: %1", diag_fps];
    //systemChat format["After local FPS: %1, mininal: %2, count: %3", (_clFPS select 0), (_clFPS select 1), (_clFPS select 2)];
	if (_snapshotCount > 9) then {
		[[player, _clFPS]] remoteExec ["Nord_fnc_setGlobalFPS", 2];
		_clFPS = [0,0,0];
	};
	localNamespace setVariable ["_clFPS", _clFPS];;
} , 60, []] call CBA_fnc_addPerFrameHandler;