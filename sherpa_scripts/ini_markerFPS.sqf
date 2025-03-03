sleep 2;

private _sourcestr = "Сервер";
private _position = 0;

sleep 2;

if (!isServer) then {
    if (isNil "HC1") exitWith {
        HC1 = true;
        publicVariable "HC1";
        _sourcestr = "HC1";
        _position = 1;
    };
    if (isNil "HC2") exitWith {
        HC2 = true;
        publicVariable "HC2";
        _sourcestr = "HC2";
        _position = 2;
    };
    if (isNil "HC3") exitWith {
        HC3 = true;
        publicVariable "HC3";
        _sourcestr = "HC3";
        _position = 3;
    };
    if (isNil "HC4") exitWith {
        HC4 = true;
        publicVariable "HC4";
        _sourcestr = "HC4";
        _position = 4;
    };
    if (isNil "HC5") exitWith {
        HC5 = true;
        publicVariable "HC5";
        _sourcestr = "HC5";
        _position = 5;
    };
};

_rusCountMarker = createMarker ["rusCount", [0,-600]];
_rusCountMarker setMarkerType "mil_start";
_rusCountMarker setMarkerSize [0.7, 0.7];
_rusCountMarker setMarkerColor "ColorEAST";

_ukrCountMarker = createMarker ["ukrCount", [0,-700]];
_ukrCountMarker setMarkerType "mil_start";
_ukrCountMarker setMarkerSize [0.7, 0.7];
_ukrCountMarker setMarkerColor "ColorWEST";

_civCountMarker = createMarker ["civCount", [0,-800]];
_civCountMarker setMarkerType "mil_start";
_civCountMarker setMarkerSize [0.7, 0.7];
_civCountMarker setMarkerColor "ColorCIV";

private _myfpsmarker = createMarker [format ["fpsmarker%1", _sourcestr], [0, -500 - (500 * _position)]];
_myfpsmarker setMarkerType "mil_start";
_myfpsmarker setMarkerSize [0.7, 0.7];

private _playerFPSmarker = createMarker ["playerFPSmarker", [0,-900]];
_playerFPSmarker setMarkerType "mil_start";
_playerFPSmarker setMarkerSize [0.7, 0.7];

_c = 0;
while {true} do {
    private _myfps = diag_fps;
    private _localgroups = {local _x} count allGroups;
    private _localunits = {local _x} count allUnits;

    _myfpsmarker setMarkerColor "ColorGREEN";
    if (_myfps < 30) then {_myfpsmarker setMarkerColor "ColorYELLOW";};
    if (_myfps < 20) then {_myfpsmarker setMarkerColor "ColorORANGE";};
    if (_myfps < 10) then {_myfpsmarker setMarkerColor "ColorRED";};

    _myfpsmarker setMarkerText format ["%1: %2 фпс / fps, %3 локальных групп / local groups, %4  локальных юнитов / local units", _sourcestr, (round (_myfps * 100.0)) / 100.0, _localgroups, _localunits];

    _rusCountMarker setMarkerText format ["ВС РФ: %1", playersNumber east];
    _ukrCountMarker setMarkerText format ["ВСУ: %1", playersNumber west];
    _civCountMarker setMarkerText format ["Администрация: %1", playersNumber civilian];

    _c = _c + 5;
    if (_c == 600) then {
        _c = 0;
        private _clientMapFPS = missionNamespace getVariable ("_clientMapFPS");
        if (count _clientMapFPS > 0) then {
            private _sumFPS = 0;
            private _sumMinFPS = 0;
            { 
                _sumFPS = _sumFPS + (_y select 0); 
                _sumMinFPS = _sumMinFPS + (_y select 1); 
            } forEach _clientMapFPS;
            private _averageFPS = (_sumFPS / (count _clientMapFPS));
            private _minimumFPS = (_sumMinFPS / (count _clientMapFPS));
            _playerFPSmarker setMarkerColor "ColorGREEN";
            if (_averageFPS < 30) then {_playerFPSmarker setMarkerColor "ColorYELLOW";};
            if (_averageFPS < 20) then {_playerFPSmarker setMarkerColor "ColorORANGE";};
            if (_averageFPS < 10) then {_playerFPSmarker setMarkerColor "ColorRED";};
            diag_log format ["FPS all players: average = %1; minimal = %2", _averageFPS, _minimumFPS];
            _playerFPSmarker setMarkerText format ["Средний клиентский FPS за последние 10 минут: %1 FPS; минимальный: %2 FPS", _averageFPS, _minimumFPS];
        };
    };

    sleep 5;
};